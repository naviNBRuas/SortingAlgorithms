; Delegate to C radix_sort_lsd
section .text
global radix_sort_lsd_asm
extern radix_sort_lsd
radix_sort_lsd_asm:
    jmp radix_sort_lsd
