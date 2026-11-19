"""C, C++, Java, Go and Rust emitters (they share one statement walker)."""
from __future__ import annotations

import ast

from ir import BINOPS, CMPOPS, Fn, KernelError


class CLike:
    """Subclasses supply the syntax; `emit_fn` walks the IR."""

    indent = "    "
    semi = ";"
    name = "?"

    def __init__(self, fnmap: dict[str, str]):
        self.fnmap = fnmap  # raw helper name -> mangled name

    # ---- hooks (overridden) -------------------------------------------------
    def lit(self, v: int) -> str: return str(v)
    def read(self, arr: str, idx: str) -> str: raise NotImplementedError
    def write(self, arr: str, idx: str, val: str) -> str: raise NotImplementedError
    def and_(self, a, b): return f"({a} && {b})"
    def or_(self, a, b): return f"({a} || {b})"
    def not_(self, a): return f"(!{a})"
    def minmax(self, kind, a, b): raise NotImplementedError
    def call_arg(self, name: str) -> str: return name
    def if_open(self, c): return f"if ({c}) {{"
    def while_open(self, c): return f"while ({c}) {{"
    def else_open(self): return "} else {"
    def close(self): return "}"
    def decl_scalar(self, n): raise NotImplementedError
    def decl_local_array(self, n): return ""
    def alloc(self, n, size): raise NotImplementedError
    def free_lines(self, arrays): return []
    def ret(self, expr): return f"return {expr};" if expr is not None else "return;"
    def assign(self, n, e): return f"{n} = {e};"

    # ---- expressions --------------------------------------------------------
    def ex(self, n: ast.AST, fn: Fn) -> str:
        if isinstance(n, ast.Constant):
            if not isinstance(n.value, int):
                raise KernelError("only int constants")
            return self.lit(n.value)
        if isinstance(n, ast.Name):
            return n.id
        if isinstance(n, ast.BinOp):
            op = BINOPS.get(type(n.op))
            if op is None:
                raise KernelError(f"{fn.raw}: unsupported operator {type(n.op).__name__}")
            return f"({self.ex(n.left, fn)} {op} {self.ex(n.right, fn)})"
        if isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.USub):
            return f"(-{self.ex(n.operand, fn)})"
        if isinstance(n, ast.Compare):
            if len(n.ops) != 1:
                raise KernelError("chained comparison")
            return f"({self.ex(n.left, fn)} {CMPOPS[type(n.ops[0])]} {self.ex(n.comparators[0], fn)})"
        if isinstance(n, ast.BoolOp):
            parts = [self.ex(v, fn) for v in n.values]
            out = parts[0]
            for p in parts[1:]:
                out = self.and_(out, p) if isinstance(n.op, ast.And) else self.or_(out, p)
            return out
        if isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.Not):
            return self.not_(self.ex(n.operand, fn))
        if isinstance(n, ast.Subscript):
            return self.read(n.value.id, self.ex(n.slice, fn))
        if isinstance(n, ast.Call):
            f = n.func.id
            args = n.args
            if f in ("min", "max"):
                return self.minmax(f, self.ex(args[0], fn), self.ex(args[1], fn))
            rendered = []
            for a in args:
                if isinstance(a, ast.Name) and a.id in fn.arrays:
                    rendered.append(self.call_arg(a.id, fn))
                else:
                    rendered.append(self.ex(a, fn))
            return f"{self.fnmap[f]}({', '.join(rendered)})"
        raise KernelError(f"{fn.raw}: unsupported expression {ast.dump(n)[:60]}")

    def call_arg(self, name, fn):  # noqa: F811 - default: pass by name
        return name

    # ---- statements ---------------------------------------------------------
    def emit_fn(self, fn: Fn, public: bool = False) -> list[str]:
        self.tmp_count = 0
        self.temps: list[str] = []
        self.uses_swap = False
        self.fn = fn
        body: list[str] = []
        self.stmts(fn.body, body, 1, fn)
        out = [self.fn_open(fn, public)]
        ind = self.indent
        for n in fn.scalars + self.temps:
            out.append(ind + self.decl_scalar(n))
        if self.uses_swap:
            for n in ["_i1", "_i2", "_t1"]:
                out.append(ind + self.decl_scalar(n))
        for n in fn.local_arrays:
            d = self.decl_local_array(n)
            if d:
                out.append(ind + d)
        out += self.post_decls(fn)
        out += body
        out += self.fn_end(fn)
        out.append(self.close())
        return out

    def post_decls(self, fn):
        return []

    def fn_end(self, fn):
        return [self.indent + l for l in self.free_lines(fn.local_arrays)]

    def stmts(self, stmts, out, lvl, fn):
        pad = self.indent * lvl
        for s in stmts:
            if isinstance(s, ast.Assign):
                t = s.targets[0]
                if isinstance(t, ast.Name):
                    if isinstance(s.value, ast.Call) and getattr(s.value.func, "id", "") == "new_array":
                        out.append(pad + self.alloc(t.id, self.ex(s.value.args[0], fn)))
                    else:
                        out.append(pad + self.assign(t.id, self.ex(s.value, fn)))
                else:
                    out.append(pad + self.write(t.value.id, self.ex(t.slice, fn), self.ex(s.value, fn)))
            elif isinstance(s, ast.AugAssign):
                op = BINOPS[type(s.op)]
                if isinstance(s.target, ast.Name):
                    out.append(pad + self.assign(s.target.id, f"({s.target.id} {op} {self.ex(s.value, fn)})"))
                else:
                    arr, idx = s.target.value.id, self.ex(s.target.slice, fn)
                    out.append(pad + self.write(arr, idx, f"({self.read(arr, idx)} {op} {self.ex(s.value, fn)})"))
            elif isinstance(s, ast.If):
                out.append(pad + self.if_open(self.ex(s.test, fn)))
                self.stmts(s.body, out, lvl + 1, fn)
                if s.orelse:
                    out.append(pad + self.else_open())
                    self.stmts(s.orelse, out, lvl + 1, fn)
                out.append(pad + self.close())
            elif isinstance(s, ast.While):
                out.append(pad + self.while_open(self.ex(s.test, fn)))
                self.stmts(s.body, out, lvl + 1, fn)
                out.append(pad + self.close())
            elif isinstance(s, ast.For):
                self.tmp_count += 1
                e = f"_e{self.tmp_count}"
                self.temps.append(e)
                a = s.iter.args
                start, stop = (self.ex(a[0], fn), self.ex(a[1], fn))
                v = s.target.id
                out.append(pad + self.assign(v, start))
                out.append(pad + self.assign(e, stop))
                out.append(pad + self.while_open(f"({v} < {e})"))
                self.stmts(s.body, out, lvl + 1, fn)
                out.append(pad + self.indent + self.assign(v, f"({v} + 1)"))
                out.append(pad + self.close())
            elif isinstance(s, ast.Return):
                frees = self.free_lines(fn.local_arrays)
                val = self.ex(s.value, fn) if s.value is not None else None
                if frees:
                    out.append(pad + "{")
                    for l in frees:
                        out.append(pad + self.indent + l)
                    out.append(pad + self.indent + self.ret(val))
                    out.append(pad + "}")
                else:
                    out.append(pad + self.ret(val))
            elif isinstance(s, ast.Expr) and isinstance(s.value, ast.Call):
                c = s.value
                if c.func.id == "swap":
                    self.uses_swap = True
                    arr = c.args[0].id
                    out.append(pad + self.assign("_i1", self.ex(c.args[1], fn)))
                    out.append(pad + self.assign("_i2", self.ex(c.args[2], fn)))
                    out.append(pad + self.assign("_t1", self.read(arr, "_i1")))
                    out.append(pad + self.write(arr, "_i1", self.read(arr, "_i2")))
                    out.append(pad + self.write(arr, "_i2", "_t1"))
                else:
                    out.append(pad + self.ex(c, fn) + self.semi)
            elif isinstance(s, ast.Pass):
                pass
            else:
                raise KernelError(f"{fn.raw}: unsupported statement {type(s).__name__}")


