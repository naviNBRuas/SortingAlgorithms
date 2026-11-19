# GENERATED from kernels/algos/slow_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl slow_sort_asm
slow_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, [rbp - 8]
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call slow_sort_x_slow
    xor eax, eax
.Lslow_sort_ret1:
    leave
    ret

slow_sort_x_slow:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lslow_sort_then3
    jmp .Lslow_sort_else4
.Lslow_sort_then3:
    jmp .Lslow_sort_ret2
.Lslow_sort_else4:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 32], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call slow_sort_x_slow
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call slow_sort_x_slow
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lslow_sort_then6
    jmp .Lslow_sort_else7
.Lslow_sort_then6:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
.Lslow_sort_else7:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call slow_sort_x_slow
    xor eax, eax
.Lslow_sort_ret2:
    leave
    ret

.section .note.GNU-stack,"",@progbits
