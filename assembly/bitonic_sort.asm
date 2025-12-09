; Delegate to C bitonic_sort
section .text
global bitonic_sort_asm
extern bitonic_sort
bitonic_sort_asm:
    jmp bitonic_sort
