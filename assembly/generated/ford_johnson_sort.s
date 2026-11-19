# GENERATED from kernels/algos/ford_johnson_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl ford_johnson_sort_asm
ford_johnson_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 80
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 32], 0
    mov qword ptr [rbp - 40], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_then2
    jmp .Lford_johnson_sort_else3
.Lford_johnson_sort_then2:
    jmp .Lford_johnson_sort_ret1
.Lford_johnson_sort_else3:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lford_johnson_sort_sz5
    mov eax, 1
.Lford_johnson_sort_sz5:
    shl rax, 2
    mov [rbp - 48], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 32], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lford_johnson_sort_sz6
    mov eax, 1
.Lford_johnson_sort_sz6:
    shl rax, 2
    mov [rbp - 56], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 64], rax
.Lford_johnson_sort_ftop7:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 64]
    jl .Lford_johnson_sort_fbody8
    jmp .Lford_johnson_sort_fend9
.Lford_johnson_sort_fbody8:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 32]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 40]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lford_johnson_sort_ftop7
.Lford_johnson_sort_fend9:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 16]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call ford_johnson_sort_x_fj
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 72], rax
.Lford_johnson_sort_ftop10:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 72]
    jl .Lford_johnson_sort_fbody11
    jmp .Lford_johnson_sort_fend12
.Lford_johnson_sort_fbody11:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 40]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 32]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lford_johnson_sort_ftop10
.Lford_johnson_sort_fend12:
    xor eax, eax
.Lford_johnson_sort_ret1:
    push rax
    mov rdi, [rbp - 32]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree13
    mov rsi, [rbp - 48]
    call asm_free
.Lford_johnson_sort_nofree13:
    mov rdi, [rbp - 40]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree14
    mov rsi, [rbp - 56]
    call asm_free
.Lford_johnson_sort_nofree14:
    pop rax
    leave
    ret

ford_johnson_sort_x_fj:
    push rbp
    mov rbp, rsp
    sub rsp, 304
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov qword ptr [rbp - 176], 0
    mov qword ptr [rbp - 184], 0
    mov qword ptr [rbp - 192], 0
    mov qword ptr [rbp - 200], 0
    mov qword ptr [rbp - 208], 0
    mov qword ptr [rbp - 216], 0
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_then16
    jmp .Lford_johnson_sort_else17
.Lford_johnson_sort_then16:
    jmp .Lford_johnson_sort_ret15
.Lford_johnson_sort_else17:
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    cmp rax, 1
    jge .Lford_johnson_sort_sz19
    mov eax, 1
.Lford_johnson_sort_sz19:
    shl rax, 2
    mov [rbp - 224], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 176], rax
    mov rax, [rbp - 32]
    cmp rax, 1
    jge .Lford_johnson_sort_sz20
    mov eax, 1
.Lford_johnson_sort_sz20:
    shl rax, 2
    mov [rbp - 232], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 184], rax
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 32]
    mov [rbp - 272], rax
.Lford_johnson_sort_ftop21:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 272]
    jl .Lford_johnson_sort_fbody22
    jmp .Lford_johnson_sort_fend23
.Lford_johnson_sort_fbody22:
    mov rax, 2
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 48], rax
    mov rax, 2
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    imul rax, rcx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 56], rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_then24
    jmp .Lford_johnson_sort_else25
.Lford_johnson_sort_then24:
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 176]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 184]
    pop rdx
    mov [rcx + rax*4], edx
    jmp .Lford_johnson_sort_endif26
.Lford_johnson_sort_else25:
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 176]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 184]
    pop rdx
    mov [rcx + rax*4], edx
.Lford_johnson_sort_endif26:
    inc qword ptr [rbp - 40]
    jmp .Lford_johnson_sort_ftop21
.Lford_johnson_sort_fend23:
    mov rax, [rbp - 32]
    cmp rax, 1
    jge .Lford_johnson_sort_sz27
    mov eax, 1
.Lford_johnson_sort_sz27:
    shl rax, 2
    mov [rbp - 240], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 192], rax
    mov rax, [rbp - 32]
    cmp rax, 1
    jge .Lford_johnson_sort_sz28
    mov eax, 1
.Lford_johnson_sort_sz28:
    shl rax, 2
    mov [rbp - 248], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 200], rax
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 32]
    mov [rbp - 280], rax
