; Delegates to C binary_insertion_sort
; void binary_insertion_sort(int *arr, size_t n)
section .text
global binary_insertion_sort_asm
extern binary_insertion_sort
binary_insertion_sort_asm:
    jmp binary_insertion_sort
