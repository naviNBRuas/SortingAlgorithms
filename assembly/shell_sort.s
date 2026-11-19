# void shell_sort_asm(int *arr, size_t n)   gaps n/2, n/4, ..., 1
.intel_syntax noprefix
.text
.globl shell_sort_asm
shell_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r8, rsi
    shr r8, 1                       # gap
.Lgap:
    test r8, r8
    jz .Lret
    mov r9, r8                      # i = gap
.Li:
    cmp r9, rsi
    jae .Lnext_gap
    mov edx, [rdi + r9*4]           # tmp
    mov r10, r9                     # j
.Lj:
    cmp r10, r8
    jb .Lput
    mov r11, r10
    sub r11, r8
    mov eax, [rdi + r11*4]
    cmp eax, edx
    jle .Lput
    mov [rdi + r10*4], eax
    mov r10, r11
    jmp .Lj
.Lput:
    mov [rdi + r10*4], edx
    inc r9
    jmp .Li
.Lnext_gap:
    shr r8, 1
    jmp .Lgap
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
