# GENERATED from kernels/algos/in_place_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl in_place_merge_sort_asm
in_place_merge_sort_asm:
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
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_rec
    xor eax, eax
.Lin_place_merge_sort_ret1:
    leave
    ret

in_place_merge_sort_x_reverse:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
.Lin_place_merge_sort_wtop3:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_wbody4
    jmp .Lin_place_merge_sort_wend5
.Lin_place_merge_sort_wbody4:
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
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 16], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lin_place_merge_sort_wtop3
.Lin_place_merge_sort_wend5:
    xor eax, eax
.Lin_place_merge_sort_ret2:
    leave
    ret

in_place_merge_sort_x_rotate:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_reverse
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_reverse
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_reverse
    xor eax, eax
.Lin_place_merge_sort_ret6:
    leave
    ret

in_place_merge_sort_x_merge:
    push rbp
    mov rbp, rsp
    sub rsp, 96
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lin_place_merge_sort_then8
    jmp .Lin_place_merge_sort_n11
.Lin_place_merge_sort_n11:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lin_place_merge_sort_then8
    jmp .Lin_place_merge_sort_else9
.Lin_place_merge_sort_then8:
    jmp .Lin_place_merge_sort_ret7
.Lin_place_merge_sort_else9:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lin_place_merge_sort_then13
    jmp .Lin_place_merge_sort_else14
.Lin_place_merge_sort_then13:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 16]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_then16
    jmp .Lin_place_merge_sort_else17
.Lin_place_merge_sort_then16:
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
.Lin_place_merge_sort_else17:
    jmp .Lin_place_merge_sort_ret7
.Lin_place_merge_sort_else14:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lin_place_merge_sort_then19
    jmp .Lin_place_merge_sort_else20
.Lin_place_merge_sort_then19:
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
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 48], rax
    mov rax, [rbp - 24]
    mov [rbp - 56], rax
    mov rax, [rbp - 32]
    mov [rbp - 64], rax
.Lin_place_merge_sort_wtop22:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_wbody23
    jmp .Lin_place_merge_sort_wend24
.Lin_place_merge_sort_wbody23:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 72], rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_then25
    jmp .Lin_place_merge_sort_else26
.Lin_place_merge_sort_then25:
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    jmp .Lin_place_merge_sort_endif27
.Lin_place_merge_sort_else26:
    mov rax, [rbp - 72]
    mov [rbp - 64], rax
.Lin_place_merge_sort_endif27:
    jmp .Lin_place_merge_sort_wtop22
.Lin_place_merge_sort_wend24:
    mov rax, [rbp - 56]
    mov [rbp - 80], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 80]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_rotate
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 88], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 88]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_merge
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 88]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_merge
    jmp .Lin_place_merge_sort_endif21
.Lin_place_merge_sort_else20:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 80], rax
    mov rax, [rbp - 80]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 48], rax
    mov rax, [rbp - 16]
    mov [rbp - 56], rax
    mov rax, [rbp - 24]
    mov [rbp - 64], rax
.Lin_place_merge_sort_wtop28:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_wbody29
    jmp .Lin_place_merge_sort_wend30
.Lin_place_merge_sort_wbody29:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 72], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_then31
    jmp .Lin_place_merge_sort_else32
.Lin_place_merge_sort_then31:
    mov rax, [rbp - 72]
    mov [rbp - 64], rax
    jmp .Lin_place_merge_sort_endif33
.Lin_place_merge_sort_else32:
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
.Lin_place_merge_sort_endif33:
    jmp .Lin_place_merge_sort_wtop28
.Lin_place_merge_sort_wend30:
    mov rax, [rbp - 56]
    mov [rbp - 40], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_rotate
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 88], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 88]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_merge
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 88]
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_merge
.Lin_place_merge_sort_endif21:
    xor eax, eax
.Lin_place_merge_sort_ret7:
    leave
    ret

in_place_merge_sort_x_rec:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lin_place_merge_sort_then35
    jmp .Lin_place_merge_sort_else36
.Lin_place_merge_sort_then35:
    jmp .Lin_place_merge_sort_ret34
.Lin_place_merge_sort_else36:
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
    mov [rbp - 32], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_rec
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_rec
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call in_place_merge_sort_x_merge
    xor eax, eax
.Lin_place_merge_sort_ret34:
    leave
    ret

.section .note.GNU-stack,"",@progbits
