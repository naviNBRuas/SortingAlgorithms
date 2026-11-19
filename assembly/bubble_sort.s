# void bubble_sort_asm(int *arr, size_t n)   -- rdi = arr, rsi = n
# Adjacent swaps with early exit when a pass makes no swap.
.intel_syntax noprefix
.text
.globl bubble_sort_asm
bubble_sort_asm:
    cmp rsi, 2
    jb .Lret
    lea r8, [rsi - 1]               # end index of the unsorted prefix
.Louter:
    xor r9d, r9d                    # j
    xor r10d, r10d                  # swapped = 0
.Linner:
    cmp r9, r8
    jae .Linner_done
    mov eax, [rdi + r9*4]
    mov edx, [rdi + r9*4 + 4]
    cmp eax, edx
    jle .Lnoswap
    mov [rdi + r9*4], edx
    mov [rdi + r9*4 + 4], eax
    mov r10d, 1
.Lnoswap:
    inc r9
    jmp .Linner
.Linner_done:
    test r10d, r10d
    jz .Lret
    dec r8
    jnz .Louter
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