# ======================================================================================
class C(CLike):
    name = "c"
    ext = "c"

    def lit(self, v): return str(v) + ("LL" if abs(v) > 2**31 - 1 else "")
    def read(self, arr, idx): return f"((int64_t){arr}[{idx}])"
    def write(self, arr, idx, val): return f"{arr}[{idx}] = (int32_t)({val});"
    def minmax(self, k, a, b): return f"k_{k}({a}, {b})"
    def decl_scalar(self, n): return f"int64_t {n} = 0;"
    def decl_local_array(self, n): return f"int32_t *{n} = NULL;"
    def alloc(self, n, size): return f"{n} = (int32_t *)calloc((size_t)k_max(1, {size}), sizeof(int32_t));"
    def free_lines(self, arrays): return [f"free({n});" for n in arrays]

    def fn_open(self, fn, public=False):
        ps = ", ".join(f"int32_t *{n}" if k == "arr" else f"int64_t {n}" for n, k in fn.params)
        return f"static {'int64_t' if fn.returns_int else 'void'} {fn.name}({ps}) {{"

    def proto(self, fn):
        return self.fn_open(fn)[:-2] + ";"


class CPP(C):
    name = "cpp"
    ext = "hpp"

    def decl_local_array(self, n): return f"std::vector<int32_t> {n};"
    def alloc(self, n, size): return f"{n}.assign((size_t)k_max(1, {size}), 0);"
    def free_lines(self, arrays): return []
    def minmax(self, k, a, b): return f"k_{k}({a}, {b})"

    def call_arg(self, name, fn):
        return f"{name}.data()" if name in fn.local_arrays else name

    def fn_open(self, fn, public=False):
        ps = ", ".join(f"int32_t *{n}" if k == "arr" else f"int64_t {n}" for n, k in fn.params)
        return f"inline {'int64_t' if fn.returns_int else 'void'} {fn.name}({ps}) {{"


