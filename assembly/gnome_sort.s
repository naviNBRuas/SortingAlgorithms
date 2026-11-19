# void gnome_sort_asm(int *arr, size_t n)
.intel_syntax noprefix
.text
.globl gnome_sort_asm
gnome_sort_asm:
    xor r8d, r8d                    # i
.Lloop:
    cmp r8, rsi
    jae .Lret
    test r8, r8
    jz .Lforward
    mov eax, [rdi + r8*4 - 4]
    mov edx, [rdi + r8*4]
    cmp eax, edx
    jle .Lforward
    mov [rdi + r8*4 - 4], edx
    mov [rdi + r8*4], eax
    dec r8
    jmp .Lloop
.Lforward:
    inc r8
    jmp .Lloop
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
