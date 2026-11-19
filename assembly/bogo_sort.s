# void bogo_sort_asm(int *arr, size_t n, size_t max_shuffles)
# Shuffle (Fisher-Yates with an xorshift64 generator) until sorted, giving up after
# max_shuffles shuffles so it always terminates.
.intel_syntax noprefix
.text
.globl bogo_sort_asm
bogo_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r9, 0x9E3779B97F4A7C15      # PRNG state
.Lcheck:
    xor ecx, ecx
.Lscan:
    lea rax, [rcx + 1]
    cmp rax, rsi
    jae .Lret                       # sorted
    mov r8d, [rdi + rcx*4]
    cmp r8d, [rdi + rcx*4 + 4]
    jg .Lshuffle
    inc rcx
    jmp .Lscan
.Lshuffle:
    test rdx, rdx
    jz .Lret
    dec rdx
    mov r10, rdx                    # preserve the budget across div
    lea rcx, [rsi - 1]
.Lfy:
    test rcx, rcx
    jz .Lshuffled
    mov rax, r9
    mov r11, rax
    shl r11, 13
    xor rax, r11
    mov r11, rax
    shr r11, 7
    xor rax, r11
    mov r11, rax
    shl r11, 17
    xor rax, r11
    mov r9, rax
    xor edx, edx
    lea r8, [rcx + 1]
    div r8                          # rdx = x mod (i+1)
    mov eax, [rdi + rcx*4]
    mov r8d, [rdi + rdx*4]
    mov [rdi + rcx*4], r8d
    mov [rdi + rdx*4], eax
    dec rcx
    jmp .Lfy
.Lshuffled:
    mov rdx, r10
    jmp .Lcheck
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
