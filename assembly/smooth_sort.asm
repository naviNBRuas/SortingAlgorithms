; Delegate to C smooth_sort
section .text
global smooth_sort_asm
extern smooth_sort
smooth_sort_asm:
    jmp smooth_sort
