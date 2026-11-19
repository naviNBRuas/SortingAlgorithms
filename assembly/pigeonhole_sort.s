# void pigeonhole_sort_asm(int *arr, size_t n)
# One hole per key value; drop elements in, then read the holes back in order.
# Ranges wider than 2^24 fall back to heap_sort_asm.
.intel_syntax noprefix
.text
.globl pigeonhole_sort_asm
pigeonhole_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
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
    inc r15                         # number of holes
    cmp r15, 0x1000000
    ja .Lfallback
    lea rdi, [r15*4]
    call asm_alloc
    test rax, rax
    jz .Lfallback
    mov r14, rax                    # holes (occupancy counters)
    xor ecx, ecx
.Lfill:
    cmp rcx, r12
    jae .Lfill_done
    movsxd rax, dword ptr [rbx + rcx*4]
    sub rax, r13
    inc dword ptr [r14 + rax*4]
    inc rcx
    jmp .Lfill
.Lfill_done:
    xor ecx, ecx                    # hole index
    xor r8d, r8d                    # output index
.Lhole:
    cmp rcx, r15
    jae .Lread_done
    mov r9d, [r14 + rcx*4]
    lea edx, [rcx + r13]            # key value of this hole (32-bit wrap is exact)
.Lemit:
    test r9d, r9d
    jz .Lnext_hole
    mov [rbx + r8*4], edx
    inc r8
    dec r9d
    jmp .Lemit
.Lnext_hole:
    inc rcx
    jmp .Lhole
.Lread_done:
    mov rdi, r14
    lea rsi, [r15*4]
    call asm_free
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
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    jmp heap_sort_asm
.section .note.GNU-stack,"",@progbits
