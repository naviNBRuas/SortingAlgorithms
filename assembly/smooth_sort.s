# void smooth_sort_asm(int *arr, size_t n)
# Dijkstra's smoothsort over Leonardo heaps (Orson Peters' formulation).
# O(n) on sorted input, O(n log n) worst case, O(1) extra space (a 512-byte Leonardo table on the stack).
#   r15 = Leonardo table   rbx = arr   r12 = p (heap-shape bitmap)   r13 = head
#   r14 = pshift (order of the rightmost heap)   rbp = index of last element
.intel_syntax noprefix
.text
.globl smooth_sort_asm
smooth_sort_asm:
    cmp rsi, 2
    jb .Lret
    push rbx
    push r12
    push r13
    push r14
    push r15
    push rbp
    sub rsp, 512
    mov r15, rsp
    mov rbx, rdi
    mov qword ptr [r15], 1
    mov qword ptr [r15 + 8], 1
    mov ecx, 2
.Llp:
    mov rax, [r15 + rcx*8 - 8]
    add rax, [r15 + rcx*8 - 16]
    inc rax
    mov [r15 + rcx*8], rax
    inc rcx
    cmp rcx, 64
    jb .Llp
    lea rbp, [rsi - 1]
    xor r13d, r13d
    mov r12d, 1
    mov r14d, 1
.Lbuild:
    cmp r13, rbp
    jae .Lbuilt
    mov rax, r12
    and eax, 3
    cmp eax, 3
    jne .Ladd
    mov rcx, r13                    # two adjacent heaps merge under a new root
    mov r8, r14
    call .Lsift
    shr r12, 2
    add r14, 2
    jmp .Lnext
.Ladd:
    mov rax, [r15 + r14*8 - 8]      # LP[pshift-1]
    mov rdx, rbp
    sub rdx, r13
    cmp rax, rdx
    jb .Lsift_only
    mov rcx, r13                    # final-size block: restore the whole forest invariant
    mov rsi, r12
    mov r8, r14
    xor edi, edi
    call .Ltrinkle
    jmp .Lshape
.Lsift_only:
    mov rcx, r13
    mov r8, r14
    call .Lsift
.Lshape:
    cmp r14, 1
    jne .Lbig_shift
    shl r12, 1
    xor r14d, r14d
    jmp .Lnext
.Lbig_shift:
    lea rcx, [r14 - 1]
    shl r12, cl
    mov r14d, 1
.Lnext:
    or r12, 1
    inc r13
    jmp .Lbuild
.Lbuilt:
    mov rcx, r13
    mov rsi, r12
    mov r8, r14
    xor edi, edi
    call .Ltrinkle
.Ldeheap:
    cmp r14, 1
    jne .Lbody
    cmp r12, 1
    je .Ldone
.Lbody:
    cmp r14, 1
    ja .Lsplit
    mov rax, r12                    # block of length 1: drop trailing zero bits
    and rax, -2
    bsf rax, rax
    mov rcx, rax
    shr r12, cl
    add r14, rax
    jmp .Lpop
.Lsplit:                            # break the rightmost heap into its two children
    shl r12, 2
    xor r12, 7
    sub r14, 2
    mov rax, [r15 + r14*8]
    mov rcx, r13
    sub rcx, rax
    dec rcx
    mov rsi, r12
    shr rsi, 1
    lea r8, [r14 + 1]
    mov edi, 1
    call .Ltrinkle
    lea rcx, [r13 - 1]
    mov rsi, r12
    mov r8, r14
    mov edi, 1
    call .Ltrinkle
.Lpop:
    dec r13
    jmp .Ldeheap
.Ldone:
    add rsp, 512
    pop rbp
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbx
.Lret:
    ret

# sift(head = rcx, pshift = r8): sink arr[head] through its Leonardo heap.
.Lsift:
    mov r9d, [rbx + rcx*4]          # val
.Lsift_loop:
    cmp r8, 1
    jle .Lsift_done
    lea r10, [rcx - 1]              # right child
    mov rax, [r15 + r8*8 - 16]
    mov r11, r10
    sub r11, rax                    # left child
    mov eax, [rbx + r10*4]
    mov edx, [rbx + r11*4]
    cmp r9d, edx
    jl .Lsift_move
    cmp r9d, eax
    jge .Lsift_done
.Lsift_move:
    cmp edx, eax
    jl .Lsift_right
    mov [rbx + rcx*4], edx          # left child is the larger one
    mov rcx, r11
    dec r8
    jmp .Lsift_loop
.Lsift_right:
    mov [rbx + rcx*4], eax
    mov rcx, r10
    sub r8, 2
    jmp .Lsift_loop
.Lsift_done:
    mov [rbx + rcx*4], r9d
    ret

# trinkle(head = rcx, p = rsi, pshift = r8, trusty = rdi)
.Ltrinkle:
    mov r9d, [rbx + rcx*4]          # val
.Ltrk_loop:
    cmp rsi, 1
    je .Ltrk_done
    mov rax, [r15 + r8*8]
    mov r10, rcx
    sub r10, rax                    # stepson
    mov eax, [rbx + r10*4]
    cmp eax, r9d
    jle .Ltrk_done
    test rdi, rdi
    jnz .Ltrk_move
    cmp r8, 1
    jle .Ltrk_move
    lea r11, [rcx - 1]              # right child
    mov rdx, [r15 + r8*8 - 16]
    neg rdx
    add rdx, r11                    # left child
    cmp [rbx + r11*4], eax
    jge .Ltrk_done
    cmp [rbx + rdx*4], eax
    jge .Ltrk_done
.Ltrk_move:
    mov [rbx + rcx*4], eax
    mov rcx, r10
    mov rax, rsi
    and rax, -2
    bsf rax, rax                    # trailing zeros of p & ~1
    push rcx
    mov rcx, rax
    shr rsi, cl
    pop rcx
    add r8, rax
    xor edi, edi
    jmp .Ltrk_loop
.Ltrk_done:
    test rdi, rdi
    jnz .Ltrk_ret
    mov [rbx + rcx*4], r9d
    call .Lsift
.Ltrk_ret:
    ret
.section .note.GNU-stack,"",@progbits
