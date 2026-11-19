# void cycle_sort_asm(int *arr, size_t n)   minimal-write cycle rotations
.intel_syntax noprefix
.text
.globl cycle_sort_asm
cycle_sort_asm:
    cmp rsi, 2
    jb .Lret
    xor r8d, r8d                    # start
.Lstart:
    lea rax, [rsi - 1]
    cmp r8, rax
    jae .Lret
    mov edx, [rdi + r8*4]           # item
    call .Lrank                     # r9 = target position
    cmp r9, r8
    je .Lnext
.Ldup1:
    cmp edx, [rdi + r9*4]
    jne .Lw1
    inc r9
    jmp .Ldup1
.Lw1:
    mov eax, [rdi + r9*4]
    mov [rdi + r9*4], edx
    mov edx, eax
.Lcycle:
    cmp r9, r8
    je .Lnext
    call .Lrank
.Ldup2:
    cmp edx, [rdi + r9*4]
    jne .Lw2
    inc r9
    jmp .Ldup2
.Lw2:
    mov eax, [rdi + r9*4]
    mov [rdi + r9*4], edx
    mov edx, eax
    jmp .Lcycle
.Lnext:
    inc r8
    jmp .Lstart
.Lrank:                             # r9 = start + #{ i > start : arr[i] < item }
    mov r9, r8
    lea r10, [r8 + 1]
.Lrl:
    cmp r10, rsi
    jae .Lrr
    cmp [rdi + r10*4], edx
    jge .Lrs
    inc r9
.Lrs:
    inc r10
    jmp .Lrl
.Lrr:
    ret
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
