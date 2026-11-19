# GENERATED from kernels/algos/american_flag_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl american_flag_sort_asm
american_flag_sort_asm:
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
    cmp rax, rcx
    jl .Lamerican_flag_sort_then2
    jmp .Lamerican_flag_sort_else3
.Lamerican_flag_sort_then2:
    jmp .Lamerican_flag_sort_ret1
.Lamerican_flag_sort_else3:
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
    mov [rbp - 56], rax
.Lamerican_flag_sort_ftop5:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 56]
    jl .Lamerican_flag_sort_fbody6
    jmp .Lamerican_flag_sort_fend7
.Lamerican_flag_sort_fbody6:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lamerican_flag_sort_then8
    jmp .Lamerican_flag_sort_else9
.Lamerican_flag_sort_then8:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 24], rax
.Lamerican_flag_sort_else9:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lamerican_flag_sort_then11
    jmp .Lamerican_flag_sort_else12
.Lamerican_flag_sort_then11:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 32], rax
.Lamerican_flag_sort_else12:
    inc qword ptr [rbp - 40]
    jmp .Lamerican_flag_sort_ftop5
.Lamerican_flag_sort_fend7:
    mov rax, 1
    mov [rbp - 48], rax
.Lamerican_flag_sort_wtop14:
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
    jge .Lamerican_flag_sort_wbody15
    jmp .Lamerican_flag_sort_wend16
.Lamerican_flag_sort_wbody15:
    mov rax, [rbp - 48]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 48], rax
    jmp .Lamerican_flag_sort_wtop14
.Lamerican_flag_sort_wend16:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 48]
    push rax
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call american_flag_sort_x_rec
    xor eax, eax
.Lamerican_flag_sort_ret1:
    leave
    ret

american_flag_sort_x_rec:
    push rbp
    mov rbp, rsp
    sub rsp, 160
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov [rbp - 40], r8
    mov qword ptr [rbp - 80], 0
    mov qword ptr [rbp - 88], 0
    mov qword ptr [rbp - 96], 0
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lamerican_flag_sort_then18
    jmp .Lamerican_flag_sort_n21
.Lamerican_flag_sort_n21:
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lamerican_flag_sort_then18
    jmp .Lamerican_flag_sort_else19
.Lamerican_flag_sort_then18:
    jmp .Lamerican_flag_sort_ret17
.Lamerican_flag_sort_else19:
    mov rax, 10
    cmp rax, 1
    jge .Lamerican_flag_sort_sz23
    mov eax, 1
.Lamerican_flag_sort_sz23:
    shl rax, 2
    mov [rbp - 104], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, 11
    cmp rax, 1
    jge .Lamerican_flag_sort_sz24
    mov eax, 1
.Lamerican_flag_sort_sz24:
    shl rax, 2
    mov [rbp - 112], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 88], rax
    mov rax, 10
    cmp rax, 1
    jge .Lamerican_flag_sort_sz25
    mov eax, 1
.Lamerican_flag_sort_sz25:
    shl rax, 2
    mov [rbp - 120], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 96], rax
    mov rax, [rbp - 24]
    mov [rbp - 48], rax
    mov rax, [rbp - 32]
    mov [rbp - 128], rax
.Lamerican_flag_sort_ftop26:
    mov rax, [rbp - 48]
    cmp rax, [rbp - 128]
    jl .Lamerican_flag_sort_fbody27
    jmp .Lamerican_flag_sort_fend28
.Lamerican_flag_sort_fbody27:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 40]
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
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 40]
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
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 48]
    jmp .Lamerican_flag_sort_ftop26
.Lamerican_flag_sort_fend28:
    mov rax, [rbp - 24]
    mov [rbp - 56], rax
    mov rax, 0
    mov [rbp - 64], rax
    mov rax, 10
    mov [rbp - 136], rax
.Lamerican_flag_sort_ftop29:
    mov rax, [rbp - 64]
    cmp rax, [rbp - 136]
    jl .Lamerican_flag_sort_fbody30
    jmp .Lamerican_flag_sort_fend31
.Lamerican_flag_sort_fbody30:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 88]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 96]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    inc qword ptr [rbp - 64]
    jmp .Lamerican_flag_sort_ftop29
.Lamerican_flag_sort_fend31:
    mov rax, [rbp - 56]
    push rax
    mov rax, 10
    mov rcx, [rbp - 88]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 0
    mov [rbp - 72], rax
    mov rax, 10
    mov [rbp - 144], rax
.Lamerican_flag_sort_ftop32:
    mov rax, [rbp - 72]
    cmp rax, [rbp - 144]
    jl .Lamerican_flag_sort_fbody33
    jmp .Lamerican_flag_sort_fend34
.Lamerican_flag_sort_fbody33:
.Lamerican_flag_sort_wtop35:
    mov rax, [rbp - 72]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lamerican_flag_sort_wbody36
    jmp .Lamerican_flag_sort_wend37
.Lamerican_flag_sort_wbody36:
    mov rax, [rbp - 72]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, [rbp - 40]
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
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 72]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lamerican_flag_sort_then38
    jmp .Lamerican_flag_sort_else39
.Lamerican_flag_sort_then38:
    mov rax, [rbp - 72]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 96]
    pop rdx
    mov [rcx + rax*4], edx
    jmp .Lamerican_flag_sort_endif40
.Lamerican_flag_sort_else39:
    mov rax, [rbp - 72]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 8]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 96]
    pop rdx
    mov [rcx + rax*4], edx
.Lamerican_flag_sort_endif40:
    jmp .Lamerican_flag_sort_wtop35
.Lamerican_flag_sort_wend37:
    inc qword ptr [rbp - 72]
    jmp .Lamerican_flag_sort_ftop32
.Lamerican_flag_sort_fend34:
    mov rax, 0
    mov [rbp - 72], rax
    mov rax, 10
    mov [rbp - 152], rax
.Lamerican_flag_sort_ftop41:
    mov rax, [rbp - 72]
    cmp rax, [rbp - 152]
    jl .Lamerican_flag_sort_fbody42
    jmp .Lamerican_flag_sort_fend43
.Lamerican_flag_sort_fbody42:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 72]
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 10
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    push rax
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call american_flag_sort_x_rec
    inc qword ptr [rbp - 72]
    jmp .Lamerican_flag_sort_ftop41
.Lamerican_flag_sort_fend43:
    xor eax, eax
.Lamerican_flag_sort_ret17:
    push rax
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Lamerican_flag_sort_nofree44
    mov rsi, [rbp - 104]
    call asm_free
.Lamerican_flag_sort_nofree44:
    mov rdi, [rbp - 88]
    test rdi, rdi
    jz .Lamerican_flag_sort_nofree45
    mov rsi, [rbp - 112]
    call asm_free
.Lamerican_flag_sort_nofree45:
    mov rdi, [rbp - 96]
    test rdi, rdi
    jz .Lamerican_flag_sort_nofree46
    mov rsi, [rbp - 120]
    call asm_free
.Lamerican_flag_sort_nofree46:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
