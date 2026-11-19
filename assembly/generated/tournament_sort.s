# GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl tournament_sort_asm
tournament_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 144
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 64], 0
    mov qword ptr [rbp - 72], 0
    mov qword ptr [rbp - 80], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Ltournament_sort_then2
    jmp .Ltournament_sort_else3
.Ltournament_sort_then2:
    jmp .Ltournament_sort_ret1
.Ltournament_sort_else3:
    mov rax, 1
    mov [rbp - 24], rax
.Ltournament_sort_wtop5:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Ltournament_sort_wbody6
    jmp .Ltournament_sort_wend7
.Ltournament_sort_wbody6:
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 24], rax
    jmp .Ltournament_sort_wtop5
.Ltournament_sort_wend7:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Ltournament_sort_sz8
    mov eax, 1
.Ltournament_sort_sz8:
    shl rax, 2
    mov [rbp - 88], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 64], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Ltournament_sort_sz9
    mov eax, 1
.Ltournament_sort_sz9:
    shl rax, 2
    mov [rbp - 96], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 72], rax
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    cmp rax, 1
    jge .Ltournament_sort_sz10
    mov eax, 1
.Ltournament_sort_sz10:
    shl rax, 2
    mov [rbp - 104], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 112], rax
.Ltournament_sort_ftop11:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 112]
    jl .Ltournament_sort_fbody12
    jmp .Ltournament_sort_fend13
.Ltournament_sort_fbody12:
    mov rax, 1
    neg rax
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 32]
    jmp .Ltournament_sort_ftop11
.Ltournament_sort_fend13:
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    mov [rbp - 120], rax
.Ltournament_sort_ftop14:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 120]
    jl .Ltournament_sort_fbody15
    jmp .Ltournament_sort_fend16
.Ltournament_sort_fbody15:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 32]
    jmp .Ltournament_sort_ftop14
.Ltournament_sort_fend16:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
.Ltournament_sort_wtop17:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Ltournament_sort_wbody18
    jmp .Ltournament_sort_wend19
.Ltournament_sort_wbody18:
    mov rax, [rbp - 64]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
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
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call tournament_sort_x_better
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
    jmp .Ltournament_sort_wtop17
.Ltournament_sort_wend19:
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 16]
    mov [rbp - 128], rax
.Ltournament_sort_ftop20:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 128]
    jl .Ltournament_sort_fbody21
    jmp .Ltournament_sort_fend22
.Ltournament_sort_fbody21:
    mov rax, 1
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 48], rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 64]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 72]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    mov rax, 1
    neg rax
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 56], rax
.Ltournament_sort_wtop23:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Ltournament_sort_wbody24
    jmp .Ltournament_sort_wend25
.Ltournament_sort_wbody24:
    mov rax, [rbp - 64]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call tournament_sort_x_better
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 56], rax
    jmp .Ltournament_sort_wtop23
.Ltournament_sort_wend25:
    inc qword ptr [rbp - 40]
    jmp .Ltournament_sort_ftop20
.Ltournament_sort_fend22:
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    mov [rbp - 136], rax
.Ltournament_sort_ftop26:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 136]
    jl .Ltournament_sort_fbody27
    jmp .Ltournament_sort_fend28
.Ltournament_sort_fbody27:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 32]
    jmp .Ltournament_sort_ftop26
.Ltournament_sort_fend28:
    xor eax, eax
.Ltournament_sort_ret1:
    push rax
    mov rdi, [rbp - 64]
    test rdi, rdi
    jz .Ltournament_sort_nofree29
    mov rsi, [rbp - 88]
    call asm_free
.Ltournament_sort_nofree29:
    mov rdi, [rbp - 72]
    test rdi, rdi
    jz .Ltournament_sort_nofree30
    mov rsi, [rbp - 96]
    call asm_free
.Ltournament_sort_nofree30:
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Ltournament_sort_nofree31
    mov rsi, [rbp - 104]
    call asm_free
.Ltournament_sort_nofree31:
    pop rax
    leave
    ret

tournament_sort_x_better:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov rax, [rbp - 16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Ltournament_sort_then33
    jmp .Ltournament_sort_else34
.Ltournament_sort_then33:
    mov rax, [rbp - 24]
    jmp .Ltournament_sort_ret32
.Ltournament_sort_else34:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Ltournament_sort_then36
    jmp .Ltournament_sort_else37
.Ltournament_sort_then36:
    mov rax, [rbp - 16]
    jmp .Ltournament_sort_ret32
.Ltournament_sort_else37:
    mov rax, [rbp - 16]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Ltournament_sort_then39
    jmp .Ltournament_sort_else40
.Ltournament_sort_then39:
    mov rax, [rbp - 16]
    jmp .Ltournament_sort_ret32
.Ltournament_sort_else40:
    mov rax, [rbp - 24]
    jmp .Ltournament_sort_ret32
    xor eax, eax
.Ltournament_sort_ret32:
    leave
    ret

.section .note.GNU-stack,"",@progbits
