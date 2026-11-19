# GENERATED from kernels/algos/quick_sort_hoare.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl quick_sort_hoare_asm
quick_sort_hoare_asm:
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
    call quick_sort_hoare_x_qs
    xor eax, eax
.Lquick_sort_hoare_ret1:
    leave
    ret

quick_sort_hoare_x_qs:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
.Lquick_sort_hoare_wtop3:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_hoare_wbody4
    jmp .Lquick_sort_hoare_wend5
.Lquick_sort_hoare_wbody4:
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
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    mov rax, 1
    mov [rbp - 56], rax
.Lquick_sort_hoare_wtop6:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lquick_sort_hoare_wbody7
    jmp .Lquick_sort_hoare_wend8
.Lquick_sort_hoare_wbody7:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
.Lquick_sort_hoare_wtop9:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_hoare_wbody10
    jmp .Lquick_sort_hoare_wend11
.Lquick_sort_hoare_wbody10:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
    jmp .Lquick_sort_hoare_wtop9
.Lquick_sort_hoare_wend11:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
.Lquick_sort_hoare_wtop12:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lquick_sort_hoare_wbody13
    jmp .Lquick_sort_hoare_wend14
.Lquick_sort_hoare_wbody13:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    jmp .Lquick_sort_hoare_wtop12
.Lquick_sort_hoare_wend14:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lquick_sort_hoare_then15
    jmp .Lquick_sort_hoare_else16
.Lquick_sort_hoare_then15:
    mov rax, 0
    mov [rbp - 56], rax
    jmp .Lquick_sort_hoare_endif17
.Lquick_sort_hoare_else16:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 48]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
.Lquick_sort_hoare_endif17:
    jmp .Lquick_sort_hoare_wtop6
.Lquick_sort_hoare_wend8:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_hoare_then18
    jmp .Lquick_sort_hoare_else19
.Lquick_sort_hoare_then18:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call quick_sort_hoare_x_qs
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 16], rax
    jmp .Lquick_sort_hoare_endif20
.Lquick_sort_hoare_else19:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 48]
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
    call quick_sort_hoare_x_qs
    mov rax, [rbp - 48]
    mov [rbp - 24], rax
.Lquick_sort_hoare_endif20:
    jmp .Lquick_sort_hoare_wtop3
.Lquick_sort_hoare_wend5:
    xor eax, eax
.Lquick_sort_hoare_ret2:
    leave
    ret

.section .note.GNU-stack,"",@progbits
