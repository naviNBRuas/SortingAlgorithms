# void counting_sort_asm(int *arr, size_t n)
# Stable counting sort: count, prefix-sum into start offsets, place into scratch, copy back.
# Key ranges wider than 2^24 fall back to the (pure assembly) heap sort instead of
# allocating a huge table.
.intel_syntax noprefix
.text
.globl counting_sort_asm
counting_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    push rbp
    sub rsp, 16                     # [rsp] = scratch pointer
    mov rbx, rdi
    mov r12, rsi
    movsxd r13, dword ptr [rbx]     # min
    mov r14, r13                    # max
    mov ecx, 1
.Lmm:
    cmp rcx, r12
    jae .Lmm_done
    movsxd rax, dword ptr [rbx + rcx*4]
    cmp rax, r13
    jge 1f
    mov r13, rax
1:  cmp rax, r14
    jle 2f
    mov r14, rax
2:  inc rcx
    jmp .Lmm
.Lmm_done:
    mov r15, r14
    sub r15, r13
    inc r15                         # range = max - min + 1
    cmp r15, 0x1000000
    ja .Lfallback
    lea rdi, [r15*4]
    call asm_alloc
    test rax, rax
    jz .Lfallback
    mov rbp, rax                    # counts
    lea rdi, [r12*4]
    call asm_alloc
    test rax, rax
    jz .Lfree_counts
    mov [rsp], rax
    xor ecx, ecx
.Lcount:
    cmp rcx, r12
    jae .Lcount_done
    movsxd rax, dword ptr [rbx + rcx*4]
    sub rax, r13
    inc dword ptr [rbp + rax*4]
    inc rcx
    jmp .Lcount
.Lcount_done:
    xor eax, eax
    xor ecx, ecx
.Lprefix:
    cmp rcx, r15
    jae .Lprefix_done
    mov edx, [rbp + rcx*4]
    mov [rbp + rcx*4], eax
    add eax, edx
    inc rcx
    jmp .Lprefix
.Lprefix_done:
    mov r8, [rsp]
    xor ecx, ecx
.Lplace:
    cmp rcx, r12
    jae .Lplace_done
    mov edx, [rbx + rcx*4]
    movsxd rax, edx
    sub rax, r13
    mov r9d, [rbp + rax*4]
    lea r10d, [r9 + 1]
    mov [rbp + rax*4], r10d
    mov [r8 + r9*4], edx
    inc rcx
    jmp .Lplace
.Lplace_done:
    mov rsi, r8
    mov rdi, rbx
    mov rcx, r12
    rep movsd
    mov rdi, [rsp]
    lea rsi, [r12*4]
    call asm_free
.Lfree_counts:
    mov rdi, rbp
    lea rsi, [r15*4]
    call asm_free
.Lend:
    add rsp, 16
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret
.Lfallback:
    mov rdi, rbx
    mov rsi, r12
    add rsp, 16
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    jmp heap_sort_asm
.section .note.GNU-stack,"",@progbits
