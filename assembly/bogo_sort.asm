; Delegate to C bogo_sort (int *arr, size_t n, size_t max_shuffles)
section .text
global bogo_sort_asm
extern bogo_sort
bogo_sort_asm:
    jmp bogo_sort
