; Delegate to C tim_sort
section .text
global tim_sort_asm
extern tim_sort
tim_sort_asm:
    jmp tim_sort
