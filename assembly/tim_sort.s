# void tim_sort_asm(int *arr, size_t n)
# TimSort without galloping: natural-run detection (strictly descending runs are reversed),
# minrun extension with insertion sort, a run stack kept balanced by CPython's merge-collapse
# invariants, and stable merges through an mmap'd scratch buffer.
#   rbx = arr   r12 = n   r13 = scratch   r14 = #runs   r15 = minrun
#   rbp = frame: run starts [rbp + 8i], run lengths [rbp + 512 + 8i], next run start [rbp + 1024]
.intel_syntax noprefix
.text
.globl tim_sort_asm
tim_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    push rbp
    sub rsp, 1040
    mov rbp, rsp
    mov rbx, rdi
    mov r12, rsi
    lea rdi, [r12*4]
    call asm_alloc
    test rax, rax
    jz .Lfallback
    mov r13, rax
    xor r14d, r14d
    mov qword ptr [rbp + 1024], 0
    mov rax, r12                    # minrun: keep 6 bits, round up if any dropped bit was set
    xor ecx, ecx
.Lminrun:
    cmp rax, 64
    jb .Lminrun_done
    mov rdx, rax
    and edx, 1
    or rcx, rdx
    shr rax, 1
    jmp .Lminrun
.Lminrun_done:
    add rax, rcx
    mov r15, rax
.Lnext_run:
    mov r10, [rbp + 1024]           # lo
    cmp r10, r12
    jae .Lfinal_merge
    lea r8, [r10 + 1]               # r = end of the natural run
    cmp r8, r12
    jae .Lrun_found
    mov eax, [rbx + r8*4]
    cmp eax, [rbx + r8*4 - 4]
    jge .Lascending
.Ldescending:
    inc r8
    cmp r8, r12
    jae .Ldesc_done
    mov eax, [rbx + r8*4]
    cmp eax, [rbx + r8*4 - 4]
    jl .Ldescending
.Ldesc_done:
    mov rcx, r10                    # reverse arr[lo .. r)
    lea rdx, [r8 - 1]
.Lreverse:
    cmp rcx, rdx
    jae .Lrun_found
    mov eax, [rbx + rcx*4]
    mov r9d, [rbx + rdx*4]
    mov [rbx + rcx*4], r9d
    mov [rbx + rdx*4], eax
    inc rcx
    dec rdx
    jmp .Lreverse
.Lascending:
    inc r8
    cmp r8, r12
    jae .Lrun_found
    mov eax, [rbx + r8*4]
    cmp eax, [rbx + r8*4 - 4]
    jge .Lascending
.Lrun_found:
    mov r9, r12                     # force = min(minrun, n - lo)
    sub r9, r10
    cmp r9, r15
    jbe 1f
    mov r9, r15
1:  mov rax, r8
    sub rax, r10
    cmp rax, r9
    jae .Lpush
    lea rdi, [rbx + r10*4]          # extend a short run: insertion-sort arr[lo, lo+force)
    mov rsi, r9
    call insertion_sort_asm
    mov r10, [rbp + 1024]
    mov r8, r12
    sub r8, r10
    cmp r8, r15
    jbe 2f
    mov r8, r15
2:  add r8, r10                     # run end = lo + force
.Lpush:
    mov r10, [rbp + 1024]
    mov rax, r8
    sub rax, r10
    mov [rbp + r14*8], r10
    mov [rbp + 512 + r14*8], rax
    inc r14
    mov [rbp + 1024], r8            # next run starts where this one ended
    call .Lcollapse
    jmp .Lnext_run
.Lfinal_merge:
    cmp r14, 1
    jbe .Lfree
    lea rcx, [r14 - 2]
    test rcx, rcx
    jz .Lfm
    mov rax, [rbp + 512 + rcx*8 - 8]
    cmp rax, [rbp + 512 + rcx*8 + 8]
    jae .Lfm
    dec rcx
.Lfm:
    call .Lmerge_at
    jmp .Lfinal_merge
