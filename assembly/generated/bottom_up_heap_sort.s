# GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl bottom_up_heap_sort_asm
bottom_up_heap_sort_asm:
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
    cqo
    idiv rcx
    mov [rbp - 24], rax
.Lbottom_up_heap_sort_wtop2:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbottom_up_heap_sort_wbody3
    jmp .Lbottom_up_heap_sort_wend4
.Lbottom_up_heap_sort_wbody3:
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
    call bottom_up_heap_sort_x_sift
    jmp .Lbottom_up_heap_sort_wtop2
.Lbottom_up_heap_sort_wend4:
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
.Lbottom_up_heap_sort_wtop5:
    mov rax, [rbp - 32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lbottom_up_heap_sort_wbody6
    jmp .Lbottom_up_heap_sort_wend7
.Lbottom_up_heap_sort_wbody6:
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
    call bottom_up_heap_sort_x_sift
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
    jmp .Lbottom_up_heap_sort_wtop5
.Lbottom_up_heap_sort_wend7:
    xor eax, eax
.Lbottom_up_heap_sort_ret1:
    leave
    ret

bottom_up_heap_sort_x_sift:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 16]
    mov [rbp - 32], rax
.Lbottom_up_heap_sort_wtop9:
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbottom_up_heap_sort_wbody10
    jmp .Lbottom_up_heap_sort_wend11
.Lbottom_up_heap_sort_wbody10:
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbottom_up_heap_sort_then12
    jmp .Lbottom_up_heap_sort_else13
.Lbottom_up_heap_sort_then12:
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
    jmp .Lbottom_up_heap_sort_endif14
.Lbottom_up_heap_sort_else13:
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
.Lbottom_up_heap_sort_endif14:
    jmp .Lbottom_up_heap_sort_wtop9
.Lbottom_up_heap_sort_wend11:
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbottom_up_heap_sort_then15
    jmp .Lbottom_up_heap_sort_else16
.Lbottom_up_heap_sort_then15:
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
.Lbottom_up_heap_sort_else16:
    mov rax, [rbp - 16]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
.Lbottom_up_heap_sort_wtop18:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lbottom_up_heap_sort_wbody19
    jmp .Lbottom_up_heap_sort_wend20
.Lbottom_up_heap_sort_wbody19:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 32], rax
    jmp .Lbottom_up_heap_sort_wtop18
.Lbottom_up_heap_sort_wend20:
    mov rax, [rbp - 16]
    mov [rbp - 48], rax
.Lbottom_up_heap_sort_wtop21:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Lbottom_up_heap_sort_wbody22
    jmp .Lbottom_up_heap_sort_wend23
.Lbottom_up_heap_sort_wbody22:
    mov rax, [rbp - 32]
    mov [rbp - 56], rax
.Lbottom_up_heap_sort_wtop24:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Lbottom_up_heap_sort_wbody25
    jmp .Lbottom_up_heap_sort_wend26
.Lbottom_up_heap_sort_wbody25:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 56], rax
    jmp .Lbottom_up_heap_sort_wtop24
.Lbottom_up_heap_sort_wend26:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    mov [rbp - 48], rax
    jmp .Lbottom_up_heap_sort_wtop21
.Lbottom_up_heap_sort_wend23:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    xor eax, eax
.Lbottom_up_heap_sort_ret8:
    leave
    ret

.section .note.GNU-stack,"",@progbits
