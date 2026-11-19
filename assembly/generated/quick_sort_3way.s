# GENERATED from kernels/algos/quick_sort_3way.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl quick_sort_3way_asm
quick_sort_3way_asm:
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
    call quick_sort_3way_x_qs
    xor eax, eax
.Lquick_sort_3way_ret1:
    leave
    ret

quick_sort_3way_x_qs:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
.Lquick_sort_3way_wtop3:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_3way_wbody4
    jmp .Lquick_sort_3way_wend5
.Lquick_sort_3way_wbody4:
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
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 48], rax
    mov rax, [rbp - 24]
    mov [rbp - 56], rax
.Lquick_sort_3way_wtop6:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Lquick_sort_3way_wbody7
    jmp .Lquick_sort_3way_wend8
.Lquick_sort_3way_wbody7:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_3way_then9
    jmp .Lquick_sort_3way_else10
.Lquick_sort_3way_then9:
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
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    jmp .Lquick_sort_3way_endif11
.Lquick_sort_3way_else10:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lquick_sort_3way_then12
    jmp .Lquick_sort_3way_else13
.Lquick_sort_3way_then12:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 56]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    jmp .Lquick_sort_3way_endif14
.Lquick_sort_3way_else13:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
.Lquick_sort_3way_endif14:
.Lquick_sort_3way_endif11:
    jmp .Lquick_sort_3way_wtop6
.Lquick_sort_3way_wend8:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_3way_then15
    jmp .Lquick_sort_3way_else16
.Lquick_sort_3way_then15:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call quick_sort_3way_x_qs
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 16], rax
    jmp .Lquick_sort_3way_endif17
.Lquick_sort_3way_else16:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 56]
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
    call quick_sort_3way_x_qs
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
.Lquick_sort_3way_endif17:
    jmp .Lquick_sort_3way_wtop3
.Lquick_sort_3way_wend5:
    xor eax, eax
.Lquick_sort_3way_ret2:
    leave
    ret

.section .note.GNU-stack,"",@progbits
