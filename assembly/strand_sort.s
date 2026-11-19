# void strand_sort_asm(int *arr, size_t n)
# Repeatedly pull an ascending strand out of the remaining input and merge it into the output.
.intel_syntax noprefix
.text
.globl strand_sort_asm
strand_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    push rbp
    mov rbx, rdi
    mov r12, rsi
    lea rdi, [r12*4]
    shl rdi, 2
    call asm_alloc                  # rem | strand | out | tmp
    test rax, rax
    jz .Lend
    mov r15, rax
    lea r13, [r15 + r12*8]          # out
    lea r14, [r13 + r12*4]          # tmp
    mov rsi, rbx
    mov rdi, r15
    mov rcx, r12
    rep movsd                       # rem = input
    mov rbp, r12                    # elements left in rem
    xor r10d, r10d                  # elements in out
.Lwhile:
    test rbp, rbp
    jz .Lfinal
    lea r9, [r15 + r12*4]           # strand buffer
    mov eax, [r15]
    mov [r9], eax                   # strand starts with the first remaining element
    mov r8d, 1                      # strand length
    xor r11d, r11d                  # kept count (compacted in rem)
    mov ecx, 1
.Lpull:
    cmp rcx, rbp
    jae .Lpulled
    mov edx, [r15 + rcx*4]
    mov eax, [r9 + r8*4 - 4]
    cmp edx, eax
    jl .Lkeep
    mov [r9 + r8*4], edx
    inc r8
    jmp .Lpull_next
.Lkeep:
    mov [r15 + r11*4], edx
    inc r11
.Lpull_next:
    inc rcx
    jmp .Lpull
.Lpulled:
    mov rbp, r11
    xor esi, esi                    # i over out
    xor edi, edi                    # j over strand
    xor ecx, ecx                    # k over tmp
.Lmerge:
    cmp rsi, r10
    jae .Ldrain_strand
    cmp rdi, r8
    jae .Ldrain_out
    mov eax, [r13 + rsi*4]
    mov edx, [r9 + rdi*4]
    cmp edx, eax
    jl .Ltake_strand
    mov [r14 + rcx*4], eax
    inc rsi
    inc rcx
    jmp .Lmerge
.Ltake_strand:
    mov [r14 + rcx*4], edx
    inc rdi
    inc rcx
    jmp .Lmerge
.Ldrain_out:
    cmp rsi, r10
    jae .Lmerged
    mov eax, [r13 + rsi*4]
    mov [r14 + rcx*4], eax
    inc rsi
    inc rcx
    jmp .Ldrain_out
.Ldrain_strand:
    cmp rdi, r8
    jae .Lmerged
    mov edx, [r9 + rdi*4]
    mov [r14 + rcx*4], edx
    inc rdi
    inc rcx
    jmp .Ldrain_strand
.Lmerged:
    mov r10, rcx
    xchg r13, r14
    jmp .Lwhile
.Lfinal:
    mov rsi, r13
    mov rdi, rbx
    mov rcx, r12
    rep movsd
    mov rdi, r15
    lea rsi, [r12*4]
    shl rsi, 2
    call asm_free
.Lend:
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
