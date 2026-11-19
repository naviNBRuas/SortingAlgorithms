# void intro_sort_asm(int *arr, size_t n)
# Median-of-three quicksort (Hoare scheme); falls back to heap_sort_asm when the depth
# budget 2*floor(log2 n) is spent and to insertion_sort_asm on ranges of <= 16 elements.
.intel_syntax noprefix
.text
.globl intro_sort_asm
intro_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    mov rbx, rdi
    bsr rcx, rsi
    add rcx, rcx                    # depth limit
    lea rdx, [rsi - 1]              # hi
    xor esi, esi                    # lo
    call .Lsort
    pop rbx
.Lret:
    ret

.Lsort:                             # rbx = base, rsi = lo, rdx = hi (signed), rcx = depth
    push r12
    push r13
    push r14
    push r15
    push rbp
    mov r12, rsi
    mov r13, rdx
    mov r14, rcx
.Lloop:
    mov rax, r13
    sub rax, r12
    inc rax                         # size
    cmp rax, 2
    jl .Lout
    cmp rax, 16
    jg .Lbig
    lea rdi, [rbx + r12*4]
    mov rsi, rax
    call insertion_sort_asm
    jmp .Lout
.Lbig:
    test r14, r14
    jnz .Lpartition
    lea rdi, [rbx + r12*4]
    mov rsi, rax
    call heap_sort_asm
    jmp .Lout
.Lpartition:
    dec r14
    mov r8, r12
    add r8, r13
    sar r8, 1                       # mid
    mov eax, [rbx + r8*4]           # order a[lo] <= a[mid] <= a[hi]
    mov edx, [rbx + r12*4]
    cmp eax, edx
    jge 1f
    mov [rbx + r8*4], edx
    mov [rbx + r12*4], eax
1:  mov eax, [rbx + r13*4]
    mov edx, [rbx + r12*4]
    cmp eax, edx
    jge 2f
    mov [rbx + r13*4], edx
    mov [rbx + r12*4], eax
2:  mov eax, [rbx + r13*4]
    mov edx, [rbx + r8*4]
    cmp eax, edx
    jge 3f
    mov [rbx + r13*4], edx
    mov [rbx + r8*4], eax
3:  mov r9d, [rbx + r8*4]           # pivot
    mov r15, r12                    # i
    mov rbp, r13                    # j
.Lhoare:
    cmp r15, rbp
    jg .Lrecurse
.Lscan_i:
    cmp [rbx + r15*4], r9d
    jge .Lscan_j
    inc r15
    jmp .Lscan_i
.Lscan_j:
    cmp [rbx + rbp*4], r9d
    jle .Lcross
    dec rbp
    jmp .Lscan_j
.Lcross:
    cmp r15, rbp
    jg .Lhoare
    mov eax, [rbx + r15*4]
    mov edx, [rbx + rbp*4]
    mov [rbx + r15*4], edx
    mov [rbx + rbp*4], eax
    inc r15
    dec rbp
    jmp .Lhoare
.Lrecurse:
    mov rsi, r12
    mov rdx, rbp
    mov rcx, r14
    call .Lsort                     # left part lo..j
    mov r12, r15                    # continue on i..hi
    jmp .Lloop
.Lout:
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    ret
.section .note.GNU-stack,"",@progbits
