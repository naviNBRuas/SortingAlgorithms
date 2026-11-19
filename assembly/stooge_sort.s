# void stooge_sort_asm(int *arr, size_t n)   sort first 2/3, last 2/3, first 2/3 again
.intel_syntax noprefix
.text
.globl stooge_sort_asm
stooge_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    mov rbx, rdi
    lea rdx, [rsi - 1]              # j = n - 1
    xor esi, esi                    # i = 0
    call .Lst
    pop rbx
.Lret:
    ret

.Lst:                               # rbx = base, rsi = i, rdx = j
    push r12
    push r13
    push r14
    mov r12, rsi
    mov r13, rdx
    mov eax, [rbx + r12*4]
    mov ecx, [rbx + r13*4]
    cmp eax, ecx
    jle .Lnoswap
    mov [rbx + r12*4], ecx
    mov [rbx + r13*4], eax
.Lnoswap:
    mov rax, r13
    sub rax, r12
    inc rax                         # length
    cmp rax, 2
    jbe .Lend
    xor edx, edx
    mov ecx, 3
    div rcx
    mov r14, rax                    # t = length / 3
    mov rsi, r12
    mov rdx, r13
    sub rdx, r14
    call .Lst                       # first 2/3
    lea rsi, [r12 + r14]
    mov rdx, r13
    call .Lst                       # last 2/3
    mov rsi, r12
    mov rdx, r13
    sub rdx, r14
    call .Lst                       # first 2/3 again
.Lend:
    pop r14
    pop r13
    pop r12
    ret
.section .note.GNU-stack,"",@progbits
