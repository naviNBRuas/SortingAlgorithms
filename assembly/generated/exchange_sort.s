# GENERATED from kernels/algos/exchange_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl exchange_sort_asm
exchange_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
.Lexchange_sort_ftop2:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 40]
    jl .Lexchange_sort_fbody3
    jmp .Lexchange_sort_fend4
.Lexchange_sort_fbody3:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    mov [rbp - 48], rax
.Lexchange_sort_ftop5:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 48]
    jl .Lexchange_sort_fbody6
    jmp .Lexchange_sort_fend7
.Lexchange_sort_fbody6:
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
    jl .Lexchange_sort_then8
    jmp .Lexchange_sort_else9
.Lexchange_sort_then8:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
.Lexchange_sort_else9:
    inc qword ptr [rbp - 32]
    jmp .Lexchange_sort_ftop5
.Lexchange_sort_fend7:
    inc qword ptr [rbp - 24]
    jmp .Lexchange_sort_ftop2
.Lexchange_sort_fend4:
    xor eax, eax
.Lexchange_sort_ret1:
    leave
    ret

.section .note.GNU-stack,"",@progbits
