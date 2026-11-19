# GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl shell_sort_ciura_asm
shell_sort_ciura_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 80
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 64], 0
    mov rax, 10
    cmp rax, 1
    jge .Lshell_sort_ciura_sz2
    mov eax, 1
.Lshell_sort_ciura_sz2:
    shl rax, 2
    mov [rbp - 72], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 64], rax
    mov rax, 1
    push rax
    mov rax, 0
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 4
    push rax
    mov rax, 1
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 10
    push rax
    mov rax, 2
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 23
    push rax
    mov rax, 3
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 57
    push rax
    mov rax, 4
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 132
    push rax
    mov rax, 5
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 301
    push rax
    mov rax, 6
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 701
    push rax
    mov rax, 7
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 1750
    push rax
    mov rax, 8
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 4377
    push rax
    mov rax, 9
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 9
    mov [rbp - 24], rax
.Lshell_sort_ciura_wtop3:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lshell_sort_ciura_wbody4
    jmp .Lshell_sort_ciura_wend5
.Lshell_sort_ciura_wbody4:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 64]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lshell_sort_ciura_then6
    jmp .Lshell_sort_ciura_else7
.Lshell_sort_ciura_then6:
    mov rax, [rbp - 32]
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 80], rax
.Lshell_sort_ciura_ftop9:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 80]
    jl .Lshell_sort_ciura_fbody10
    jmp .Lshell_sort_ciura_fend11
.Lshell_sort_ciura_fbody10:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 48], rax
    mov rax, [rbp - 40]
    mov [rbp - 56], rax
.Lshell_sort_ciura_wtop12:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lshell_sort_ciura_n15
    jmp .Lshell_sort_ciura_wend14
.Lshell_sort_ciura_n15:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lshell_sort_ciura_wbody13
    jmp .Lshell_sort_ciura_wend14
.Lshell_sort_ciura_wbody13:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    jmp .Lshell_sort_ciura_wtop12
.Lshell_sort_ciura_wend14:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lshell_sort_ciura_ftop9
.Lshell_sort_ciura_fend11:
.Lshell_sort_ciura_else7:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lshell_sort_ciura_wtop3
.Lshell_sort_ciura_wend5:
    xor eax, eax
.Lshell_sort_ciura_ret1:
    push rax
    mov rdi, [rbp - 64]
    test rdi, rdi
    jz .Lshell_sort_ciura_nofree17
    mov rsi, [rbp - 72]
    call asm_free
.Lshell_sort_ciura_nofree17:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
