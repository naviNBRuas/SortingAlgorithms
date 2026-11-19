# void insertion_sort_asm(int *arr, size_t n)
# Also used as the small-range finisher by bucket, tim and intro sort.
.intel_syntax noprefix
.text
.globl insertion_sort_asm
insertion_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r8d, 1                      # i
.Li:
    mov edx, [rdi + r8*4]           # key
    lea r9, [r8 - 1]                # j (signed)
.Lj:
    test r9, r9
    js .Lplace
    mov eax, [rdi + r9*4]
    cmp eax, edx
    jle .Lplace
    mov [rdi + r9*4 + 4], eax
    dec r9
    jmp .Lj
.Lplace:
    mov [rdi + r9*4 + 4], edx
    inc r8
    cmp r8, rsi
    jb .Li
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
