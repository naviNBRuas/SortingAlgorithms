# GENERATED from kernels/algos/permutation_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl permutation_sort_asm
permutation_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 128
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 72], 0
    mov qword ptr [rbp - 80], 0
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lpermutation_sort_sz2
    mov eax, 1
.Lpermutation_sort_sz2:
    shl rax, 2
    mov [rbp - 88], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 72], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lpermutation_sort_sz3
    mov eax, 1
.Lpermutation_sort_sz3:
    shl rax, 2
    mov [rbp - 96], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 104], rax
.Lpermutation_sort_ftop4:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 104]
    jl .Lpermutation_sort_fbody5
    jmp .Lpermutation_sort_fend6
.Lpermutation_sort_fbody5:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 72]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lpermutation_sort_ftop4
.Lpermutation_sort_fend6:
    mov rax, 0
    mov [rbp - 32], rax
.Lpermutation_sort_wtop7:
    mov rax, [rbp - 32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lpermutation_sort_wbody8
    jmp .Lpermutation_sort_wend9
.Lpermutation_sort_wbody8:
    mov rax, 1
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 112], rax
.Lpermutation_sort_ftop10:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 112]
    jl .Lpermutation_sort_fbody11
    jmp .Lpermutation_sort_fend12
.Lpermutation_sort_fbody11:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpermutation_sort_then13
    jmp .Lpermutation_sort_else14
.Lpermutation_sort_then13:
    mov rax, 0
    mov [rbp - 40], rax
.Lpermutation_sort_else14:
    inc qword ptr [rbp - 24]
    jmp .Lpermutation_sort_ftop10
.Lpermutation_sort_fend12:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lpermutation_sort_then16
    jmp .Lpermutation_sort_else17
.Lpermutation_sort_then16:
    mov rax, 1
    mov [rbp - 32], rax
    jmp .Lpermutation_sort_endif18
.Lpermutation_sort_else17:
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
.Lpermutation_sort_wtop19:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lpermutation_sort_n22
    jmp .Lpermutation_sort_wend21
.Lpermutation_sort_n22:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lpermutation_sort_wbody20
    jmp .Lpermutation_sort_wend21
.Lpermutation_sort_wbody20:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 24], rax
    jmp .Lpermutation_sort_wtop19
.Lpermutation_sort_wend21:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpermutation_sort_then24
    jmp .Lpermutation_sort_else25
.Lpermutation_sort_then24:
    mov rax, 1
    mov [rbp - 32], rax
    jmp .Lpermutation_sort_endif26
.Lpermutation_sort_else25:
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
.Lpermutation_sort_wtop27:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpermutation_sort_wbody28
    jmp .Lpermutation_sort_wend29
.Lpermutation_sort_wbody28:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    jmp .Lpermutation_sort_wtop27
.Lpermutation_sort_wend29:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 48]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 80]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 64], rax
.Lpermutation_sort_wtop30:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lpermutation_sort_wbody31
    jmp .Lpermutation_sort_wend32
.Lpermutation_sort_wbody31:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 80]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 64], rax
    jmp .Lpermutation_sort_wtop30
.Lpermutation_sort_wend32:
.Lpermutation_sort_endif26:
.Lpermutation_sort_endif18:
    jmp .Lpermutation_sort_wtop7
.Lpermutation_sort_wend9:
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 120], rax
.Lpermutation_sort_ftop33:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 120]
    jl .Lpermutation_sort_fbody34
    jmp .Lpermutation_sort_fend35
.Lpermutation_sort_fbody34:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lpermutation_sort_ftop33
.Lpermutation_sort_fend35:
    xor eax, eax
.Lpermutation_sort_ret1:
    push rax
    mov rdi, [rbp - 72]
    test rdi, rdi
    jz .Lpermutation_sort_nofree36
    mov rsi, [rbp - 88]
    call asm_free
.Lpermutation_sort_nofree36:
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Lpermutation_sort_nofree37
    mov rsi, [rbp - 96]
    call asm_free
.Lpermutation_sort_nofree37:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
