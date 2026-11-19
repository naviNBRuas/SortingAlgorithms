# void bead_sort_asm(int *arr, size_t n)
# Gravity sort. ge[r] = number of beads on rod levels >= r; beads then "fall" level by
# level onto the n rods. Key ranges wider than 2^24 fall back to heap_sort_asm.
.intel_syntax noprefix
.text
.globl bead_sort_asm
bead_sort_asm:
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
    sub r14, r13                    # maxv = highest level
    cmp r14, 0x1000000
    ja .Lfallback
    lea rdi, [r14 + r12 + 2]
    shl rdi, 2
    call asm_alloc                  # [ge: maxv+2 dwords][rods: n dwords]
    test rax, rax
    jz .Lfallback
    mov r15, rax
    lea rbp, [r15 + r14*4 + 8]      # rods
    xor ecx, ecx
.Lcount:
    cmp rcx, r12
    jae .Lcount_done
    movsxd rax, dword ptr [rbx + rcx*4]
    sub rax, r13
    inc dword ptr [r15 + rax*4]
    inc rcx
    jmp .Lcount
.Lcount_done:
    mov rcx, r14
.Lsuffix:                           # ge[r] += ge[r+1] for r = maxv-1 .. 0
    test rcx, rcx
    jz .Lsuffix_done
    dec rcx
    mov eax, [r15 + rcx*4 + 4]
    add [r15 + rcx*4], eax
    jmp .Lsuffix
.Lsuffix_done:
    mov r8d, 1                      # level
.Llevel:
    cmp r8, r14
    ja .Llevels_done
    mov r9d, [r15 + r8*4]           # beads at this level
    lea r11, [r12 - 1]              # rightmost rod
    xor r10d, r10d
.Lbead:
    cmp r10, r9
    jae .Lbead_done
    mov rax, r11
    sub rax, r10
    inc dword ptr [rbp + rax*4]
    inc r10
    jmp .Lbead
.Lbead_done:
    inc r8
    jmp .Llevel
.Llevels_done:
    xor ecx, ecx
.Lwrite:
    cmp rcx, r12
    jae .Lwrite_done
    mov eax, [rbp + rcx*4]
    add eax, r13d
    mov [rbx + rcx*4], eax
    inc rcx
    jmp .Lwrite
.Lwrite_done:
    mov rdi, r15
    lea rsi, [r14 + r12 + 2]
    shl rsi, 2
    call asm_free
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
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    jmp heap_sort_asm
.section .note.GNU-stack,"",@progbits
