# GENERATED from kernels/algos/circle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl circle_sort_asm
circle_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 1
    mov [rbp - 24], rax
.Lcircle_sort_wtop2:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lcircle_sort_wbody3
    jmp .Lcircle_sort_wend4
.Lcircle_sort_wbody3:
    mov rax, [rbp - 8]
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call circle_sort_x_circle_pass
    mov [rbp - 24], rax
    jmp .Lcircle_sort_wtop2
.Lcircle_sort_wend4:
    xor eax, eax
.Lcircle_sort_ret1:
    leave
    ret

circle_sort_x_circle_pass:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcircle_sort_then6
    jmp .Lcircle_sort_else7
.Lcircle_sort_then6:
    mov rax, 0
    jmp .Lcircle_sort_ret5
.Lcircle_sort_else7:
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 48], rax
    mov rax, 0
    mov [rbp - 56], rax
.Lcircle_sort_wtop9:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcircle_sort_wbody10
    jmp .Lcircle_sort_wend11
.Lcircle_sort_wbody10:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcircle_sort_then12
    jmp .Lcircle_sort_else13
.Lcircle_sort_then12:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
.Lcircle_sort_else13:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    jmp .Lcircle_sort_wtop9
.Lcircle_sort_wend11:
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lcircle_sort_then15
    jmp .Lcircle_sort_else16
.Lcircle_sort_then15:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcircle_sort_then18
    jmp .Lcircle_sort_else19
.Lcircle_sort_then18:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
.Lcircle_sort_else19:
.Lcircle_sort_else16:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call circle_sort_x_circle_pass
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call circle_sort_x_circle_pass
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    jmp .Lcircle_sort_ret5
    xor eax, eax
.Lcircle_sort_ret5:
    leave
    ret

.section .note.GNU-stack,"",@progbits
