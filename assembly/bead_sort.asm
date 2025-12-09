; Delegate to C bead_sort
section .text
global bead_sort_asm
extern bead_sort
bead_sort_asm:
    jmp bead_sort
