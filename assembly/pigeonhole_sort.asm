; Delegate to C pigeonhole_sort
section .text
global pigeonhole_sort_asm
extern pigeonhole_sort
pigeonhole_sort_asm:
    jmp pigeonhole_sort