class Java(CLike):
    name = "java"
    ext = "java"

    def lit(self, v): return f"{v}L"
    def read(self, arr, idx): return f"((long){arr}[(int)({idx})])"
    def write(self, arr, idx, val): return f"{arr}[(int)({idx})] = (int)({val});"
    def minmax(self, k, a, b): return f"Math.{k}({a}, {b})"
    def decl_scalar(self, n): return f"long {n} = 0;"
    def decl_local_array(self, n): return f"int[] {n} = null;"
    def alloc(self, n, size): return f"{n} = new int[(int)Math.max(1L, {size})];"

    def fn_open(self, fn, public=False):
        ps = ", ".join(f"int[] {n}" if k == "arr" else f"long {n}" for n, k in fn.params)
        return f"    static {'long' if fn.returns_int else 'void'} {fn.name}({ps}) {{"

    def close(self): return "}"


class Go(CLike):
    name = "go"
    ext = "go"
    indent = "\t"
    semi = ""

    def lit(self, v): return str(v)
    def read(self, arr, idx): return f"int64({arr}[{idx}])"
    def write(self, arr, idx, val): return f"{arr}[{idx}] = int({val})"
    def minmax(self, k, a, b): return f"k_{k}({a}, {b})"
    def not_(self, a): return f"(!{a})"
    def decl_scalar(self, n): return f"var {n} int64\n\t_ = {n}"
    def decl_local_array(self, n): return f"var {n} []int\n\t_ = {n}"
    def alloc(self, n, size): return f"{n} = make([]int, int(k_max(1, {size})))"
    def ret(self, expr): return f"return {expr}" if expr is not None else "return"
    def assign(self, n, e): return f"{n} = {e}"
    def if_open(self, c): return f"if {c} {{"
    def while_open(self, c): return f"for {c} {{"

    def fn_open(self, fn, public=False):
        ps = ", ".join(f"{n} []int" if k == "arr" else f"{n} int64" for n, k in fn.params)
        return f"func {fn.name}({ps}){' int64' if fn.returns_int else ''} {{"


class Rust(CLike):
    name = "rust"
    ext = "rs"
    semi = ";"

    def lit(self, v): return str(v)
    def read(self, arr, idx): return f"({arr}[({idx}) as usize] as i64)"
    def write(self, arr, idx, val): return f"{arr}[({idx}) as usize] = ({val}) as i32;"
    def minmax(self, k, a, b): return f"std::cmp::{k}({a}, {b})"
    def decl_scalar(self, n): return f"let mut {n}: i64 = 0;"
    def decl_local_array(self, n): return ""
    def alloc(self, n, size):
        return (f"let mut {n}_store: Vec<i32> = vec![0; std::cmp::max(1, {size}) as usize]; "
                f"let {n}: &mut [i32] = &mut {n}_store[..];")
    def if_open(self, c): return f"if {c} {{"
    def while_open(self, c): return f"while {c} {{"

    def fn_open(self, fn, public=False):
        ps = ", ".join(f"{n}: &mut [i32]" if k == "arr" else f"mut {n}: i64" for n, k in fn.params)
        pub = "pub " if public else ""
        return f"{pub}fn {fn.name}({ps}){' -> i64' if fn.returns_int else ''} {{"
