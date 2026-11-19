# Pure-assembly sorting algorithms (x86-64, Linux)

Every one of the 28 algorithms in the original catalogue is hand-written assembly. There is **no C, no libc and no
delegation**: the only external dependency is the Linux kernel, reached through two raw system calls in `util.s`
(`mmap`/`munmap`) for the scratch memory some algorithms need.

| Group | Algorithms |
| --- | --- |
| Exchange | `bubble`, `cocktail_shaker`, `odd_even`, `comb`, `gnome`, `pancake`, `stooge`, `quick` (Lomuto), `bogo` |
| Selection / heaps | `selection`, `cycle`, `heap`, `smooth` (Leonardo heaps) |
| Insertion | `insertion`, `binary_insertion`, `shell`, `tree` (BST), `patience` |
| Merge / hybrid | `merge` (bottom-up), `strand`, `tim` (runs + merge-collapse stack, no galloping), `intro` |
| Distribution | `counting`, `pigeonhole`, `radix_lsd`, `bucket`, `bead` |
| Network | `bitonic` (any length) |

## ABI

Every function is `void NAME_sort_asm(int *arr, size_t n)` in the System V AMD64 convention (`rdi` = array,
`rsi` = length), sorting **signed 32-bit** integers ascending in place. The only exception is
`void bogo_sort_asm(int *arr, size_t n, size_t max_shuffles)`, which gives up after `max_shuffles` shuffles.
Callee-saved registers are preserved. Radix sort is `radix_sort_lsd_asm`.

Notes on behaviour:

- Counting, pigeonhole and bead sort allocate a table proportional to the key range. If `max - min` exceeds 2^24 (or the
  allocation fails) they hand off to `heap_sort_asm`, so they always return a sorted array rather than exhausting memory.
- `quick_sort_asm` recurses into the smaller partition and loops on the larger, so stack depth is O(log n) even on sorted input.
- `smooth_sort_asm` uses a 512-byte Leonardo-number table on the stack; `tim_sort_asm` uses a 1 KiB run stack.
- A few routines call other routines in this directory (`insertion_sort_asm` finishes buckets, TimSort runs and
  intro-sort leaves; `heap_sort_asm` is intro-sort's depth-limit fallback) — all of them assembly.

## Build and test

Written in GNU `as` Intel syntax (no NASM needed):

```sh
cd assembly
make                  # libsortasm.a
make test             # random / sorted / reversed / duplicate-heavy / INT_MIN..INT_MAX inputs, n up to 5000
make freestanding     # links with -nostdlib -static (no libc at all) and runs every sort
make memcheck         # the test suite under Valgrind (catches out-of-bounds access)
```

Use from C:

```c
void quick_sort_asm(int *arr, size_t n);
...
quick_sort_asm(data, n);   // link with -L assembly -lsortasm
```
