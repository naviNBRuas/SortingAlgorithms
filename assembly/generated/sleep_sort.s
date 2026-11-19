# GENERATED from kernels/algos/sleep_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl sleep_sort_asm
sleep_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 144
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 80], 0
    mov qword ptr [rbp - 88], 0
    mov qword ptr [rbp - 96], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lsleep_sort_then2
    jmp .Lsleep_sort_else3
.Lsleep_sort_then2:
    jmp .Lsleep_sort_ret1
.Lsleep_sort_else3:
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
    mov [rbp - 128], rax
.Lsleep_sort_ftop5:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 128]
    jl .Lsleep_sort_fbody6
    jmp .Lsleep_sort_fend7
.Lsleep_sort_fbody6:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lsleep_sort_then8
    jmp .Lsleep_sort_else9
.Lsleep_sort_then8:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 24], rax
.Lsleep_sort_else9:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lsleep_sort_then11
    jmp .Lsleep_sort_else12
.Lsleep_sort_then11:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
.Lsleep_sort_else12:
    inc qword ptr [rbp - 40]
    jmp .Lsleep_sort_ftop5
.Lsleep_sort_fend7:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 4000000
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lsleep_sort_then14
    jmp .Lsleep_sort_else15
.Lsleep_sort_then14:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rsi
    pop rdi
    call sleep_sort_x_fallback
    jmp .Lsleep_sort_ret1
.Lsleep_sort_else15:
    mov rax, [rbp - 48]
    cmp rax, 1
    jge .Lsleep_sort_sz17
    mov eax, 1
.Lsleep_sort_sz17:
    shl rax, 2
    mov [rbp - 104], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lsleep_sort_sz18
    mov eax, 1
.Lsleep_sort_sz18:
    shl rax, 2
    mov [rbp - 112], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 88], rax
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
.Lsleep_sort_wtop19:
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lsleep_sort_wbody20
    jmp .Lsleep_sort_wend21
.Lsleep_sort_wbody20:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 88]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 40], rax
    jmp .Lsleep_sort_wtop19
.Lsleep_sort_wend21:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lsleep_sort_sz22
    mov eax, 1
.Lsleep_sort_sz22:
    shl rax, 2
    mov [rbp - 120], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 96], rax
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 136], rax
.Lsleep_sort_ftop23:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 136]
    jl .Lsleep_sort_fbody24
    jmp .Lsleep_sort_fend25
.Lsleep_sort_fbody24:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 96]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lsleep_sort_ftop23
.Lsleep_sort_fend25:
    mov rax, 0
    mov [rbp - 64], rax
    mov rax, 0
    mov [rbp - 56], rax
    mov rax, [rbp - 48]
    mov [rbp - 144], rax
.Lsleep_sort_ftop26:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 144]
    jl .Lsleep_sort_fbody27
    jmp .Lsleep_sort_fend28
.Lsleep_sort_fbody27:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 72], rax
.Lsleep_sort_wtop29:
    mov rax, [rbp - 72]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Lsleep_sort_wbody30
    jmp .Lsleep_sort_wend31
.Lsleep_sort_wbody30:
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 72], rax
    jmp .Lsleep_sort_wtop29
.Lsleep_sort_wend31:
    inc qword ptr [rbp - 56]
    jmp .Lsleep_sort_ftop26
.Lsleep_sort_fend28:
    xor eax, eax
.Lsleep_sort_ret1:
    push rax
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Lsleep_sort_nofree32
    mov rsi, [rbp - 104]
    call asm_free
.Lsleep_sort_nofree32:
    mov rdi, [rbp - 88]
    test rdi, rdi
    jz .Lsleep_sort_nofree33
    mov rsi, [rbp - 112]
    call asm_free
.Lsleep_sort_nofree33:
    mov rdi, [rbp - 96]
    test rdi, rdi
    jz .Lsleep_sort_nofree34
    mov rsi, [rbp - 120]
    call asm_free
.Lsleep_sort_nofree34:
    pop rax
    leave
    ret

sleep_sort_x_fallback:
    push rbp
    mov rbp, rsp
    sub rsp, 64
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
.Lsleep_sort_wtop36:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lsleep_sort_wbody37
    jmp .Lsleep_sort_wend38
.Lsleep_sort_wbody37:
    mov rax, [rbp - 24]
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    mov [rbp - 56], rax
.Lsleep_sort_ftop39:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 56]
    jl .Lsleep_sort_fbody40
    jmp .Lsleep_sort_fend41
.Lsleep_sort_fbody40:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    mov rax, [rbp - 32]
    mov [rbp - 48], rax
.Lsleep_sort_wtop42:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lsleep_sort_n45
    jmp .Lsleep_sort_wend44
.Lsleep_sort_n45:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lsleep_sort_wbody43
    jmp .Lsleep_sort_wend44
.Lsleep_sort_wbody43:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    jmp .Lsleep_sort_wtop42
.Lsleep_sort_wend44:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 32]
    jmp .Lsleep_sort_ftop39
.Lsleep_sort_fend41:
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 24], rax
    jmp .Lsleep_sort_wtop36
.Lsleep_sort_wend38:
    xor eax, eax
.Lsleep_sort_ret35:
    leave
    ret

.section .note.GNU-stack,"",@progbits
