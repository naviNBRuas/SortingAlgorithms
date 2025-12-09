; Delegate to C heap_sort
section .text
global heap_sort_asm
extern heap_sort
heap_sort_asm:
    jmp heap_sort
