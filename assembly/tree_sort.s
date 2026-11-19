# void tree_sort_asm(int *arr, size_t n)
# Unbalanced binary search tree stored in index arrays (1-based child links, 0 = none),
# then an iterative in-order walk with an explicit stack. Equal keys go right (stable).
.intel_syntax noprefix
.text
.globl tree_sort_asm
tree_sort_asm:
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
    call asm_alloc                  # vals | left | right | stack, n dwords each
    test rax, rax
    jz .Lend
    mov r15, rax                    # vals
    lea r13, [r15 + r12*4]          # left
    lea r14, [r13 + r12*4]          # right
    lea rbp, [r14 + r12*4]          # stack
    mov rsi, rbx
    mov rdi, r15
    mov rcx, r12
    rep movsd
    mov r8d, 1
.Linsert:
    cmp r8, r12
    jae .Lwalk
    mov edx, [r15 + r8*4]
    xor ecx, ecx                    # current node
.Ldescend:
    cmp edx, [r15 + rcx*4]
    jl .Lgo_left
    mov eax, [r14 + rcx*4]
    test eax, eax
    jnz 1f
    lea eax, [r8 + 1]
    mov [r14 + rcx*4], eax
    jmp .Lnext
1:  lea ecx, [rax - 1]
    jmp .Ldescend
.Lgo_left:
    mov eax, [r13 + rcx*4]
    test eax, eax
    jnz 2f
    lea eax, [r8 + 1]
    mov [r13 + rcx*4], eax
    jmp .Lnext
2:  lea ecx, [rax - 1]
    jmp .Ldescend
.Lnext:
    inc r8
    jmp .Linsert
.Lwalk:
    mov r9d, 1                      # current node (1-based)
    xor r10d, r10d                  # stack depth
    xor r11d, r11d                  # output index
.Lpush_left:
    test r9d, r9d
    jz .Lpop
    mov [rbp + r10*4], r9d
    inc r10
    mov eax, r9d
    mov r9d, [r13 + rax*4 - 4]
    jmp .Lpush_left
.Lpop:
    test r10, r10
    jz .Ldone
    dec r10
    mov eax, [rbp + r10*4]
    mov edx, [r15 + rax*4 - 4]
    mov [rbx + r11*4], edx
    inc r11
    mov r9d, [r14 + rax*4 - 4]
    jmp .Lpush_left
.Ldone:
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
