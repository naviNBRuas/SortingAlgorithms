; Delegate to C merge_sort
section .text
global merge_sort_asm
extern merge_sort
merge_sort_asm:
    jmp merge_sort
