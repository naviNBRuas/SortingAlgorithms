# GENERATED from kernels/algos/weak_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl weak_heap_sort_asm
weak_heap_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 56], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lweak_heap_sort_then2
    jmp .Lweak_heap_sort_else3
.Lweak_heap_sort_then2:
    jmp .Lweak_heap_sort_ret1
.Lweak_heap_sort_else3:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lweak_heap_sort_sz5
    mov eax, 1
.Lweak_heap_sort_sz5:
    shl rax, 2
    mov [rbp - 64], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 56], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
.Lweak_heap_sort_wtop6:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lweak_heap_sort_wbody7
    jmp .Lweak_heap_sort_wend8
.Lweak_heap_sort_wbody7:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rsi
    pop rdi
    call weak_heap_sort_x_gparent
    mov [rbp - 32], rax
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call weak_heap_sort_x_join
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lweak_heap_sort_wtop6
.Lweak_heap_sort_wend8:
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
.Lweak_heap_sort_wtop9:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lweak_heap_sort_wbody10
    jmp .Lweak_heap_sort_wend11
.Lweak_heap_sort_wbody10:
    mov rax, 0
    push rax
    mov rax, [rbp - 40]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, 1
    mov [rbp - 48], rax
.Lweak_heap_sort_wtop12:
    mov rax, 2
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 56]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lweak_heap_sort_wbody13
    jmp .Lweak_heap_sort_wend14
.Lweak_heap_sort_wbody13:
    mov rax, 2
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 56]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    jmp .Lweak_heap_sort_wtop12
.Lweak_heap_sort_wend14:
.Lweak_heap_sort_wtop15:
    mov rax, [rbp - 48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lweak_heap_sort_wbody16
    jmp .Lweak_heap_sort_wend17
.Lweak_heap_sort_wbody16:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 56]
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 48]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call weak_heap_sort_x_join
    mov rax, [rbp - 48]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 48], rax
    jmp .Lweak_heap_sort_wtop15
.Lweak_heap_sort_wend17:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
    jmp .Lweak_heap_sort_wtop9
.Lweak_heap_sort_wend11:
    mov rax, 0
    push rax
    mov rax, 1
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    xor eax, eax
.Lweak_heap_sort_ret1:
    push rax
    mov rdi, [rbp - 56]
    test rdi, rdi
    jz .Lweak_heap_sort_nofree18
    mov rsi, [rbp - 64]
    call asm_free
.Lweak_heap_sort_nofree18:
    pop rax
    leave
    ret

weak_heap_sort_x_gparent:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
.Lweak_heap_sort_wtop20:
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lweak_heap_sort_wbody21
    jmp .Lweak_heap_sort_wend22
.Lweak_heap_sort_wbody21:
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 16], rax
    jmp .Lweak_heap_sort_wtop20
.Lweak_heap_sort_wend22:
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    jmp .Lweak_heap_sort_ret19
    xor eax, eax
.Lweak_heap_sort_ret19:
    leave
    ret

weak_heap_sort_x_join:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lweak_heap_sort_then24
    jmp .Lweak_heap_sort_else25
.Lweak_heap_sort_then24:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, 1
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
.Lweak_heap_sort_else25:
    xor eax, eax
.Lweak_heap_sort_ret23:
    leave
    ret

.section .note.GNU-stack,"",@progbits
