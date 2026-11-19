# GENERATED from kernels/algos/bingo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl bingo_sort_asm
bingo_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbingo_sort_then2
    jmp .Lbingo_sort_else3
.Lbingo_sort_then2:
    jmp .Lbingo_sort_ret1
.Lbingo_sort_else3:
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
.Lbingo_sort_wtop5:
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lbingo_sort_wbody6
    jmp .Lbingo_sort_wend7
.Lbingo_sort_wbody6:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbingo_sort_then8
    jmp .Lbingo_sort_else9
.Lbingo_sort_then8:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
.Lbingo_sort_else9:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
    jmp .Lbingo_sort_wtop5
.Lbingo_sort_wend7:
.Lbingo_sort_wtop11:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbingo_sort_n14
    jmp .Lbingo_sort_wend13
.Lbingo_sort_n14:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lbingo_sort_wbody12
    jmp .Lbingo_sort_wend13
.Lbingo_sort_wbody12:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lbingo_sort_wtop11
.Lbingo_sort_wend13:
.Lbingo_sort_wtop16:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbingo_sort_wbody17
    jmp .Lbingo_sort_wend18
.Lbingo_sort_wbody17:
    mov rax, [rbp - 32]
    mov [rbp - 48], rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
.Lbingo_sort_wtop19:
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lbingo_sort_wbody20
    jmp .Lbingo_sort_wend21
.Lbingo_sort_wbody20:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lbingo_sort_then22
    jmp .Lbingo_sort_else23
.Lbingo_sort_then22:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lbingo_sort_endif24
.Lbingo_sort_else23:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbingo_sort_then25
    jmp .Lbingo_sort_else26
.Lbingo_sort_then25:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
.Lbingo_sort_else26:
.Lbingo_sort_endif24:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
    jmp .Lbingo_sort_wtop19
.Lbingo_sort_wend21:
.Lbingo_sort_wtop28:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbingo_sort_n31
    jmp .Lbingo_sort_wend30
.Lbingo_sort_n31:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lbingo_sort_wbody29
    jmp .Lbingo_sort_wend30
.Lbingo_sort_wbody29:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lbingo_sort_wtop28
.Lbingo_sort_wend30:
    jmp .Lbingo_sort_wtop16
.Lbingo_sort_wend18:
    xor eax, eax
.Lbingo_sort_ret1:
    leave
    ret

.section .note.GNU-stack,"",@progbits