.Lford_johnson_sort_ftop29:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 280]
    jl .Lford_johnson_sort_fbody30
    jmp .Lford_johnson_sort_fend31
.Lford_johnson_sort_fbody30:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 184]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 192]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 200]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lford_johnson_sort_ftop29
.Lford_johnson_sort_fend31:
    mov rax, [rbp - 192]
    push rax
    mov rax, [rbp - 200]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rdx
    pop rsi
    pop rdi
    call ford_johnson_sort_x_fj
    mov rax, [rbp - 32]
    mov [rbp - 64], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lford_johnson_sort_then32
    jmp .Lford_johnson_sort_else33
.Lford_johnson_sort_then32:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 64], rax
.Lford_johnson_sort_else33:
    mov rax, [rbp - 24]
    cmp rax, 1
    jge .Lford_johnson_sort_sz35
    mov eax, 1
.Lford_johnson_sort_sz35:
    shl rax, 2
    mov [rbp - 256], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 208], rax
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    cmp rax, 1
    jge .Lford_johnson_sort_sz36
    mov eax, 1
.Lford_johnson_sort_sz36:
    shl rax, 2
    mov [rbp - 264], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 216], rax
    mov rax, 0
    mov rcx, [rbp - 200]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 176]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, [rbp - 208]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 32]
    mov [rbp - 288], rax
.Lford_johnson_sort_ftop37:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 288]
    jl .Lford_johnson_sort_fbody38
    jmp .Lford_johnson_sort_fend39
.Lford_johnson_sort_fbody38:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 200]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 184]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 208]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 40]
    mov rcx, [rbp - 200]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 176]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 216]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lford_johnson_sort_ftop37
.Lford_johnson_sort_fend39:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 72], rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lford_johnson_sort_then40
    jmp .Lford_johnson_sort_else41
.Lford_johnson_sort_then40:
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 216]
    pop rdx
    mov [rcx + rax*4], edx
.Lford_johnson_sort_else41:
    mov rax, 1
    mov [rbp - 80], rax
    mov rax, 2
    mov [rbp - 88], rax
.Lford_johnson_sort_wtop43:
    mov rax, [rbp - 80]
    push rax
    mov rax, [rbp - 64]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_wbody44
    jmp .Lford_johnson_sort_wend45
.Lford_johnson_sort_wbody44:
    mov rax, 1
    mov [rbp - 96], rax
    mov rax, 1
    mov [rbp - 104], rax
    mov rax, 0
    mov [rbp - 112], rax
.Lford_johnson_sort_wtop46:
    mov rax, [rbp - 112]
    push rax
    mov rax, [rbp - 88]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_wbody47
    jmp .Lford_johnson_sort_wend48
.Lford_johnson_sort_wbody47:
    mov rax, [rbp - 104]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 104], rax
    mov rax, [rbp - 112]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 112], rax
    jmp .Lford_johnson_sort_wtop46
.Lford_johnson_sort_wend48:
    mov rax, [rbp - 88]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rax, rdx
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lford_johnson_sort_then49
    jmp .Lford_johnson_sort_else50
.Lford_johnson_sort_then49:
    mov rax, [rbp - 104]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 96], rax
    jmp .Lford_johnson_sort_endif51
.Lford_johnson_sort_else50:
    mov rax, [rbp - 104]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 3
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 96], rax
.Lford_johnson_sort_endif51:
    mov rax, [rbp - 96]
    push rax
    mov rax, [rbp - 64]
    pop rcx
    cmp rcx, rax
    cmovl rax, rcx
    mov [rbp - 120], rax
    mov rax, [rbp - 120]
    mov [rbp - 128], rax
.Lford_johnson_sort_wtop52:
    mov rax, [rbp - 128]
    push rax
    mov rax, [rbp - 80]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lford_johnson_sort_wbody53
    jmp .Lford_johnson_sort_wend54
.Lford_johnson_sort_wbody53:
    mov rax, [rbp - 72]
    mov [rbp - 136], rax
    mov rax, [rbp - 128]
    push rax
    mov rax, [rbp - 32]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jle .Lford_johnson_sort_then55
    jmp .Lford_johnson_sort_else56
.Lford_johnson_sort_then55:
    mov rax, 0
    mov [rbp - 136], rax
