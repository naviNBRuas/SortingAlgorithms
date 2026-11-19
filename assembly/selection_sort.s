# void selection_sort_asm(int *arr, size_t n)
.intel_syntax noprefix
.text
.globl selection_sort_asm
selection_sort_asm:
    cmp rsi, 2
    jb .Lret
    xor r8d, r8d                    # i
.Li:
    lea rax, [rsi - 1]
    cmp r8, rax
    jae .Lret
    mov r9, r8                      # m = i
    lea r10, [r8 + 1]               # j
.Lj:
    cmp r10, rsi
    jae .Lswap
    mov eax, [rdi + r10*4]
    cmp eax, [rdi + r9*4]
    jge .Lnext
    mov r9, r10
.Lnext:
    inc r10
    jmp .Lj
.Lswap:
    cmp r9, r8
    je .Lskip
    mov eax, [rdi + r8*4]
    mov edx, [rdi + r9*4]
    mov [rdi + r8*4], edx
    mov [rdi + r9*4], eax
.Lskip:
    inc r8
    jmp .Li
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
