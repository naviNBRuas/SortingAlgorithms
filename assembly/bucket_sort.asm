; Delegate to C bucket_sort
section .text
global bucket_sort_asm
extern bucket_sort
bucket_sort_asm:
    jmp bucket_sort
