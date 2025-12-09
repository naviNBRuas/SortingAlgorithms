; Delegate to C quick_sort
section .text
global quick_sort_asm
extern quick_sort
quick_sort_asm:
    jmp quick_sort
