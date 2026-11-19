# void bitonic_sort_asm(int *arr, size_t n)
# Ascending-only bitonic network (flip-first). Comparators past the end are skipped,
# which is equivalent to padding with +infinity, so any n works.
.intel_syntax noprefix
.macro CMPSWAP a, b                 # compare-exchange arr[\a], arr[\b]; clobbers eax, ecx
    mov eax, [rdi + \a*4]
    mov ecx, [rdi + \b*4]
    cmp eax, ecx
    jle 1f
    mov [rdi + \a*4], ecx
    mov [rdi + \b*4], eax
1:
.endm
.text
.globl bitonic_sort_asm
bitonic_sort_asm:
    cmp rsi, 2
    jb .Lret
    push r12
    push r13
    mov r8d, 1                      # size = next power of two >= n
.Lpow:
    cmp r8, rsi
    jae .Lpow_done
    shl r8, 1
    jmp .Lpow
.Lpow_done:
    mov r9d, 2                      # k
.Lk:
    cmp r9, r8
    ja .Lout
    xor r10d, r10d                  # blk
.Lblk:
    cmp r10, r8
    jae .Lhalf
    xor r13d, r13d                  # t
.Lt:
    mov rax, r9
    shr rax, 1
    cmp r13, rax
    jae .Lblk_next
    lea r11, [r10 + r9 - 1]
    sub r11, r13                    # j = blk + k - 1 - t
    cmp r11, rsi
    jae .Lt_next
    lea rdx, [r10 + r13]            # i = blk + t
    CMPSWAP rdx, r11
.Lt_next:
    inc r13
    jmp .Lt
.Lblk_next:
    add r10, r9
    jmp .Lblk
.Lhalf:
    mov r12, r9
    shr r12, 2                      # j = k / 4
.Lj:
    test r12, r12
    jz .Lk_next
    xor edx, edx                    # i
.Li:
    cmp rdx, r8
    jae .Lj_next
    test rdx, r12
    jnz .Li_next
    lea r11, [rdx + r12]
    cmp r11, rsi
    jae .Li_next
    CMPSWAP rdx, r11
.Li_next:
    inc rdx
    jmp .Li
.Lj_next:
    shr r12, 1
    jmp .Lj
.Lk_next:
    shl r9, 1
    jmp .Lk
.Lout:
    pop r13
    pop r12
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
