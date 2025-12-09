; Delegate to C cycle_sort
section .text
global cycle_sort_asm
extern cycle_sort
cycle_sort_asm:
    jmp cycle_sort
