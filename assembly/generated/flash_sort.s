# GENERATED from kernels/algos/flash_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl flash_sort_asm
flash_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 192
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 112], 0
    mov qword ptr [rbp - 120], 0
    mov qword ptr [rbp - 128], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lflash_sort_then2
    jmp .Lflash_sort_else3
.Lflash_sort_then2:
    jmp .Lflash_sort_ret1
.Lflash_sort_else3:
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
    mov [rbp - 160], rax
.Lflash_sort_ftop5:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 160]
    jl .Lflash_sort_fbody6
    jmp .Lflash_sort_fend7
.Lflash_sort_fbody6:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lflash_sort_then8
    jmp .Lflash_sort_else9
.Lflash_sort_then8:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 24], rax
.Lflash_sort_else9:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lflash_sort_then11
    jmp .Lflash_sort_else12
.Lflash_sort_then11:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
.Lflash_sort_else12:
    inc qword ptr [rbp - 40]
    jmp .Lflash_sort_ftop5
.Lflash_sort_fend7:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lflash_sort_then14
    jmp .Lflash_sort_else15
.Lflash_sort_then14:
    jmp .Lflash_sort_ret1
.Lflash_sort_else15:
    mov rax, 2
    push rax
    mov rax, 43
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 100
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    pop rcx
    cmp rcx, rax
    cmovg rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 48]
    cmp rax, 1
    jge .Lflash_sort_sz17
    mov eax, 1
.Lflash_sort_sz17:
    shl rax, 2
    mov [rbp - 136], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 112], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    cmp rax, 1
    jge .Lflash_sort_sz18
    mov eax, 1
.Lflash_sort_sz18:
    shl rax, 2
    mov [rbp - 144], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 120], rax
    mov rax, [rbp - 48]
    cmp rax, 1
    jge .Lflash_sort_sz19
    mov eax, 1
.Lflash_sort_sz19:
    shl rax, 2
    mov [rbp - 152], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 128], rax
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 168], rax
.Lflash_sort_ftop20:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 168]
    jl .Lflash_sort_fbody21
    jmp .Lflash_sort_fend22
.Lflash_sort_fbody21:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, [rbp - 112]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, [rbp - 112]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lflash_sort_ftop20
.Lflash_sort_fend22:
    mov rax, 0
    mov [rbp - 64], rax
    mov rax, 0
    mov [rbp - 72], rax
    mov rax, [rbp - 48]
    mov [rbp - 176], rax
.Lflash_sort_ftop23:
    mov rax, [rbp - 72]
    cmp rax, [rbp - 176]
    jl .Lflash_sort_fbody24
    jmp .Lflash_sort_fend25
.Lflash_sort_fbody24:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 128]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 112]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
    inc qword ptr [rbp - 72]
    jmp .Lflash_sort_ftop23
.Lflash_sort_fend25:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 0
    mov [rbp - 80], rax
    mov rax, [rbp - 48]
    mov [rbp - 184], rax
.Lflash_sort_ftop26:
    mov rax, [rbp - 80]
    cmp rax, [rbp - 184]
    jl .Lflash_sort_fbody27
    jmp .Lflash_sort_fend28
.Lflash_sort_fbody27:
.Lflash_sort_wtop29:
    mov rax, [rbp - 80]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lflash_sort_wbody30
    jmp .Lflash_sort_wend31
.Lflash_sort_wbody30:
    mov rax, [rbp - 80]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 88], rax
    mov rax, [rbp - 88]
    push rax
    mov rax, [rbp - 80]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lflash_sort_then32
    jmp .Lflash_sort_else33
.Lflash_sort_then32:
    mov rax, [rbp - 80]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 80]
    mov rcx, [rbp - 128]
    pop rdx
    mov [rcx + rax*4], edx
    jmp .Lflash_sort_endif34
.Lflash_sort_else33:
    mov rax, [rbp - 80]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 88]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 88]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 88]
    mov rcx, [rbp - 128]
    pop rdx
    mov [rcx + rax*4], edx
.Lflash_sort_endif34:
    jmp .Lflash_sort_wtop29
.Lflash_sort_wend31:
    inc qword ptr [rbp - 80]
    jmp .Lflash_sort_ftop26
.Lflash_sort_fend28:
    mov rax, 1
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 192], rax
.Lflash_sort_ftop35:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 192]
    jl .Lflash_sort_fbody36
    jmp .Lflash_sort_fend37
.Lflash_sort_fbody36:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 96], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 104], rax
.Lflash_sort_wtop38:
    mov rax, [rbp - 104]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lflash_sort_n41
    jmp .Lflash_sort_wend40
.Lflash_sort_n41:
    mov rax, [rbp - 104]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 96]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lflash_sort_wbody39
    jmp .Lflash_sort_wend40
.Lflash_sort_wbody39:
    mov rax, [rbp - 104]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 104]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 104]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 104], rax
    jmp .Lflash_sort_wtop38
.Lflash_sort_wend40:
    mov rax, [rbp - 96]
    push rax
    mov rax, [rbp - 104]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lflash_sort_ftop35
.Lflash_sort_fend37:
    xor eax, eax
.Lflash_sort_ret1:
    push rax
    mov rdi, [rbp - 112]
    test rdi, rdi
    jz .Lflash_sort_nofree43
    mov rsi, [rbp - 136]
    call asm_free
.Lflash_sort_nofree43:
    mov rdi, [rbp - 120]
    test rdi, rdi
    jz .Lflash_sort_nofree44
    mov rsi, [rbp - 144]
    call asm_free
.Lflash_sort_nofree44:
    mov rdi, [rbp - 128]
    test rdi, rdi
    jz .Lflash_sort_nofree45
    mov rsi, [rbp - 152]
    call asm_free
.Lflash_sort_nofree45:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
