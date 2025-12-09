; Delegate to C shell_sort
section .text
global shell_sort_asm
extern shell_sort
shell_sort_asm:
    jmp shell_sort
