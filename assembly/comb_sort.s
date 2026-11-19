# void comb_sort_asm(int *arr, size_t n)   gap shrink factor 10/13 (~1.3)
.intel_syntax noprefix
.text
.globl comb_sort_asm
comb_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r8, rsi                     # gap
    mov r11d, 1                     # swapped
.Lwhile:
    cmp r8, 1
    ja .Lgo
    test r11d, r11d
    jz .Lret
.Lgo:
    mov rax, r8
    imul rax, rax, 10
    xor edx, edx
    mov ecx, 13
    div rcx
    mov r8, rax
    test r8, r8
    jnz 1f
    mov r8d, 1
1:  xor r11d, r11d
    xor r9d, r9d                    # i
.Li:
    lea r10, [r9 + r8]
    cmp r10, rsi
    jae .Lwhile
    mov eax, [rdi + r9*4]
    mov edx, [rdi + r10*4]
    cmp eax, edx
    jle .Lnext
    mov [rdi + r9*4], edx
    mov [rdi + r10*4], eax
    mov r11d, 1
.Lnext:
    inc r9
    jmp .Li
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
