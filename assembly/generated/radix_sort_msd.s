# GENERATED from kernels/algos/radix_sort_msd.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl radix_sort_msd_asm
radix_sort_msd_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 80
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 56], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lradix_sort_msd_then2
    jmp .Lradix_sort_msd_else3
.Lradix_sort_msd_then2:
    jmp .Lradix_sort_msd_ret1
.Lradix_sort_msd_else3:
    mov rax, 0
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 24], rax
    mov rax, 0
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
    mov rax, 1
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 72], rax
.Lradix_sort_msd_ftop5:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 72]
    jl .Lradix_sort_msd_fbody6
    jmp .Lradix_sort_msd_fend7
.Lradix_sort_msd_fbody6:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lradix_sort_msd_then8
    jmp .Lradix_sort_msd_else9
.Lradix_sort_msd_then8:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 24], rax
.Lradix_sort_msd_else9:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lradix_sort_msd_then11
    jmp .Lradix_sort_msd_else12
.Lradix_sort_msd_then11:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
.Lradix_sort_msd_else12:
    inc qword ptr [rbp - 40]
    jmp .Lradix_sort_msd_ftop5
.Lradix_sort_msd_fend7:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lradix_sort_msd_sz14
    mov eax, 1
.Lradix_sort_msd_sz14:
    shl rax, 2
    mov [rbp - 64], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 56], rax
    mov rax, 1
    mov [rbp - 48], rax
.Lradix_sort_msd_wtop15:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lradix_sort_msd_wbody16
    jmp .Lradix_sort_msd_wend17
.Lradix_sort_msd_wbody16:
    mov rax, [rbp - 48]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 48], rax
    jmp .Lradix_sort_msd_wtop15
.Lradix_sort_msd_wend17:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    push rax
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call radix_sort_msd_x_rec
    xor eax, eax
.Lradix_sort_msd_ret1:
    push rax
    mov rdi, [rbp - 56]
    test rdi, rdi
    jz .Lradix_sort_msd_nofree18
    mov rsi, [rbp - 64]
    call asm_free
.Lradix_sort_msd_nofree18:
    pop rax
    leave
    ret

radix_sort_msd_x_rec:
    push rbp
    mov rbp, rsp
    sub rsp, 144
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov [rbp - 40], r8
    mov [rbp - 48], r9
    mov qword ptr [rbp - 72], 0
    mov qword ptr [rbp - 80], 0
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lradix_sort_msd_then20
    jmp .Lradix_sort_msd_n23
.Lradix_sort_msd_n23:
    mov rax, [rbp - 48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lradix_sort_msd_then20
    jmp .Lradix_sort_msd_else21
.Lradix_sort_msd_then20:
    jmp .Lradix_sort_msd_ret19
.Lradix_sort_msd_else21:
    mov rax, 11
    cmp rax, 1
    jge .Lradix_sort_msd_sz25
    mov eax, 1
.Lradix_sort_msd_sz25:
    shl rax, 2
    mov [rbp - 88], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 72], rax
    mov rax, [rbp - 32]
    mov [rbp - 56], rax
    mov rax, [rbp - 40]
    mov [rbp - 104], rax
.Lradix_sort_msd_ftop26:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 104]
    jl .Lradix_sort_msd_fbody27
    jmp .Lradix_sort_msd_fend28
.Lradix_sort_msd_fbody27:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 72]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 56]
    jmp .Lradix_sort_msd_ftop26
.Lradix_sort_msd_fend28:
    mov rax, 1
    mov [rbp - 64], rax
    mov rax, 11
    mov [rbp - 112], rax
.Lradix_sort_msd_ftop29:
    mov rax, [rbp - 64]
    cmp rax, [rbp - 112]
    jl .Lradix_sort_msd_fbody30
    jmp .Lradix_sort_msd_fend31
.Lradix_sort_msd_fbody30:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 64]
    jmp .Lradix_sort_msd_ftop29
.Lradix_sort_msd_fend31:
    mov rax, 11
    cmp rax, 1
    jge .Lradix_sort_msd_sz32
    mov eax, 1
.Lradix_sort_msd_sz32:
    shl rax, 2
    mov [rbp - 96], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, 0
    mov [rbp - 64], rax
    mov rax, 11
    mov [rbp - 120], rax
.Lradix_sort_msd_ftop33:
    mov rax, [rbp - 64]
    cmp rax, [rbp - 120]
    jl .Lradix_sort_msd_fbody34
    jmp .Lradix_sort_msd_fend35
.Lradix_sort_msd_fbody34:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 64]
    jmp .Lradix_sort_msd_ftop33
.Lradix_sort_msd_fend35:
    mov rax, [rbp - 32]
    mov [rbp - 56], rax
    mov rax, [rbp - 40]
    mov [rbp - 128], rax
.Lradix_sort_msd_ftop36:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 128]
    jl .Lradix_sort_msd_fbody37
    jmp .Lradix_sort_msd_fend38
.Lradix_sort_msd_fbody37:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    mov [rbp - 64], rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 56]
    jmp .Lradix_sort_msd_ftop36
.Lradix_sort_msd_fend38:
    mov rax, [rbp - 32]
    mov [rbp - 56], rax
    mov rax, [rbp - 40]
    mov [rbp - 136], rax
.Lradix_sort_msd_ftop39:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 136]
    jl .Lradix_sort_msd_fbody40
    jmp .Lradix_sort_msd_fend41
.Lradix_sort_msd_fbody40:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 56]
    jmp .Lradix_sort_msd_ftop39
.Lradix_sort_msd_fend41:
    mov rax, 0
    mov [rbp - 64], rax
    mov rax, 10
    mov [rbp - 144], rax
.Lradix_sort_msd_ftop42:
    mov rax, [rbp - 64]
    cmp rax, [rbp - 144]
    jl .Lradix_sort_msd_fbody43
    jmp .Lradix_sort_msd_fend44
.Lradix_sort_msd_fbody43:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call radix_sort_msd_x_rec
    inc qword ptr [rbp - 64]
    jmp .Lradix_sort_msd_ftop42
.Lradix_sort_msd_fend44:
    xor eax, eax
.Lradix_sort_msd_ret19:
    push rax
    mov rdi, [rbp - 72]
    test rdi, rdi
    jz .Lradix_sort_msd_nofree45
    mov rsi, [rbp - 88]
    call asm_free
.Lradix_sort_msd_nofree45:
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Lradix_sort_msd_nofree46
    mov rsi, [rbp - 96]
    call asm_free
.Lradix_sort_msd_nofree46:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
