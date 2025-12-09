; Delegate to C patience_sort
section .text
global patience_sort_asm
extern patience_sort
patience_sort_asm:
    jmp patience_sort
