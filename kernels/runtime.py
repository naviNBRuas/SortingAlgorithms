"""Runtime for the kernel language: kernels are plain, executable Python.

A kernel is a function over integer arrays (`Arr`) and integers using only: assignment,
if/elif/else, while, for-in-range, return, calls to sibling kernels, `swap`, `new_array`,
`min`/`max` (two arguments), and the operators + - * // % and comparisons / and / or / not.
`//` and `%` are only applied to non-negative operands. This subset maps 1:1 onto C, C++, Java,
Go, Rust, COBOL and x86-64, so one verified algorithm yields every port.
"""
Arr = list


def new_array(n):
    return [0] * max(1, n)


def swap(a, i, j):
    a[i], a[j] = a[j], a[i]
