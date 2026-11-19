# void cocktail_shaker_sort_asm(int *arr, size_t n)
.intel_syntax noprefix
.text
.globl cocktail_shaker_sort_asm
cocktail_shaker_sort_asm:
    cmp rsi, 2
    jb .Lret
    xor r8d, r8d                    # lo
    lea r9, [rsi - 1]               # hi
.Lwhile:
    cmp r8, r9
    jae .Lret
    xor r11d, r11d                  # swapped
    mov r10, r8
.Lfwd:
    cmp r10, r9
    jae .Lfwd_done
    mov eax, [rdi + r10*4]
    mov edx, [rdi + r10*4 + 4]
    cmp eax, edx
    jle .Lfn
    mov [rdi + r10*4], edx
    mov [rdi + r10*4 + 4], eax
    mov r11d, 1
.Lfn:
    inc r10
    jmp .Lfwd
.Lfwd_done:
    dec r9
    mov r10, r9
.Lbwd:
    cmp r10, r8
    jbe .Lbwd_done
    mov eax, [rdi + r10*4 - 4]
    mov edx, [rdi + r10*4]
    cmp eax, edx
    jle .Lbn
    mov [rdi + r10*4 - 4], edx
    mov [rdi + r10*4], eax
    mov r11d, 1
.Lbn:
    dec r10
    jmp .Lbwd
.Lbwd_done:
    inc r8
    test r11d, r11d
    jnz .Lwhile
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
