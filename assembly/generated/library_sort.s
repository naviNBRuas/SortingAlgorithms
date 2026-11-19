# GENERATED from kernels/algos/library_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl library_sort_asm
library_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 208
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
    jl .Llibrary_sort_then2
    jmp .Llibrary_sort_else3
.Llibrary_sort_then2:
    jmp .Llibrary_sort_ret1
.Llibrary_sort_else3:
    mov rax, 2
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Llibrary_sort_sz5
    mov eax, 1
.Llibrary_sort_sz5:
    shl rax, 2
    mov [rbp - 136], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 112], rax
    mov rax, [rbp - 24]
    cmp rax, 1
    jge .Llibrary_sort_sz6
    mov eax, 1
.Llibrary_sort_sz6:
    shl rax, 2
    mov [rbp - 144], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 120], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Llibrary_sort_sz7
    mov eax, 1
.Llibrary_sort_sz7:
    shl rax, 2
    mov [rbp - 152], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 128], rax
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    mov [rbp - 160], rax
.Llibrary_sort_ftop8:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 160]
    jl .Llibrary_sort_fbody9
    jmp .Llibrary_sort_fend10
.Llibrary_sort_fbody9:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 112]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 32]
    jmp .Llibrary_sort_ftop8
.Llibrary_sort_fend10:
    mov rax, 1
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 48], rax
    mov rax, [rbp - 16]
    mov [rbp - 168], rax
.Llibrary_sort_ftop11:
    mov rax, [rbp - 48]
    cmp rax, [rbp - 168]
    jl .Llibrary_sort_fbody12
    jmp .Llibrary_sort_fend13
.Llibrary_sort_fbody12:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Llibrary_sort_then14
    jmp .Llibrary_sort_else15
.Llibrary_sort_then14:
    mov rax, [rbp - 40]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 56], rax
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, [rbp - 24]
    mov [rbp - 176], rax
.Llibrary_sort_ftop17:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 176]
    jl .Llibrary_sort_fbody18
    jmp .Llibrary_sort_fend19
.Llibrary_sort_fbody18:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Llibrary_sort_then20
    jmp .Llibrary_sort_else21
.Llibrary_sort_then20:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 128]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    mov rax, 0
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
.Llibrary_sort_else21:
    inc qword ptr [rbp - 32]
    jmp .Llibrary_sort_ftop17
.Llibrary_sort_fend19:
    mov rax, 0
    mov [rbp - 64], rax
    mov rax, [rbp - 56]
    mov [rbp - 184], rax
.Llibrary_sort_ftop23:
    mov rax, [rbp - 64]
    cmp rax, [rbp - 184]
    jl .Llibrary_sort_fbody24
    jmp .Llibrary_sort_fend25
.Llibrary_sort_fbody24:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, [rbp - 56]
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 64]
    jmp .Llibrary_sort_ftop23
.Llibrary_sort_fend25:
.Llibrary_sort_else15:
    mov rax, [rbp - 112]
    push rax
    mov rax, [rbp - 120]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 112]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call library_sort_x_locate
    mov [rbp - 72], rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 80], rax
.Llibrary_sort_wtop26:
    mov rax, [rbp - 80]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Llibrary_sort_n29
    jmp .Llibrary_sort_wend28
.Llibrary_sort_n29:
    mov rax, [rbp - 80]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Llibrary_sort_wbody27
    jmp .Llibrary_sort_wend28
.Llibrary_sort_wbody27:
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 80], rax
    jmp .Llibrary_sort_wtop26
.Llibrary_sort_wend28:
    mov rax, [rbp - 72]
    mov [rbp - 88], rax
.Llibrary_sort_wtop31:
    mov rax, [rbp - 88]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Llibrary_sort_n34
    jmp .Llibrary_sort_wend33
.Llibrary_sort_n34:
    mov rax, [rbp - 88]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Llibrary_sort_wbody32
    jmp .Llibrary_sort_wend33
.Llibrary_sort_wbody32:
    mov rax, [rbp - 88]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 88], rax
    jmp .Llibrary_sort_wtop31
.Llibrary_sort_wend33:
    mov rax, [rbp - 88]
    push rax
    mov rax, [rbp - 80]
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Llibrary_sort_then36
    jmp .Llibrary_sort_else37
.Llibrary_sort_then36:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, [rbp - 88]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    jmp .Llibrary_sort_endif38
.Llibrary_sort_else37:
    mov rax, [rbp - 88]
    mov [rbp - 96], rax
.Llibrary_sort_wtop39:
    mov rax, [rbp - 96]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Llibrary_sort_n42
    jmp .Llibrary_sort_wend41
.Llibrary_sort_n42:
    mov rax, [rbp - 96]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Llibrary_sort_wbody40
    jmp .Llibrary_sort_wend41
.Llibrary_sort_wbody40:
    mov rax, [rbp - 96]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 96], rax
    jmp .Llibrary_sort_wtop39