.Lford_johnson_sort_wtop58:
    mov rax, [rbp - 136]
    mov rcx, [rbp - 208]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 128]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 200]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 184]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Lford_johnson_sort_wbody59
    jmp .Lford_johnson_sort_wend60
.Lford_johnson_sort_wbody59:
    mov rax, [rbp - 136]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 136], rax
    jmp .Lford_johnson_sort_wtop58
.Lford_johnson_sort_wend60:
.Lford_johnson_sort_else56:
    mov rax, 0
    mov [rbp - 144], rax
    mov rax, [rbp - 136]
    mov [rbp - 152], rax
.Lford_johnson_sort_wtop61:
    mov rax, [rbp - 144]
    push rax
    mov rax, [rbp - 152]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_wbody62
    jmp .Lford_johnson_sort_wend63
.Lford_johnson_sort_wbody62:
    mov rax, [rbp - 144]
    push rax
    mov rax, [rbp - 152]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 160], rax
    mov rax, [rbp - 128]
    mov rcx, [rbp - 216]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 160]
    mov rcx, [rbp - 208]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lford_johnson_sort_then64
    jmp .Lford_johnson_sort_else65
.Lford_johnson_sort_then64:
    mov rax, [rbp - 160]
    mov [rbp - 152], rax
    jmp .Lford_johnson_sort_endif66
.Lford_johnson_sort_else65:
    mov rax, [rbp - 160]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 144], rax
.Lford_johnson_sort_endif66:
    jmp .Lford_johnson_sort_wtop61
.Lford_johnson_sort_wend63:
    mov rax, [rbp - 72]
    mov [rbp - 168], rax
.Lford_johnson_sort_wtop67:
    mov rax, [rbp - 168]
    push rax
    mov rax, [rbp - 144]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lford_johnson_sort_wbody68
    jmp .Lford_johnson_sort_wend69
.Lford_johnson_sort_wbody68:
    mov rax, [rbp - 168]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 208]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 168]
    mov rcx, [rbp - 208]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 168]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 168], rax
    jmp .Lford_johnson_sort_wtop67
.Lford_johnson_sort_wend69:
    mov rax, [rbp - 128]
    mov rcx, [rbp - 216]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 144]
    mov rcx, [rbp - 208]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 72], rax
    mov rax, [rbp - 128]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 128], rax
    jmp .Lford_johnson_sort_wtop52
.Lford_johnson_sort_wend54:
    mov rax, [rbp - 120]
    mov [rbp - 80], rax
    mov rax, [rbp - 88]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 88], rax
    jmp .Lford_johnson_sort_wtop43
.Lford_johnson_sort_wend45:
    mov rax, 0
    mov [rbp - 40], rax
    mov rax, [rbp - 24]
    mov [rbp - 296], rax
.Lford_johnson_sort_ftop70:
    mov rax, [rbp - 40]
    cmp rax, [rbp - 296]
    jl .Lford_johnson_sort_fbody71
    jmp .Lford_johnson_sort_fend72
.Lford_johnson_sort_fbody71:
    mov rax, [rbp - 40]
    mov rcx, [rbp - 208]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 40]
    jmp .Lford_johnson_sort_ftop70
.Lford_johnson_sort_fend72:
    xor eax, eax
.Lford_johnson_sort_ret15:
    push rax
    mov rdi, [rbp - 176]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree73
    mov rsi, [rbp - 224]
    call asm_free
.Lford_johnson_sort_nofree73:
    mov rdi, [rbp - 184]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree74
    mov rsi, [rbp - 232]
    call asm_free
.Lford_johnson_sort_nofree74:
    mov rdi, [rbp - 192]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree75
    mov rsi, [rbp - 240]
    call asm_free
.Lford_johnson_sort_nofree75:
    mov rdi, [rbp - 200]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree76
    mov rsi, [rbp - 248]
    call asm_free
.Lford_johnson_sort_nofree76:
    mov rdi, [rbp - 208]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree77
    mov rsi, [rbp - 256]
    call asm_free
.Lford_johnson_sort_nofree77:
    mov rdi, [rbp - 216]
    test rdi, rdi
    jz .Lford_johnson_sort_nofree78
    mov rsi, [rbp - 264]
    call asm_free
.Lford_johnson_sort_nofree78:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
