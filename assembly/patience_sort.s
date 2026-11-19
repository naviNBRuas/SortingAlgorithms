# void patience_sort_asm(int *arr, size_t n)
# Deal elements onto piles (binary search for the leftmost pile whose top is >= x),
# then repeatedly take the smallest pile top.
.intel_syntax noprefix
.text
.globl patience_sort_asm
patience_sort_asm:
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
    lea rdi, [rdi + r12*8]          # 3n dwords: vals | prev | top
    call asm_alloc
    test rax, rax
    jz .Lend
    mov r15, rax                    # vals
    lea r13, [r15 + r12*4]          # prev[i]: element below i in its pile (1-based, 0 = none)
    lea r14, [r13 + r12*4]          # top[p]:  element on top of pile p (1-based, 0 = none)
    mov rsi, rbx
    mov rdi, r15
    mov rcx, r12
    rep movsd
    xor r8d, r8d                    # i
    xor ebp, ebp                    # number of piles
.Ldeal:
    cmp r8, r12
    jae .Lcollect
    mov edx, [r15 + r8*4]           # x
    xor r9d, r9d                    # lo
    mov r10, rbp                    # hi
.Lbsearch:
    cmp r9, r10
    jae .Lfound
    lea r11, [r9 + r10]
    shr r11, 1
    mov eax, [r14 + r11*4]
    mov eax, [r15 + rax*4 - 4]      # value on top of pile mid
    cmp eax, edx
    jge .Lleft
    lea r9, [r11 + 1]
    jmp .Lbsearch
.Lleft:
    mov r10, r11
    jmp .Lbsearch
.Lfound:
    mov eax, [r14 + r9*4]
    mov [r13 + r8*4], eax
    lea eax, [r8 + 1]
    mov [r14 + r9*4], eax
    cmp r9, rbp
    jne 1f
    inc rbp
1:  inc r8
    jmp .Ldeal
.Lcollect:
    xor r8d, r8d                    # output index
.Lout:
    cmp r8, r12
    jae .Lfree
    mov r9, -1                      # best pile
    xor r10d, r10d                  # p
.Lscan:
    cmp r10, rbp
    jae .Lpick
    mov eax, [r14 + r10*4]
    test eax, eax
    jz .Lscan_next
    mov edx, [r15 + rax*4 - 4]
    test r9, r9
    js .Ltake
    cmp edx, r11d
    jge .Lscan_next
.Ltake:
    mov r9, r10
    mov r11d, edx
.Lscan_next:
    inc r10
    jmp .Lscan
.Lpick:
    mov [rbx + r8*4], r11d
    mov eax, [r14 + r9*4]
    mov eax, [r13 + rax*4 - 4]
    mov [r14 + r9*4], eax           # pop
    inc r8
    jmp .Lout
.Lfree:
    mov rdi, r15
    lea rsi, [r12*4]
    lea rsi, [rsi + r12*8]
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
