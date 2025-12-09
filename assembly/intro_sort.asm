; Delegate to C intro_sort
section .text
global intro_sort_asm
extern intro_sort
intro_sort_asm:
    jmp intro_sort
