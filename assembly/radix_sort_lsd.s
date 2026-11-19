# void radix_sort_lsd_asm(int *arr, size_t n)
# LSD radix sort, base 10. Keys are offset by the minimum (as unsigned 32-bit), so
# negative numbers need no special casing. Stable passes ping-pong with a scratch buffer.
.intel_syntax noprefix
.text
.globl radix_sort_lsd_asm
radix_sort_lsd_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    push rbp
    sub rsp, 112                    # [0..79] digit counters, [80] original arr, [88] scratch
    mov [rsp + 80], rdi
    mov rbx, rdi                    # current source buffer
    mov r12, rsi
    mov r14d, [rbx]                 # min
    mov r15d, r14d                  # max
    mov ecx, 1
.Lmm:
    cmp rcx, r12
    jae .Lmm_done
    mov eax, [rbx + rcx*4]
    cmp eax, r14d
    jge 1f
    mov r14d, eax
1:  cmp eax, r15d
    jle 2f
    mov r15d, eax
2:  inc rcx
    jmp .Lmm
.Lmm_done:
    sub r15d, r14d                  # max key offset (unsigned 32-bit, zero-extended)
    lea rdi, [r12*4]
    call asm_alloc
    test rax, rax
    jz .Lend
    mov [rsp + 88], rax
    mov r13, rax                    # destination buffer
    mov ebp, 1                      # exp = 10^pass
.Lpass:
    mov rax, r15
    xor edx, edx
    div rbp
    test rax, rax
    jz .Lfinish                     # max / exp == 0 -> every digit consumed
    lea rdi, [rsp]
    xor eax, eax
    mov ecx, 10
    rep stosq                       # clear counters
    xor ecx, ecx
.Lcount:
    cmp rcx, r12
    jae .Lcount_done
    mov eax, [rbx + rcx*4]
    sub eax, r14d
    xor edx, edx
    div rbp
    xor edx, edx
    mov r8d, 10
    div r8
    inc qword ptr [rsp + rdx*8]
    inc rcx
    jmp .Lcount
.Lcount_done:
    xor eax, eax
    xor ecx, ecx
.Lprefix:
    cmp rcx, 10
    jae .Lprefix_done
    mov rdx, [rsp + rcx*8]
    mov [rsp + rcx*8], rax
    add rax, rdx
    inc rcx
    jmp .Lprefix
.Lprefix_done:
    xor ecx, ecx
.Lplace:
    cmp rcx, r12
    jae .Lplace_done
    mov r9d, [rbx + rcx*4]
    mov eax, r9d
    sub eax, r14d
    xor edx, edx
    div rbp
    xor edx, edx
    mov r8d, 10
    div r8                          # rdx = digit
    mov rax, [rsp + rdx*8]
    inc qword ptr [rsp + rdx*8]
    mov [r13 + rax*4], r9d
    inc rcx
    jmp .Lplace
.Lplace_done:
    xchg rbx, r13
    imul rbp, rbp, 10
    jmp .Lpass
.Lfinish:
    mov rdi, [rsp + 80]
    cmp rbx, rdi
    je .Lfree
    mov rsi, rbx
    mov rcx, r12
    rep movsd                       # result lives in scratch: copy back
.Lfree:
    mov rdi, [rsp + 88]
    lea rsi, [r12*4]
    call asm_free
.Lend:
    add rsp, 112
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
