# Assembly Sorting Stubs

Implementations (x86-64 System V) now provided for:
- `bubble_sort`
- `insertion_sort`
- `selection_sort`
- `gnome_sort`
- `cocktail_shaker_sort`
- `comb_sort`
- `odd_even_sort`
- `pancake_sort`

Delegated wrappers (currently tail-calling C implementations while assembly is TODO): `binary_insertion_sort_asm`, `merge_sort_asm`, `quick_sort_asm`, `heap_sort_asm`, `shell_sort_asm`, `cycle_sort_asm`, `stooge_sort_asm`, `bitonic_sort_asm`, `counting_sort_asm`, `radix_sort_lsd_asm`, `bucket_sort_asm`, `pigeonhole_sort_asm`, `bead_sort_asm`, `tree_sort_asm`, `patience_sort_asm`, `strand_sort_asm`, `tim_sort_asm`, `intro_sort_asm`, `smooth_sort_asm`, and `bogo_sort_asm` (3-arg).

All functions follow the C ABI. Assemble with NASM/YASM and link alongside the C objects, e.g.:
```
nasm -f elf64 bubble_sort.asm
```