.Llibrary_sort_wend41:
    mov rax, [rbp - 96]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Llibrary_sort_then44
    jmp .Llibrary_sort_else45
.Llibrary_sort_then44:
    mov rax, [rbp - 96]
    mov [rbp - 64], rax
.Llibrary_sort_wtop47:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 88]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Llibrary_sort_wbody48
    jmp .Llibrary_sort_wend49
.Llibrary_sort_wbody48:
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 64], rax
    jmp .Llibrary_sort_wtop47
.Llibrary_sort_wend49:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 88]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    jmp .Llibrary_sort_endif46
.Llibrary_sort_else45:
    mov rax, [rbp - 80]
    mov [rbp - 96], rax
.Llibrary_sort_wtop50:
    mov rax, [rbp - 96]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Llibrary_sort_wbody51
    jmp .Llibrary_sort_wend52
.Llibrary_sort_wbody51:
    mov rax, [rbp - 96]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 96], rax
    jmp .Llibrary_sort_wtop50
.Llibrary_sort_wend52:
    mov rax, [rbp - 96]
    mov [rbp - 64], rax
.Llibrary_sort_wtop53:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 80]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Llibrary_sort_wbody54
    jmp .Llibrary_sort_wend55
.Llibrary_sort_wbody54:
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
    jmp .Llibrary_sort_wtop53
.Llibrary_sort_wend55:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 80]
    mov rcx, [rbp - 120]
    pop rdx
    mov [rcx + rax*4], edx
.Llibrary_sort_endif46:
.Llibrary_sort_endif38:
    inc qword ptr [rbp - 48]
    jmp .Llibrary_sort_ftop11
.Llibrary_sort_fend13:
    mov rax, 0
    mov [rbp - 104], rax
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, [rbp - 24]
    mov [rbp - 192], rax
.Llibrary_sort_ftop56:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 192]
    jl .Llibrary_sort_fbody57
    jmp .Llibrary_sort_fend58
.Llibrary_sort_fbody57:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Llibrary_sort_then59
    jmp .Llibrary_sort_else60
.Llibrary_sort_then59:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 120]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 112]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 104]
    mov rcx, [rbp - 128]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 104]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 104], rax
.Llibrary_sort_else60:
    inc qword ptr [rbp - 32]
    jmp .Llibrary_sort_ftop56
.Llibrary_sort_fend58:
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    mov [rbp - 200], rax
.Llibrary_sort_ftop62:
    mov rax, [rbp - 32]
    cmp rax, [rbp - 200]
    jl .Llibrary_sort_fbody63
    jmp .Llibrary_sort_fend64
.Llibrary_sort_fbody63:
    mov rax, [rbp - 32]
    mov rcx, [rbp - 128]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 32]
    jmp .Llibrary_sort_ftop62
.Llibrary_sort_fend64:
    xor eax, eax
.Llibrary_sort_ret1:
    push rax
    mov rdi, [rbp - 112]
    test rdi, rdi
    jz .Llibrary_sort_nofree65
    mov rsi, [rbp - 136]
    call asm_free
.Llibrary_sort_nofree65:
    mov rdi, [rbp - 120]
    test rdi, rdi
    jz .Llibrary_sort_nofree66
    mov rsi, [rbp - 144]
    call asm_free
.Llibrary_sort_nofree66:
    mov rdi, [rbp - 128]
    test rdi, rdi
    jz .Llibrary_sort_nofree67
    mov rsi, [rbp - 152]
    call asm_free
.Llibrary_sort_nofree67:
    pop rax
    leave
    ret

library_sort_x_locate:
    push rbp
    mov rbp, rsp
    sub rsp, 64
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
.Llibrary_sort_wtop69:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Llibrary_sort_wbody70
    jmp .Llibrary_sort_wend71
.Llibrary_sort_wbody70:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 56]
    mov [rbp - 64], rax
.Llibrary_sort_wtop72:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Llibrary_sort_n75
    jmp .Llibrary_sort_wend74
.Llibrary_sort_n75:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Llibrary_sort_wbody73
    jmp .Llibrary_sort_wend74
.Llibrary_sort_wbody73:
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
    jmp .Llibrary_sort_wtop72
.Llibrary_sort_wend74:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Llibrary_sort_then77
    jmp .Llibrary_sort_else78
.Llibrary_sort_then77:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    jmp .Llibrary_sort_endif79
.Llibrary_sort_else78:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Llibrary_sort_then80
    jmp .Llibrary_sort_else81
.Llibrary_sort_then80:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    jmp .Llibrary_sort_endif82
.Llibrary_sort_else81:
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 40], rax
.Llibrary_sort_endif82:
.Llibrary_sort_endif79:
    jmp .Llibrary_sort_wtop69
.Llibrary_sort_wend71:
    mov rax, [rbp - 40]
    jmp .Llibrary_sort_ret68
    xor eax, eax
.Llibrary_sort_ret68:
    leave
    ret

.section .note.GNU-stack,"",@progbits
