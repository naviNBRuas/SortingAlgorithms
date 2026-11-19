"""Parse a kernel file into a small checked IR shared by every backend."""
from __future__ import annotations

import ast
import os

HERE = os.path.dirname(os.path.abspath(__file__))
ALGO_DIR = os.path.join(HERE, "algos")

BINOPS = {ast.Add: "+", ast.Sub: "-", ast.Mult: "*", ast.FloorDiv: "/", ast.Mod: "%"}
CMPOPS = {ast.Eq: "==", ast.NotEq: "!=", ast.Lt: "<", ast.LtE: "<=", ast.Gt: ">", ast.GtE: ">="}


class KernelError(Exception):
    pass


class Fn:
    def __init__(self, node: ast.FunctionDef, stem: str):
        self.node = node
        self.raw = node.name
        self.stem = stem
        self.is_entry = node.name == stem
        self.name = f"{stem}_impl" if self.is_entry else f"{stem}_x_{node.name}"
        self.params = []
        for a in node.args.args:
            kind = "arr" if (isinstance(a.annotation, ast.Name) and a.annotation.id == "Arr") else "int"
            self.params.append((a.arg, kind))
        self.returns_int = isinstance(node.returns, ast.Name) and node.returns.id == "int"
        self.body = [s for s in node.body if not (isinstance(s, ast.Expr) and isinstance(s.value, ast.Constant))]
        self.local_arrays: list[str] = []
        self.scalars: list[str] = []
        self.arrays = {n for n, k in self.params if k == "arr"}
        self._analyse(self.body, top=True)

    def _add_scalar(self, n):
        if n not in self.scalars and n not in [p for p, _ in self.params] and n not in self.local_arrays:
            self.scalars.append(n)

    def _analyse(self, stmts, top=False):
        for s in stmts:
            if isinstance(s, ast.Assign):
                if len(s.targets) != 1:
                    raise KernelError("multiple assignment targets")
                t = s.targets[0]
                if isinstance(t, ast.Name):
                    if isinstance(s.value, ast.Call) and getattr(s.value.func, "id", "") == "new_array":
                        if not top:
                            raise KernelError(f"{self.raw}: new_array must be a top-level statement")
                        if t.id not in self.local_arrays:
                            self.local_arrays.append(t.id)
                            self.arrays.add(t.id)
                    else:
                        self._add_scalar(t.id)
            elif isinstance(s, ast.AugAssign):
                if isinstance(s.target, ast.Name):
                    self._add_scalar(s.target.id)
            elif isinstance(s, ast.For):
                self._add_scalar(s.target.id)
                self._analyse(s.body)
            elif isinstance(s, (ast.While,)):
                self._analyse(s.body)
            elif isinstance(s, ast.If):
                self._analyse(s.body)
                self._analyse(s.orelse)


def load(stem: str):
    path = os.path.join(ALGO_DIR, stem + ".py")
    tree = ast.parse(open(path).read(), path)
    fns = [Fn(n, stem) for n in tree.body if isinstance(n, ast.FunctionDef)]
    entry = next((f for f in fns if f.is_entry), None)
    if entry is None:
        raise KernelError(f"{stem}: no entry function named {stem}")
    # extra integer parameters of the entry point (beyond array + n)
    extras = [n for n, k in entry.params[2:]]
    return fns, entry, extras


def stems():
    return sorted(f[:-3] for f in os.listdir(ALGO_DIR) if f.endswith(".py"))
