# GENERATED from kernels/algos/double_selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl double_selection_sort_asm
double_selection_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 64
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
    mov [rbp - 32], rax
.Ldouble_selection_sort_wtop2:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Ldouble_selection_sort_wbody3
    jmp .Ldouble_selection_sort_wend4
.Ldouble_selection_sort_wbody3:
    mov rax, [rbp - 24]
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    mov [rbp - 48], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
.Ldouble_selection_sort_wtop5:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Ldouble_selection_sort_wbody6
    jmp .Ldouble_selection_sort_wend7
.Ldouble_selection_sort_wbody6:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Ldouble_selection_sort_then8
    jmp .Ldouble_selection_sort_else9
.Ldouble_selection_sort_then8:
    mov rax, [rbp - 56]
    mov [rbp - 40], rax
    jmp .Ldouble_selection_sort_endif10
.Ldouble_selection_sort_else9:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Ldouble_selection_sort_then11
    jmp .Ldouble_selection_sort_else12
.Ldouble_selection_sort_then11:
    mov rax, [rbp - 56]
    mov [rbp - 48], rax
.Ldouble_selection_sort_else12:
.Ldouble_selection_sort_endif10:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    jmp .Ldouble_selection_sort_wtop5
.Ldouble_selection_sort_wend7:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 40]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Ldouble_selection_sort_then14
    jmp .Ldouble_selection_sort_else15
.Ldouble_selection_sort_then14:
    mov rax, [rbp - 40]
    mov [rbp - 48], rax
.Ldouble_selection_sort_else15:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 48]
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
    add rax, rcx
    mov [rbp - 24], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
    jmp .Ldouble_selection_sort_wtop2
.Ldouble_selection_sort_wend4:
    xor eax, eax
.Ldouble_selection_sort_ret1:
    leave
    ret

.section .note.GNU-stack,"",@progbits
