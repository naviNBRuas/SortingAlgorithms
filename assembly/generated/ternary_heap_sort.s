# GENERATED from kernels/algos/ternary_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl ternary_heap_sort_asm
ternary_heap_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lternary_heap_sort_then2
    jmp .Lternary_heap_sort_else3
.Lternary_heap_sort_then2:
    jmp .Lternary_heap_sort_ret1
.Lternary_heap_sort_else3:
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 24], rax
.Lternary_heap_sort_wtop5:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lternary_heap_sort_wbody6
    jmp .Lternary_heap_sort_wend7
.Lternary_heap_sort_wbody6:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call ternary_heap_sort_x_sift
    jmp .Lternary_heap_sort_wtop5
.Lternary_heap_sort_wend7:
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
.Lternary_heap_sort_wtop8:
    mov rax, [rbp - 32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lternary_heap_sort_wbody9
    jmp .Lternary_heap_sort_wend10
.Lternary_heap_sort_wbody9:
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 8]
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call ternary_heap_sort_x_sift
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
    jmp .Lternary_heap_sort_wtop8
.Lternary_heap_sort_wend10:
    xor eax, eax
.Lternary_heap_sort_ret1:
    leave
    ret

ternary_heap_sort_x_sift:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, 1
    mov [rbp - 32], rax
.Lternary_heap_sort_wtop12:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lternary_heap_sort_wbody13
    jmp .Lternary_heap_sort_wend14
.Lternary_heap_sort_wbody13:
    mov rax, 3
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lternary_heap_sort_then15
    jmp .Lternary_heap_sort_else16
.Lternary_heap_sort_then15:
    mov rax, 0
    mov [rbp - 32], rax
    jmp .Lternary_heap_sort_endif17
.Lternary_heap_sort_else16:
    mov rax, [rbp - 40]
    mov [rbp - 48], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
.Lternary_heap_sort_wtop18:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lternary_heap_sort_n21
    jmp .Lternary_heap_sort_wend20
.Lternary_heap_sort_n21:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lternary_heap_sort_wbody19
    jmp .Lternary_heap_sort_wend20
.Lternary_heap_sort_wbody19:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lternary_heap_sort_then23
    jmp .Lternary_heap_sort_else24
.Lternary_heap_sort_then23:
    mov rax, [rbp - 56]
    mov [rbp - 48], rax
.Lternary_heap_sort_else24:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    jmp .Lternary_heap_sort_wtop18
.Lternary_heap_sort_wend20:
    mov rax, [rbp - 16]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lternary_heap_sort_then26
    jmp .Lternary_heap_sort_else27
.Lternary_heap_sort_then26:
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
    mov rax, [rbp - 48]
    mov [rbp - 16], rax
    jmp .Lternary_heap_sort_endif28
.Lternary_heap_sort_else27:
    mov rax, 0
    mov [rbp - 32], rax
.Lternary_heap_sort_endif28:
.Lternary_heap_sort_endif17:
    jmp .Lternary_heap_sort_wtop12
.Lternary_heap_sort_wend14:
    xor eax, eax
.Lternary_heap_sort_ret11:
    leave
    ret

.section .note.GNU-stack,"",@progbits
