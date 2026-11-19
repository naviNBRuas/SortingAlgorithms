# void binary_insertion_sort_asm(int *arr, size_t n)
.intel_syntax noprefix
.text
.globl binary_insertion_sort_asm
binary_insertion_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r8d, 1                      # i
.Li:
    mov edx, [rdi + r8*4]           # key
    xor r9d, r9d                    # lo
    mov r10, r8                     # hi
.Lbs:
    cmp r9, r10
    jae .Lfound
    lea r11, [r9 + r10]
    shr r11, 1
    cmp edx, [rdi + r11*4]
    jl .Lgo_left
    lea r9, [r11 + 1]
    jmp .Lbs
.Lgo_left:
    mov r10, r11
    jmp .Lbs
.Lfound:
    mov rcx, r8                     # shift arr[lo..i-1] right by one
.Lshift:
    cmp rcx, r9
    jbe .Lplace
    mov eax, [rdi + rcx*4 - 4]
    mov [rdi + rcx*4], eax
    dec rcx
    jmp .Lshift
.Lplace:
    mov [rdi + r9*4], edx
    inc r8
    cmp r8, rsi
    jb .Li
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
