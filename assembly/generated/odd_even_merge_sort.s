# GENERATED from kernels/algos/odd_even_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl odd_even_merge_sort_asm
odd_even_merge_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 1
    mov [rbp - 24], rax
.Lodd_even_merge_sort_wtop2:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lodd_even_merge_sort_wbody3
    jmp .Lodd_even_merge_sort_wend4
.Lodd_even_merge_sort_wbody3:
    mov rax, [rbp - 24]
    mov [rbp - 32], rax
.Lodd_even_merge_sort_wtop5:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lodd_even_merge_sort_wbody6
    jmp .Lodd_even_merge_sort_wend7
.Lodd_even_merge_sort_wbody6:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    mov [rbp - 40], rax
.Lodd_even_merge_sort_wtop8:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lodd_even_merge_sort_wbody9
    jmp .Lodd_even_merge_sort_wend10
.Lodd_even_merge_sort_wbody9:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    pop rcx
    cmp rcx, rax
    cmovl rax, rcx
    mov [rbp - 48], rax
    mov rax, 0
    mov [rbp - 56], rax
    mov rax, [rbp - 48]
    mov [rbp - 64], rax
.Lodd_even_merge_sort_ftop11:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 64]
    jl .Lodd_even_merge_sort_fbody12
    jmp .Lodd_even_merge_sort_fend13
.Lodd_even_merge_sort_fbody12:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lodd_even_merge_sort_then14
    jmp .Lodd_even_merge_sort_else15
.Lodd_even_merge_sort_then14:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call odd_even_merge_sort_x_cmp_swap
.Lodd_even_merge_sort_else15:
    inc qword ptr [rbp - 56]
    jmp .Lodd_even_merge_sort_ftop11
.Lodd_even_merge_sort_fend13:
    mov rax, [rbp - 40]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
    jmp .Lodd_even_merge_sort_wtop8
.Lodd_even_merge_sort_wend10:
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 32], rax
    jmp .Lodd_even_merge_sort_wtop5
.Lodd_even_merge_sort_wend7:
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 24], rax
    jmp .Lodd_even_merge_sort_wtop2
.Lodd_even_merge_sort_wend4:
    xor eax, eax
.Lodd_even_merge_sort_ret1:
    leave
    ret

odd_even_merge_sort_x_cmp_swap:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 16]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lodd_even_merge_sort_then18
    jmp .Lodd_even_merge_sort_else19
.Lodd_even_merge_sort_then18:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
.Lodd_even_merge_sort_else19:
    xor eax, eax
.Lodd_even_merge_sort_ret17:
    leave
    ret

.section .note.GNU-stack,"",@progbits
