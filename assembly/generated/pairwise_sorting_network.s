# GENERATED from kernels/algos/pairwise_sorting_network.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl pairwise_sorting_network_asm
pairwise_sorting_network_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 1
    mov [rbp - 24], rax
.Lpairwise_sorting_network_wtop2:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpairwise_sorting_network_wbody3
    jmp .Lpairwise_sorting_network_wend4
.Lpairwise_sorting_network_wbody3:
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 24], rax
    jmp .Lpairwise_sorting_network_wtop2
.Lpairwise_sorting_network_wend4:
    mov rax, 1
    mov [rbp - 32], rax
.Lpairwise_sorting_network_wtop5:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpairwise_sorting_network_wbody6
    jmp .Lpairwise_sorting_network_wend7
.Lpairwise_sorting_network_wbody6:
    mov rax, [rbp - 32]
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 48], rax
.Lpairwise_sorting_network_wtop8:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpairwise_sorting_network_wbody9
    jmp .Lpairwise_sorting_network_wend10
.Lpairwise_sorting_network_wbody9:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call pairwise_sorting_network_x_cmp_swap
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
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lpairwise_sorting_network_then11
    jmp .Lpairwise_sorting_network_else12
.Lpairwise_sorting_network_then11:
    mov rax, 0
    mov [rbp - 48], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
.Lpairwise_sorting_network_else12:
    jmp .Lpairwise_sorting_network_wtop8
.Lpairwise_sorting_network_wend10:
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 32], rax
    jmp .Lpairwise_sorting_network_wtop5
.Lpairwise_sorting_network_wend7:
    mov rax, [rbp - 32]
    push rax
    mov rax, 4
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 32], rax
    mov rax, 1
    mov [rbp - 56], rax
.Lpairwise_sorting_network_wtop14:
    mov rax, [rbp - 32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lpairwise_sorting_network_wbody15
    jmp .Lpairwise_sorting_network_wend16
.Lpairwise_sorting_network_wbody15:
    mov rax, [rbp - 56]
    mov [rbp - 64], rax
.Lpairwise_sorting_network_wtop17:
    mov rax, [rbp - 64]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lpairwise_sorting_network_wbody18
    jmp .Lpairwise_sorting_network_wend19
.Lpairwise_sorting_network_wbody18:
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 48], rax
.Lpairwise_sorting_network_wtop20:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpairwise_sorting_network_wbody21
    jmp .Lpairwise_sorting_network_wend22
.Lpairwise_sorting_network_wbody21:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call pairwise_sorting_network_x_cmp_swap
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
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lpairwise_sorting_network_then23
    jmp .Lpairwise_sorting_network_else24
.Lpairwise_sorting_network_then23:
    mov rax, 0
    mov [rbp - 48], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
.Lpairwise_sorting_network_else24:
    jmp .Lpairwise_sorting_network_wtop20
.Lpairwise_sorting_network_wend22:
    mov rax, [rbp - 64]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 64], rax
    jmp .Lpairwise_sorting_network_wtop17
.Lpairwise_sorting_network_wend19:
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 32], rax
    mov rax, [rbp - 56]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    jmp .Lpairwise_sorting_network_wtop14
.Lpairwise_sorting_network_wend16:
    xor eax, eax
.Lpairwise_sorting_network_ret1:
    leave
    ret

pairwise_sorting_network_x_cmp_swap:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpairwise_sorting_network_then27
    jmp .Lpairwise_sorting_network_else28
.Lpairwise_sorting_network_then27:
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
    jg .Lpairwise_sorting_network_then30
    jmp .Lpairwise_sorting_network_else31
.Lpairwise_sorting_network_then30:
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
.Lpairwise_sorting_network_else31:
.Lpairwise_sorting_network_else28:
    xor eax, eax
.Lpairwise_sorting_network_ret26:
    leave
    ret

.section .note.GNU-stack,"",@progbits
