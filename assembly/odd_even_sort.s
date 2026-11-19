# void odd_even_sort_asm(int *arr, size_t n)
.intel_syntax noprefix
.text
.globl odd_even_sort_asm
odd_even_sort_asm:
    cmp rsi, 2
    jb .Lret
.Lrepeat:
    mov r11d, 1                     # done
    mov r8d, 1                      # phase start: odd pairs first, then even
.Lphase:
    mov r9, r8
.Li:
    lea r10, [r9 + 1]
    cmp r10, rsi
    jae .Lphase_done
    mov eax, [rdi + r9*4]
    mov edx, [rdi + r10*4]
    cmp eax, edx
    jle .Lnext
    mov [rdi + r9*4], edx
    mov [rdi + r10*4], eax
    xor r11d, r11d
.Lnext:
    add r9, 2
    jmp .Li
.Lphase_done:
    test r8, r8
    jz .Lcheck
    xor r8d, r8d
    jmp .Lphase
.Lcheck:
    test r11d, r11d
    jz .Lrepeat
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
