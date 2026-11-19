# Kernels: one source of truth for every language

Each of the 56 algorithms is written **once** as a *kernel* in `kernels/algos/<name>.py`: a tiny, restricted, executable
Python subset (integer arrays, integers, loops, recursion). The kernel is

1. **verified natively** in Python (`python kernels/test_kernels.py`) against `sorted()`, then
2. **transpiled mechanically** by `kernels/generate.py` into C, C++, Java, Go, Rust, COBOL and x86-64 assembly,
   and assembled into raw machine code (`machine-code/`).

So the nine language editions run the *same algorithm*; a bug fixed in a kernel is fixed everywhere. The generated files
carry a `GENERATED ... do not edit` banner; CI runs `python kernels/generate.py --check` to make sure they never drift.

## The kernel language

```python
from runtime import Arr, swap

def bubble_sort(a: Arr, n: int):          # entry point: name == file name, (array, length[, extra ints])
    end = n - 1
    swapped = 1
    while end > 0 and swapped == 1:
        swapped = 0
        j = 0
        while j < end:
            if a[j] > a[j + 1]:
                swap(a, j, j + 1)
                swapped = 1
            j += 1
        end -= 1
```

Allowed: integer variables, `Arr` parameters (int32 arrays), `new_array(n)` (zeroed; top-level statements only,
freed automatically), assignment / `+= -= *=`, `if/elif/else`, `while`, `for i in range(a, b)`, `return`, calls to other
functions in the same file, `swap(a, i, j)`, `min(x, y)` / `max(x, y)`, the operators `+ - * // %`, comparisons and
`and / or / not`. Rules that keep the translation exact: `//` and `%` only on non-negative operands; do not modify a
`for` variable or its bound inside the loop and do not read it after the loop; no bitwise operators, `break`, `continue`
or array-valued variables (COBOL and assembly have none of these cleanly). Helper functions become `<name>_x_<helper>`.

## Adding an algorithm

1. Write `kernels/algos/<name>.py` and run `python kernels/test_kernels.py <name>`.
2. Register its metadata in `python/sorting_algorithms/algos/*.py` (the reference implementation with tracing/animation).
3. `python kernels/generate.py`, then run each language's test (see the top-level README).

## Backends

| Backend | File | Notes |
| --- | --- | --- |
| C, C++, Java, Go, Rust | `backends/clike.py` | One statement walker, per-language syntax hooks. |
| x86-64 assembly | `backends/x86.py` | Simple unoptimised compiler: variables in stack slots, `mmap`-based `new_array`, no libc. |
| COBOL | `backends/cobol.py` | Lowers to `COMPUTE`/`MOVE` over temporaries, flag-based short circuiting, recursive programs. |
