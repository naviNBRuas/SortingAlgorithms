# void quick_sort_asm(int *arr, size_t n)
# Lomuto partition (pivot = last element). Recurses into the smaller side and loops on
# the larger, so stack depth is O(log n) even on sorted input.
.intel_syntax noprefix
.text
.globl quick_sort_asm
quick_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    mov rbx, rdi
    lea rdx, [rsi - 1]              # hi = n - 1
    xor esi, esi                    # lo = 0
    call .Lqs
    pop rbx
.Lret:
    ret

.Lqs:                               # rbx = base, rsi = lo, rdx = hi (signed)
    push r12
    push r13
    push r14
    mov r12, rsi
    mov r13, rdx
.Lloop:
    cmp r12, r13
    jge .Ldone
    mov eax, [rbx + r13*4]          # pivot
    mov r14, r12                    # i
    mov rcx, r12                    # j
.Lpart:
    cmp rcx, r13
    jge .Lpart_done
    mov edx, [rbx + rcx*4]
    cmp edx, eax
    jg .Lnext
    mov r8d, [rbx + r14*4]
    mov [rbx + r14*4], edx
    mov [rbx + rcx*4], r8d
    inc r14
.Lnext:
    inc rcx
    jmp .Lpart
.Lpart_done:
    mov edx, [rbx + r14*4]
    mov [rbx + r13*4], edx
    mov [rbx + r14*4], eax          # pivot lands at index p = r14
    mov rcx, r14
    sub rcx, r12                    # left size
    mov r8, r13
    sub r8, r14                     # right size
    cmp rcx, r8
    jg .Lright_first
    mov rsi, r12
    lea rdx, [r14 - 1]
    call .Lqs                       # smaller (left) side recursively
    lea r12, [r14 + 1]
    jmp .Lloop
.Lright_first:
    lea rsi, [r14 + 1]
    mov rdx, r13
    call .Lqs                       # smaller (right) side recursively
    lea r13, [r14 - 1]
    jmp .Lloop
.Ldone:
    pop r14
    pop r13
    pop r12
    ret
.section .note.GNU-stack,"",@progbits
