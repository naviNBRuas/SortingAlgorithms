"""x86-64 (System V, GNU as Intel syntax) backend: a deliberately simple, unoptimised compiler.

Every variable lives in a stack slot; expressions evaluate into rax with push/pop for temporaries;
arrays are pointers to int32 data; `new_array` uses the asm_alloc/asm_free mmap helpers from util.s.
No libc, no calls except to sibling kernels and asm_alloc/asm_free.
"""
from __future__ import annotations

import ast

from ir import CMPOPS, Fn, KernelError

JCC = {"==": "je", "!=": "jne", "<": "jl", "<=": "jle", ">": "jg", ">=": "jge"}
INV = {"==": "!=", "!=": "==", "<": ">=", "<=": ">", ">": "<=", ">=": "<"}
ARGREGS = ["rdi", "rsi", "rdx", "rcx", "r8", "r9"]


class X86:
    def __init__(self, fnmap: dict[str, str], entry_symbol: str, stem: str):
        self.fnmap = fnmap
        self.entry_symbol = entry_symbol
        self.stem = stem
        self.label_n = 0

    def label(self, hint="L"):
        self.label_n += 1
        return f".L{self.stem}_{hint}{self.label_n}"

    # ------------------------------------------------------------------ expressions
    def ex(self, n: ast.AST, fn: Fn, out: list[str]):
        e = out.append
        if isinstance(n, ast.Constant):
            v = n.value
            e(f"    mov rax, {v}")
        elif isinstance(n, ast.Name):
            e(f"    mov rax, [rbp - {self.slot[n.id]}]")
        elif isinstance(n, ast.BinOp):
            self.ex(n.left, fn, out)
            e("    push rax")
            self.ex(n.right, fn, out)
            e("    mov rcx, rax")
            e("    pop rax")
            op = type(n.op)
            if op is ast.Add:
                e("    add rax, rcx")
            elif op is ast.Sub:
                e("    sub rax, rcx")
            elif op is ast.Mult:
                e("    imul rax, rcx")
            elif op is ast.FloorDiv:
                e("    cqo")
                e("    idiv rcx")
            elif op is ast.Mod:
                e("    cqo")
                e("    idiv rcx")
                e("    mov rax, rdx")
            else:
                raise KernelError(f"{fn.raw}: operator {op.__name__}")
        elif isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.USub):
            self.ex(n.operand, fn, out)
            e("    neg rax")
        elif isinstance(n, ast.Subscript):
            self.ex(n.slice, fn, out)
            e(f"    mov rcx, [rbp - {self.slot[n.value.id]}]")
            e("    movsxd rax, dword ptr [rcx + rax*4]")
        elif isinstance(n, ast.Call):
            f = n.func.id
            if f in ("min", "max"):
                self.ex(n.args[0], fn, out)
                e("    push rax")
                self.ex(n.args[1], fn, out)
                e("    pop rcx")
                e("    cmp rcx, rax")
                e(f"    {'cmovl' if f == 'min' else 'cmovg'} rax, rcx")
            else:
                for a in n.args:
                    self.ex(a, fn, out)
                    e("    push rax")
                for r in reversed(ARGREGS[: len(n.args)]):
                    e(f"    pop {r}")
                e(f"    call {self.fnmap[f]}")
        elif isinstance(n, (ast.Compare, ast.BoolOp)) or (isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.Not)):
            t, f_, end = self.label("t"), self.label("f"), self.label("e")
            self.cond(n, fn, out, t, f_)
            e(f"{t}:")
            e("    mov rax, 1")
            e(f"    jmp {end}")
            e(f"{f_}:")
            e("    xor eax, eax")
            e(f"{end}:")
        else:
            raise KernelError(f"{fn.raw}: unsupported expression {type(n).__name__}")

    def cond(self, n: ast.AST, fn: Fn, out: list[str], lt: str, lf: str):
        e = out.append
        if isinstance(n, ast.Compare):
            self.ex(n.left, fn, out)
            e("    push rax")
            self.ex(n.comparators[0], fn, out)
            e("    mov rcx, rax")
            e("    pop rax")
            e("    cmp rax, rcx")
            e(f"    {JCC[CMPOPS[type(n.ops[0])]]} {lt}")
            e(f"    jmp {lf}")
        elif isinstance(n, ast.BoolOp):
            vals = n.values
            for i, v in enumerate(vals):
                last = i == len(vals) - 1
                nxt = self.label("n")
                if isinstance(n.op, ast.And):
                    self.cond(v, fn, out, lt if last else nxt, lf)
                else:
                    self.cond(v, fn, out, lt, lf if last else nxt)
                if not last:
                    e(f"{nxt}:")
        elif isinstance(n, ast.UnaryOp) and isinstance(n.op, ast.Not):
            self.cond(n.operand, fn, out, lf, lt)
        else:
            self.ex(n, fn, out)
            e("    test rax, rax")
            e(f"    jne {lt}")
            e(f"    jmp {lf}")

    # ------------------------------------------------------------------ statements
    def stmts(self, ss, fn: Fn, out: list[str]):
        e = out.append
        for s in ss:
            if isinstance(s, ast.Assign):
                t = s.targets[0]
                if isinstance(t, ast.Name):
                    if isinstance(s.value, ast.Call) and getattr(s.value.func, "id", "") == "new_array":
                        self.ex(s.value.args[0], fn, out)
                        ok = self.label("sz")
                        e("    cmp rax, 1")
                        e(f"    jge {ok}")
                        e("    mov eax, 1")
                        e(f"{ok}:")
                        e("    shl rax, 2")
                        e(f"    mov [rbp - {self.bytes_slot[t.id]}], rax")
                        e("    mov rdi, rax")
                        e("    call asm_alloc")
                        e(f"    mov [rbp - {self.slot[t.id]}], rax")
                    else:
                        self.ex(s.value, fn, out)
                        e(f"    mov [rbp - {self.slot[t.id]}], rax")
                else:
                    self.store(t, s.value, fn, out)
            elif isinstance(s, ast.AugAssign):
                node = ast.BinOp(left=s.target if not isinstance(s.target, ast.Name) else ast.Name(id=s.target.id), op=s.op, right=s.value)
                if isinstance(s.target, ast.Name):
                    self.ex(node, fn, out)
                    e(f"    mov [rbp - {self.slot[s.target.id]}], rax")
                else:
                    self.store(s.target, node, fn, out)
            elif isinstance(s, ast.If):
                lt, lf, end = self.label("then"), self.label("else"), self.label("endif")
                self.cond(s.test, fn, out, lt, lf)
                e(f"{lt}:")
                self.stmts(s.body, fn, out)
                if s.orelse:
                    e(f"    jmp {end}")
                    e(f"{lf}:")
                    self.stmts(s.orelse, fn, out)
                    e(f"{end}:")
                else:
                    e(f"{lf}:")
            elif isinstance(s, ast.While):
                top, body, end = self.label("wtop"), self.label("wbody"), self.label("wend")
                e(f"{top}:")
                self.cond(s.test, fn, out, body, end)
                e(f"{body}:")
                self.stmts(s.body, fn, out)
                e(f"    jmp {top}")
                e(f"{end}:")
            elif isinstance(s, ast.For):
                v = s.target.id
                a = s.iter.args
                endslot = self.slot[f"_end{id(s)}"]
                self.ex(a[0], fn, out)
                e(f"    mov [rbp - {self.slot[v]}], rax")
                self.ex(a[1], fn, out)
                e(f"    mov [rbp - {endslot}], rax")
                top, body, end = self.label("ftop"), self.label("fbody"), self.label("fend")
                e(f"{top}:")
                e(f"    mov rax, [rbp - {self.slot[v]}]")
                e(f"    cmp rax, [rbp - {endslot}]")
                e(f"    jl {body}")
                e(f"    jmp {end}")
                e(f"{body}:")
                self.stmts(s.body, fn, out)
                e(f"    inc qword ptr [rbp - {self.slot[v]}]")
                e(f"    jmp {top}")
                e(f"{end}:")
            elif isinstance(s, ast.Return):
                if s.value is not None:
                    self.ex(s.value, fn, out)
                e(f"    jmp {self.ret_label}")
            elif isinstance(s, ast.Expr) and isinstance(s.value, ast.Call):
                c = s.value
                if c.func.id == "swap":
                    self.ex(c.args[1], fn, out)
                    e("    push rax")
                    self.ex(c.args[2], fn, out)
                    e("    mov rdx, rax")
                    e("    pop rsi")
                    e(f"    mov rcx, [rbp - {self.slot[c.args[0].id]}]")
                    e("    mov eax, [rcx + rsi*4]")
                    e("    mov r8d, [rcx + rdx*4]")
                    e("    mov [rcx + rsi*4], r8d")
                    e("    mov [rcx + rdx*4], eax")
                else:
                    self.ex(c, fn, out)
            elif isinstance(s, ast.Pass):
                pass
            else:
                raise KernelError(f"{fn.raw}: unsupported statement {type(s).__name__}")

    def store(self, target: ast.Subscript, value: ast.AST, fn: Fn, out: list[str]):
        e = out.append
        self.ex(value, fn, out)
        e("    push rax")
        self.ex(target.slice, fn, out)
        e(f"    mov rcx, [rbp - {self.slot[target.value.id]}]")
        e("    pop rdx")
        e("    mov [rcx + rax*4], edx")

    # ------------------------------------------------------------------ functions
    def emit_fn(self, fn: Fn, is_entry: bool) -> list[str]:
        self.slot: dict[str, int] = {}
        self.bytes_slot: dict[str, int] = {}
        off = 0

        def alloc(name):
            nonlocal off
            off += 8
            self.slot[name] = off

        for n, _ in fn.params:
            alloc(n)
        for n in fn.scalars:
            alloc(n)
        for n in fn.local_arrays:
            alloc(n)
        for n in fn.local_arrays:
            off += 8
            self.bytes_slot[n] = off
        for s in _walk_fors(fn.body):
            alloc(f"_end{id(s)}")
        frame = (off + 15) // 16 * 16
        name = self.entry_symbol if is_entry else fn.name
        self.ret_label = self.label("ret")
        out = []
        if is_entry:
            out.append(f".globl {name}")
        out.append(f"{name}:")
        out += ["    push rbp", "    mov rbp, rsp", f"    sub rsp, {frame}"]
        for i, (n, _) in enumerate(fn.params):
            out.append(f"    mov [rbp - {self.slot[n]}], {ARGREGS[i]}")
        for n in fn.local_arrays:
            out.append(f"    mov qword ptr [rbp - {self.slot[n]}], 0")
        self.stmts(fn.body, fn, out)
        out.append("    xor eax, eax")
        out.append(f"{self.ret_label}:")
        if fn.local_arrays:
            out.append("    push rax")
            for n in fn.local_arrays:
                skip = self.label("nofree")
                out += [f"    mov rdi, [rbp - {self.slot[n]}]", "    test rdi, rdi", f"    jz {skip}",
                        f"    mov rsi, [rbp - {self.bytes_slot[n]}]", "    call asm_free", f"{skip}:"]
            out.append("    pop rax")
        out += ["    leave", "    ret", ""]
        return out


def _walk_fors(stmts):
    for s in stmts:
        if isinstance(s, ast.For):
            yield s
            yield from _walk_fors(s.body)
        elif isinstance(s, (ast.While,)):
            yield from _walk_fors(s.body)
        elif isinstance(s, ast.If):
            yield from _walk_fors(s.body)
            yield from _walk_fors(s.orelse)


def compile_kernel(stem: str, fns: list[Fn], entry: Fn, banner: str) -> str:
    fnmap = {f.raw: f.name for f in fns}
    g = X86(fnmap, f"{stem}_asm", stem)
    out = [f"# {banner}", ".intel_syntax noprefix", ".text", ""]
    ordered = [entry] + [f for f in fns if f is not entry]
    for f in ordered:
        out += g.emit_fn(f, f is entry)
    out.append('.section .note.GNU-stack,"",@progbits')
    return "\n".join(out) + "\n"
