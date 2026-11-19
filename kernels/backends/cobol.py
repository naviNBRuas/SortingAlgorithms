"""GnuCOBOL (free format) backend.

COBOL has no expressions in subscripts, no break/continue and no dynamic arrays, so the kernel AST is lowered to
straight-line COMPUTE/MOVE statements over fresh temporaries; short-circuit conditions become flag variables;
`while` becomes an infinite inline PERFORM with EXIT PERFORM. Every kernel function becomes a RECURSIVE
program: integers are passed BY VALUE, arrays BY REFERENCE, results via RETURNING. Arrays are fixed-capacity
tables (65536 elements, or the literal size for constant-size arrays); the very wide-range fallbacks in the
distribution sorts use a smaller threshold (60000 instead of 4000000) so their tables fit.

NOTE: generated without access to a COBOL compiler in the authoring environment - see cobol/README.md.
"""
from __future__ import annotations

import ast

from ir import BINOPS, CMPOPS, Fn, KernelError

CAP = 65536
COBOL_CMP = {"==": "=", "!=": "NOT =", "<": "<", "<=": "<=", ">": ">", ">=": ">="}


def hy(s: str) -> str:
    return s.replace("_", "-")


class Cobol:
    def __init__(self, fnmap: dict[str, str]):
        self.fnmap = fnmap

    # ---- naming -------------------------------------------------------------
    def v(self, n): return "v-" + hy(n)
    def t(self, n): return "t-" + hy(n)
    def te(self, n): return "t-" + hy(n) + "-e"

    def new_w(self):
        self.nw += 1
        return f"w-{self.nw}"

    def new_f(self):
        self.nf += 1
        return f"f-{self.nf}"

    # ---- expressions: return an operand, emitting statements into `out` -----
    def cx(self, n, fn, out, ind):
        if isinstance(n, ast.Constant):
            v = 60000 if n.value == 4000000 else n.value
            if v < 0:
                w = self.new_w()
                out.append(f"{ind}MOVE {v} TO {w}")
                return w
            return str(v)
        if isinstance(n, ast.Name):
            return self.v(n.id)
        if isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.USub):
            o = self.cx(n.operand, fn, out, ind)
            w = self.new_w()
            out.append(f"{ind}COMPUTE {w} = 0 - {o}")
            return w
        if isinstance(n, ast.BinOp):
            l = self.cx(n.left, fn, out, ind)
            r = self.cx(n.right, fn, out, ind)
            w = self.new_w()
            op = BINOPS[type(n.op)]
            if op == "/":
                out.append(f"{ind}COMPUTE {w} = FUNCTION INTEGER-PART({l} / {r})")
            elif op == "%":
                out.append(f"{ind}COMPUTE {w} = FUNCTION MOD({l}, {r})")
            else:
                out.append(f"{ind}COMPUTE {w} = {l} {op} {r}")
            return w
        if isinstance(n, ast.Subscript):
            i = self.cx(n.slice, fn, out, ind)
            s = self.new_w()
            w = self.new_w()
            out.append(f"{ind}COMPUTE {s} = {i} + 1")
            out.append(f"{ind}MOVE {self.te(n.value.id)}({s}) TO {w}")
            return w
        if isinstance(n, (ast.Compare, ast.BoolOp)) or (isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.Not)):
            f = self.new_f()
            self.cond(n, fn, out, ind, f)
            return f
        if isinstance(n, ast.Call):
            name = n.func.id
            if name in ("min", "max"):
                a = self.cx(n.args[0], fn, out, ind)
                b = self.cx(n.args[1], fn, out, ind)
                w = self.new_w()
                cmpop = "<" if name == "min" else ">"
                out.append(f"{ind}IF {a} {cmpop} {b}")
                out.append(f"{ind}    MOVE {a} TO {w}")
                out.append(f"{ind}ELSE")
                out.append(f"{ind}    MOVE {b} TO {w}")
                out.append(f"{ind}END-IF")
                return w
            call, w = self.call(n, fn, out, ind, want=True)
            return w
        raise KernelError(f"{fn.raw}: unsupported expression {type(n).__name__}")

    def call(self, n, fn, out, ind, want):
        parts = []
        for a in n.args:
            if isinstance(a, ast.Name) and a.id in fn.arrays:
                parts.append("BY REFERENCE " + self.t(a.id))
            else:
                parts.append("BY VALUE " + self.cx(a, fn, out, ind))
        w = self.new_w() if want else None
        ret = f" RETURNING {w}" if want else ""
        out.append(f'{ind}CALL "{hy(self.fnmap[n.func.id])}" USING {" ".join(parts)}{ret}')
        out.append(f"{ind}END-CALL")
        return None, w

    def cond(self, n, fn, out, ind, f):
        if isinstance(n, ast.Compare):
            l = self.cx(n.left, fn, out, ind)
            r = self.cx(n.comparators[0], fn, out, ind)
            op = COBOL_CMP[CMPOPS[type(n.ops[0])]]
            out.append(f"{ind}IF {l} {op} {r}")
            out.append(f"{ind}    MOVE 1 TO {f}")
            out.append(f"{ind}ELSE")
            out.append(f"{ind}    MOVE 0 TO {f}")
            out.append(f"{ind}END-IF")
        elif isinstance(n, ast.BoolOp):
            self.cond(n.values[0], fn, out, ind, f)
            for v in n.values[1:]:
                out.append(f"{ind}IF {f} = {1 if isinstance(n.op, ast.And) else 0}")
                self.cond(v, fn, out, ind + "    ", f)
                out.append(f"{ind}END-IF")
        elif isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.Not):
            self.cond(n.operand, fn, out, ind, f)
            out.append(f"{ind}COMPUTE {f} = 1 - {f}")
        else:
            o = self.cx(n, fn, out, ind)
            out.append(f"{ind}IF {o} NOT = 0")
            out.append(f"{ind}    MOVE 1 TO {f}")
            out.append(f"{ind}ELSE")
            out.append(f"{ind}    MOVE 0 TO {f}")
            out.append(f"{ind}END-IF")

    # ---- statements -----------------------------------------------------------
    def stmts(self, ss, fn, out, ind):
        for s in ss:
            if isinstance(s, ast.Assign):
                t = s.targets[0]
                if isinstance(t, ast.Name):
                    if isinstance(s.value, ast.Call) and getattr(s.value.func, "id", "") == "new_array":
                        out.append(f"{ind}INITIALIZE {self.t(t.id)}")
                    else:
                        o = self.cx(s.value, fn, out, ind)
                        out.append(f"{ind}MOVE {o} TO {self.v(t.id)}")
                else:
                    self.store(t, s.value, fn, out, ind)
            elif isinstance(s, ast.AugAssign):
                node = ast.BinOp(left=ast.Name(id=s.target.id) if isinstance(s.target, ast.Name) else s.target, op=s.op, right=s.value)
                if isinstance(s.target, ast.Name):
                    o = self.cx(node, fn, out, ind)
                    out.append(f"{ind}MOVE {o} TO {self.v(s.target.id)}")
                else:
                    self.store(s.target, node, fn, out, ind)
            elif isinstance(s, ast.If):
                f = self.new_f()
                self.cond(s.test, fn, out, ind, f)
                out.append(f"{ind}IF {f} = 1")
                self.stmts(s.body, fn, out, ind + "    ")
                if s.orelse:
                    out.append(f"{ind}ELSE")
                    self.stmts(s.orelse, fn, out, ind + "    ")
                out.append(f"{ind}END-IF")
            elif isinstance(s, ast.While):
                f = self.new_f()
                out.append(f"{ind}PERFORM UNTIL 1 = 2")
                self.cond(s.test, fn, out, ind + "    ", f)
                out.append(f"{ind}    IF {f} = 0")
                out.append(f"{ind}        EXIT PERFORM")
                out.append(f"{ind}    END-IF")
                self.stmts(s.body, fn, out, ind + "    ")
                out.append(f"{ind}END-PERFORM")
            elif isinstance(s, ast.For):
                v = self.v(s.target.id)
                a = s.iter.args
                start = self.cx(a[0], fn, out, ind)
                stop = self.cx(a[1], fn, out, ind)
                e = self.new_w()
                out.append(f"{ind}MOVE {start} TO {v}")
                out.append(f"{ind}MOVE {stop} TO {e}")
                out.append(f"{ind}PERFORM UNTIL 1 = 2")
                out.append(f"{ind}    IF {v} >= {e}")
                out.append(f"{ind}        EXIT PERFORM")
                out.append(f"{ind}    END-IF")
                self.stmts(s.body, fn, out, ind + "    ")
                out.append(f"{ind}    ADD 1 TO {v}")
                out.append(f"{ind}END-PERFORM")
            elif isinstance(s, ast.Return):
                if s.value is not None:
                    o = self.cx(s.value, fn, out, ind)
                    out.append(f"{ind}MOVE {o} TO r-val")
                out.append(f"{ind}GOBACK")
            elif isinstance(s, ast.Expr) and isinstance(s.value, ast.Call):
                c = s.value
                if c.func.id == "swap":
                    arr = self.te(c.args[0].id)
                    i = self.cx(c.args[1], fn, out, ind)
                    j = self.cx(c.args[2], fn, out, ind)
                    a, b, t = self.new_w(), self.new_w(), self.new_w()
                    out += [f"{ind}COMPUTE {a} = {i} + 1", f"{ind}COMPUTE {b} = {j} + 1",
                            f"{ind}MOVE {arr}({a}) TO {t}", f"{ind}MOVE {arr}({b}) TO {arr}({a})", f"{ind}MOVE {t} TO {arr}({b})"]
                else:
                    self.call(c, fn, out, ind, want=False)
            elif isinstance(s, ast.Pass):
                pass
            else:
                raise KernelError(f"{fn.raw}: unsupported statement {type(s).__name__}")

    def store(self, target, value, fn, out, ind):
        val = self.cx(value, fn, out, ind)
        idx = self.cx(target.slice, fn, out, ind)
        s = self.new_w()
        out.append(f"{ind}COMPUTE {s} = {idx} + 1")
        out.append(f"{ind}MOVE {val} TO {self.te(target.value.id)}({s})")

    # ---- one function = one program -------------------------------------------
    def program(self, fn: Fn, is_entry: bool) -> list[str]:
        self.nw = 0
        self.nf = 0
        body: list[str] = []
        self.stmts(fn.body, fn, body, "    ")
        name = hy(fn.stem) if is_entry else hy(fn.name)
        out = ["IDENTIFICATION DIVISION.", f"PROGRAM-ID. {name} IS RECURSIVE.", "DATA DIVISION.", "LOCAL-STORAGE SECTION."]
        for n in fn.scalars:
            out.append(f"01 {self.v(n)} USAGE BINARY-DOUBLE SIGNED.")
        for i in range(1, self.nw + 1):
            out.append(f"01 w-{i} USAGE BINARY-DOUBLE SIGNED.")
        for i in range(1, self.nf + 1):
            out.append(f"01 f-{i} USAGE BINARY-DOUBLE SIGNED.")
        sizes = {}
        for s in fn.body:
            if isinstance(s, ast.Assign) and isinstance(s.value, ast.Call) and getattr(s.value.func, "id", "") == "new_array":
                a0 = s.value.args[0]
                sizes[s.targets[0].id] = a0.value if isinstance(a0, ast.Constant) else CAP
        for n in fn.local_arrays:
            out.append(f"01 {self.t(n)}.")
            out.append(f"    05 {self.te(n)} USAGE BINARY-LONG SIGNED OCCURS {sizes.get(n, CAP)} TIMES.")
        out.append("LINKAGE SECTION.")
        using = []
        for n, kind in fn.params:
            if kind == "arr":
                out.append(f"01 {self.t(n)}.")
                out.append(f"    05 {self.te(n)} USAGE BINARY-LONG SIGNED OCCURS {CAP} TIMES.")
                using.append("BY REFERENCE " + self.t(n))
            else:
                out.append(f"01 {self.v(n)} USAGE BINARY-DOUBLE SIGNED.")
                using.append("BY VALUE " + self.v(n))
        if fn.returns_int:
            out.append("01 r-val USAGE BINARY-DOUBLE SIGNED.")
        ret = " RETURNING r-val" if fn.returns_int else ""
        out.append(f"PROCEDURE DIVISION USING {' '.join(using)}{ret}.")
        out += body
        out.append("    GOBACK.")
        out.append(f"END PROGRAM {name}.")
        out.append("")
        return out


def compile_kernel(stem: str, fns: list[Fn], entry: Fn, banner: str) -> str:
    g = Cobol({f.raw: f.name for f in fns})
    out = [f"      *> {banner}", ">>SOURCE FORMAT FREE", ""]
    for f in fns:
        if f is not entry:
            out += g.program(f, False)
    out += g.program(entry, True)
    return "\n".join(out) + "\n"