.Lfree:
    mov rdi, r13
    lea rsi, [r12*4]
    call asm_free
    add rsp, 1040
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret
.Lfallback:
    mov rdi, rbx
    mov rsi, r12
    add rsp, 1040
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
    jmp heap_sort_asm

# Restore the run-stack invariants (X > Y + Z and Y > Z for the top three lengths).
.Lcollapse:
    cmp r14, 1
    jbe .Lcl_ret
    lea rcx, [r14 - 2]              # m
    mov rax, [rbp + 512 + rcx*8]    # L[m]
    mov rdx, [rbp + 512 + rcx*8 + 8]  # L[m+1]
    lea r9, [rax + rdx]
    xor r10d, r10d
    test rcx, rcx
    jz .Lc2
    cmp [rbp + 512 + rcx*8 - 8], r9
    ja .Lc2
    mov r10d, 1                     # L[m-1] <= L[m] + L[m+1]
.Lc2:
    cmp rcx, 1
    jbe .Lc2_done
    mov r11, [rbp + 512 + rcx*8 - 8]
    add r11, rax
    cmp [rbp + 512 + rcx*8 - 16], r11
    ja .Lc2_done
    mov r10d, 1                     # L[m-2] <= L[m-1] + L[m]
.Lc2_done:
    test r10d, r10d
    jz .Lcl_else
    test rcx, rcx
    jz .Lcl_merge
    mov r11, [rbp + 512 + rcx*8 - 8]
    cmp r11, rdx
    jae .Lcl_merge
    dec rcx                         # merge the smaller neighbour first
.Lcl_merge:
    call .Lmerge_at
    jmp .Lcollapse
.Lcl_else:
    cmp rax, rdx
    ja .Lcl_ret                     # L[m] > L[m+1]: balanced
    jmp .Lcl_merge
.Lcl_ret:
    ret

# Merge runs rcx and rcx+1 (stable): copy the left run to scratch, merge forward into arr.
.Lmerge_at:
    mov r8, [rbp + rcx*8]           # start of left run
    mov r9, [rbp + 512 + rcx*8]     # left length
    mov r10, [rbp + 512 + rcx*8 + 8]  # right length
    lea r11, [r9 + r10]
    mov [rbp + 512 + rcx*8], r11    # combined run replaces the pair
    lea rax, [rcx + 2]
.Lshift:                            # close the gap in the run stack
    cmp rax, r14
    jae .Lshifted
    mov rdx, [rbp + rax*8]
    mov [rbp + rax*8 - 8], rdx
    mov rdx, [rbp + 512 + rax*8]
    mov [rbp + 512 + rax*8 - 8], rdx
    inc rax
    jmp .Lshift
.Lshifted:
    dec r14
    lea rsi, [rbx + r8*4]
    mov rdi, r13
    mov rcx, r9
    rep movsd                       # scratch = left run
    xor esi, esi                    # i over scratch
    lea rdx, [r8 + r9]              # j over right run
    mov rdi, r8                     # k over arr
    lea r11, [rdx + r10]            # end of right run
.Lmg:
    cmp rsi, r9
    jae .Lmg_ret                    # left exhausted: the rest of the right run is in place
    cmp rdx, r11
    jae .Lmg_left
    mov eax, [r13 + rsi*4]
    mov ecx, [rbx + rdx*4]
    cmp ecx, eax
    jl .Lmg_right                   # take right only when strictly smaller -> stable
    mov [rbx + rdi*4], eax
    inc rsi
    inc rdi
    jmp .Lmg
.Lmg_right:
    mov [rbx + rdi*4], ecx
    inc rdx
    inc rdi
    jmp .Lmg
.Lmg_left:
    cmp rsi, r9
    jae .Lmg_ret
    mov eax, [r13 + rsi*4]
    mov [rbx + rdi*4], eax
    inc rsi
    inc rdi
    jmp .Lmg_left
.Lmg_ret:
    ret
.section .note.GNU-stack,"",@progbits
