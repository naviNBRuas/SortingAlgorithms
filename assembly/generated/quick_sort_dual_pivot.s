# GENERATED from kernels/algos/quick_sort_dual_pivot.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl quick_sort_dual_pivot_asm
quick_sort_dual_pivot_asm:
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
    call quick_sort_dual_pivot_x_qs
    xor eax, eax
.Lquick_sort_dual_pivot_ret1:
    leave
    ret

quick_sort_dual_pivot_x_qs:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
.Lquick_sort_dual_pivot_wtop3:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_dual_pivot_wbody4
    jmp .Lquick_sort_dual_pivot_wend5
.Lquick_sort_dual_pivot_wbody4:
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
    jg .Lquick_sort_dual_pivot_then6
    jmp .Lquick_sort_dual_pivot_else7
.Lquick_sort_dual_pivot_then6:
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
.Lquick_sort_dual_pivot_else7:
    mov rax, [rbp - 16]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
.Lquick_sort_dual_pivot_wtop9:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Lquick_sort_dual_pivot_wbody10
    jmp .Lquick_sort_dual_pivot_wend11
.Lquick_sort_dual_pivot_wbody10:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_dual_pivot_then12
    jmp .Lquick_sort_dual_pivot_else13
.Lquick_sort_dual_pivot_then12:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 48]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    jmp .Lquick_sort_dual_pivot_endif14
.Lquick_sort_dual_pivot_else13:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lquick_sort_dual_pivot_then15
    jmp .Lquick_sort_dual_pivot_else16
.Lquick_sort_dual_pivot_then15:
.Lquick_sort_dual_pivot_wtop18:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_dual_pivot_n21
    jmp .Lquick_sort_dual_pivot_wend20
.Lquick_sort_dual_pivot_n21:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lquick_sort_dual_pivot_wbody19
    jmp .Lquick_sort_dual_pivot_wend20
.Lquick_sort_dual_pivot_wbody19:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    jmp .Lquick_sort_dual_pivot_wtop18
.Lquick_sort_dual_pivot_wend20:
    mov rax, [rbp - 64]
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
    mov rax, [rbp - 64]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lquick_sort_dual_pivot_then23
    jmp .Lquick_sort_dual_pivot_else24
.Lquick_sort_dual_pivot_then23:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 48]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
.Lquick_sort_dual_pivot_else24:
.Lquick_sort_dual_pivot_else16:
.Lquick_sort_dual_pivot_endif14:
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
    jmp .Lquick_sort_dual_pivot_wtop9
.Lquick_sort_dual_pivot_wend11:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 16]
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
    mov rax, [rbp - 56]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call quick_sort_dual_pivot_x_qs
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
    call quick_sort_dual_pivot_x_qs
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 16], rax
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lquick_sort_dual_pivot_wtop3
.Lquick_sort_dual_pivot_wend5:
    xor eax, eax
.Lquick_sort_dual_pivot_ret2:
    leave
    ret

.section .note.GNU-stack,"",@progbits
