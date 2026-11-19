# GENERATED from kernels/algos/bozo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl bozo_sort_asm
bozo_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, 987654321
    mov [rbp - 32], rax
    mov rax, 0
    mov [rbp - 40], rax
.Lbozo_sort_wtop2:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rsi
    pop rdi
    call bozo_sort_x_is_sorted
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lbozo_sort_n5
    jmp .Lbozo_sort_wend4
.Lbozo_sort_n5:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbozo_sort_wbody3
    jmp .Lbozo_sort_wend4
.Lbozo_sort_wbody3:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1103515245
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 12345
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2147483648
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    mov [rbp - 48], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1103515245
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 12345
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2147483648
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    mov [rbp - 32], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 16
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
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
    jmp .Lbozo_sort_wtop2
.Lbozo_sort_wend4:
    xor eax, eax
.Lbozo_sort_ret1:
    leave
    ret

bozo_sort_x_is_sorted:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, 0
    mov [rbp - 24], rax
.Lbozo_sort_wtop8:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbozo_sort_wbody9
    jmp .Lbozo_sort_wend10
.Lbozo_sort_wbody9:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbozo_sort_then11
    jmp .Lbozo_sort_else12
.Lbozo_sort_then11:
    mov rax, 0
    jmp .Lbozo_sort_ret7
.Lbozo_sort_else12:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 24], rax
    jmp .Lbozo_sort_wtop8
.Lbozo_sort_wend10:
    mov rax, 1
    jmp .Lbozo_sort_ret7
    xor eax, eax
.Lbozo_sort_ret7:
    leave
    ret

.section .note.GNU-stack,"",@progbits
