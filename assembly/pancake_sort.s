# void pancake_sort_asm(int *arr, size_t n)   prefix reversals only
.intel_syntax noprefix
.text
.globl pancake_sort_asm
pancake_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r8, rsi                     # size of unsorted prefix
.Lsize:
    cmp r8, 2
    jb .Lret
    xor r9d, r9d                    # index of max
    mov r10d, 1
.Lmax:
    cmp r10, r8
    jae .Lmax_done
    mov eax, [rdi + r10*4]
    cmp eax, [rdi + r9*4]
    jle .Lmn
    mov r9, r10
.Lmn:
    inc r10
    jmp .Lmax
.Lmax_done:
    lea rax, [r8 - 1]
    cmp r9, rax
    je .Lnext
    test r9, r9
    jz .Lsecond
    mov rcx, r9
    call .Lflip                     # bring max to the front
.Lsecond:
    lea rcx, [r8 - 1]
    call .Lflip                     # flip it into place
.Lnext:
    dec r8
    jmp .Lsize
.Lflip:                             # reverse arr[0..rcx]
    xor edx, edx
.Lfl:
    cmp rdx, rcx
    jae .Lfr
    mov eax, [rdi + rdx*4]
    mov r11d, [rdi + rcx*4]
    mov [rdi + rdx*4], r11d
    mov [rdi + rcx*4], eax
    inc rdx
    dec rcx
    jmp .Lfl
.Lfr:
    ret
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
