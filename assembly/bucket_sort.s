# void bucket_sort_asm(int *arr, size_t n)
# n buckets spread evenly over [min, max]; stable scatter, then insertion sort per bucket.
.intel_syntax noprefix
.text
.globl bucket_sort_asm
bucket_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    push rbp
    sub rsp, 16                     # [rsp] bucket index, [rsp+8] previous bucket end
    mov rbx, rdi
    mov r12, rsi
    movsxd r13, dword ptr [rbx]     # min
    mov r14, r13                    # max
    mov ecx, 1
.Lmm:
    cmp rcx, r12
    jae .Lmm_done
    movsxd rax, dword ptr [rbx + rcx*4]
    cmp rax, r13
    jge 1f
    mov r13, rax
1:  cmp rax, r14
    jle 2f
    mov r14, rax
2:  inc rcx
    jmp .Lmm
.Lmm_done:
    sub r14, r13                    # range
    jz .Lend                        # all equal
    lea rdi, [r12*2 + 1]
    shl rdi, 2
    call asm_alloc                  # [counters: n+1 dwords][scratch output: n dwords]
    test rax, rax
    jz .Lend
    mov r15, rax
    lea rbp, [r15 + r12*4 + 4]      # scratch output
    lea r10, [r12 - 1]
    xor r9d, r9d
.Lcount:
    cmp r9, r12
    jae .Lcount_done
    movsxd rax, dword ptr [rbx + r9*4]
    sub rax, r13
    imul rax, r10
    xor edx, edx
    div r14                         # bucket index
    inc dword ptr [r15 + rax*4]
    inc r9
    jmp .Lcount
.Lcount_done:
    xor eax, eax
    xor ecx, ecx
.Lprefix:
    cmp rcx, r12
    jae .Lprefix_done
    mov edx, [r15 + rcx*4]
    mov [r15 + rcx*4], eax
    add eax, edx
    inc rcx
    jmp .Lprefix
.Lprefix_done:
    xor r9d, r9d
.Lscatter:
    cmp r9, r12
    jae .Lscatter_done
    mov r11d, [rbx + r9*4]
    movsxd rax, r11d
    sub rax, r13
    imul rax, r10
    xor edx, edx
    div r14
    mov ecx, [r15 + rax*4]          # next free slot of this bucket
    lea r8d, [rcx + 1]
    mov [r15 + rax*4], r8d
    mov [rbp + rcx*4], r11d
    inc r9
    jmp .Lscatter
.Lscatter_done:                     # counters now hold each bucket's end offset
    mov qword ptr [rsp], 0
    mov qword ptr [rsp + 8], 0
.Lsort_buckets:
    mov rax, [rsp]
    cmp rax, r12
    jae .Lcopy
    mov ecx, [r15 + rax*4]          # end
    mov rdx, [rsp + 8]              # start
    mov [rsp + 8], rcx
    inc qword ptr [rsp]
    mov rsi, rcx
    sub rsi, rdx
    cmp rsi, 2
    jb .Lsort_buckets
    lea rdi, [rbp + rdx*4]
    call insertion_sort_asm
    jmp .Lsort_buckets
.Lcopy:
    mov rsi, rbp
    mov rdi, rbx
    mov rcx, r12
    rep movsd
    mov rdi, r15
    lea rsi, [r12*2 + 1]
    shl rsi, 2
    call asm_free
.Lend:
    add rsp, 16
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
