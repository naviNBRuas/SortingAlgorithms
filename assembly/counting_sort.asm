; Delegate to C counting_sort
section .text
global counting_sort_asm
extern counting_sort
counting_sort_asm:
    jmp counting_sort
