; Delegate to C tree_sort
section .text
global tree_sort_asm
extern tree_sort
tree_sort_asm:
    jmp tree_sort
