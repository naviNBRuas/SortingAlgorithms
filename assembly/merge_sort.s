# void merge_sort_asm(int *arr, size_t n)
# Bottom-up, stable, ping-pong between arr and an mmap'd scratch buffer.
.intel_syntax noprefix
.text
.globl merge_sort_asm
merge_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    mov rbx, rdi                    # original array
    mov r12, rsi                    # n
    lea rdi, [rsi*4]
    call asm_alloc
    test rax, rax
    jz .Lpop
    mov r13, rbx                    # src
    mov r14, rax                    # dst
    mov r15d, 1                     # width
.Lwidth:
    cmp r15, r12
    jae .Lfinish
    xor ecx, ecx                    # lo
.Lrun:
    cmp rcx, r12
    jae .Lswap
    lea r8, [rcx + r15]             # mid = min(lo + width, n)
    cmp r8, r12
    jbe 1f
    mov r8, r12
1:  lea r9, [r8 + r15]              # hi = min(mid + width, n)
    cmp r9, r12
    jbe 2f
    mov r9, r12
2:  mov r10, rcx                    # i
    mov r11, r8                     # j
    mov rsi, rcx                    # k
.Lmerge:
    cmp r10, r8
    jae .Ldrain_right
    cmp r11, r9
    jae .Ldrain_left
    mov eax, [r13 + r10*4]
    mov edx, [r13 + r11*4]
    cmp edx, eax
    jl .Ltake_right                 # strictly smaller on the right only -> stable
    mov [r14 + rsi*4], eax
    inc r10
    inc rsi
    jmp .Lmerge
.Ltake_right:
    mov [r14 + rsi*4], edx
    inc r11
    inc rsi
    jmp .Lmerge
.Ldrain_left:
    cmp r10, r8
    jae .Lmerged
    mov eax, [r13 + r10*4]
    mov [r14 + rsi*4], eax
    inc r10
    inc rsi
    jmp .Ldrain_left
.Ldrain_right:
    cmp r11, r9
    jae .Lmerged
    mov edx, [r13 + r11*4]
    mov [r14 + rsi*4], edx
    inc r11
    inc rsi
    jmp .Ldrain_right
.Lmerged:
    lea rcx, [rcx + r15*2]
    jmp .Lrun
.Lswap:
    xchg r13, r14
    shl r15, 1
    jmp .Lwidth
.Lfinish:
    cmp r13, rbx
    je .Lfree
    mov rsi, r13                    # result is in scratch: copy back
    mov rdi, rbx
    mov rcx, r12
    rep movsd
.Lfree:
    mov rdi, r13
    cmp rdi, rbx
    jne 3f
    mov rdi, r14                    # scratch pointer is whichever buffer is not arr
3:  lea rsi, [r12*4]
    call asm_free
.Lpop:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
