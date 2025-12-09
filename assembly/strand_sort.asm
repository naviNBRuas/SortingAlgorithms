; Delegate to C strand_sort
section .text
global strand_sort_asm
extern strand_sort
strand_sort_asm:
    jmp strand_sort
