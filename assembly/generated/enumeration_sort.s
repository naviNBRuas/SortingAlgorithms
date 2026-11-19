# GENERATED from kernels/algos/enumeration_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl enumeration_sort_asm
enumeration_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 80
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 48], 0
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lenumeration_sort_sz2
    mov eax, 1
.Lenumeration_sort_sz2:
    shl rax, 2
    mov [rbp - 56], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 48], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 64], rax
.Lenumeration_sort_ftop3:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 64]
    jl .Lenumeration_sort_fbody4
    jmp .Lenumeration_sort_fend5
.Lenumeration_sort_fbody4:
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 72], rax
.Lenumeration_sort_ftop6:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 72]
    jl .Lenumeration_sort_fbody7
    jmp .Lenumeration_sort_fend8
.Lenumeration_sort_fbody7:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lenumeration_sort_then9
    jmp .Lenumeration_sort_n12
.Lenumeration_sort_n12:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lenumeration_sort_n14
    jmp .Lenumeration_sort_else10
.Lenumeration_sort_n14:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lenumeration_sort_then9
    jmp .Lenumeration_sort_else10
.Lenumeration_sort_then9:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
.Lenumeration_sort_else10:
    inc qword ptr [rbp - 40]
    jmp .Lenumeration_sort_ftop6
.Lenumeration_sort_fend8:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 48]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lenumeration_sort_ftop3
.Lenumeration_sort_fend5:
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 80], rax
.Lenumeration_sort_ftop16:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 80]
    jl .Lenumeration_sort_fbody17
    jmp .Lenumeration_sort_fend18
.Lenumeration_sort_fbody17:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 48]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lenumeration_sort_ftop16
.Lenumeration_sort_fend18:
    xor eax, eax
.Lenumeration_sort_ret1:
    push rax
    mov rdi, [rbp - 48]
    test rdi, rdi
    jz .Lenumeration_sort_nofree19
    mov rsi, [rbp - 56]
    call asm_free
.Lenumeration_sort_nofree19:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
