# GENERATED from kernels/algos/cartesian_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl cartesian_tree_sort_asm
cartesian_tree_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 176
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 72], 0
    mov qword ptr [rbp - 80], 0
    mov qword ptr [rbp - 88], 0
    mov qword ptr [rbp - 96], 0
    mov qword ptr [rbp - 104], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcartesian_tree_sort_then2
    jmp .Lcartesian_tree_sort_else3
.Lcartesian_tree_sort_then2:
    jmp .Lcartesian_tree_sort_ret1
.Lcartesian_tree_sort_else3:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lcartesian_tree_sort_sz5
    mov eax, 1
.Lcartesian_tree_sort_sz5:
    shl rax, 2
    mov [rbp - 112], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 72], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lcartesian_tree_sort_sz6
    mov eax, 1
.Lcartesian_tree_sort_sz6:
    shl rax, 2
    mov [rbp - 120], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lcartesian_tree_sort_sz7
    mov eax, 1
.Lcartesian_tree_sort_sz7:
    shl rax, 2
    mov [rbp - 128], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 88], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lcartesian_tree_sort_sz8
    mov eax, 1
.Lcartesian_tree_sort_sz8:
    shl rax, 2
    mov [rbp - 136], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 96], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lcartesian_tree_sort_sz9
    mov eax, 1
.Lcartesian_tree_sort_sz9:
    shl rax, 2
    mov [rbp - 144], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 104], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 152], rax
.Lcartesian_tree_sort_ftop10:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 152]
    jl .Lcartesian_tree_sort_fbody11
    jmp .Lcartesian_tree_sort_fend12
.Lcartesian_tree_sort_fbody11:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 72]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 1
    neg rax
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 1
    neg rax
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 88]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lcartesian_tree_sort_ftop10
.Lcartesian_tree_sort_fend12:
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 160], rax
.Lcartesian_tree_sort_ftop13:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 160]
    jl .Lcartesian_tree_sort_fbody14
    jmp .Lcartesian_tree_sort_fend15
.Lcartesian_tree_sort_fbody14:
    mov rax, 1
    neg rax
    mov [rbp - 40], rax
.Lcartesian_tree_sort_wtop16:
    mov rax, [rbp - 32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lcartesian_tree_sort_n19
    jmp .Lcartesian_tree_sort_wend18
.Lcartesian_tree_sort_n19:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcartesian_tree_sort_wbody17
    jmp .Lcartesian_tree_sort_wend18
.Lcartesian_tree_sort_wbody17:
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 32], rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    jmp .Lcartesian_tree_sort_wtop16
.Lcartesian_tree_sort_wend18:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 80]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 32]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lcartesian_tree_sort_then21
    jmp .Lcartesian_tree_sort_else22
.Lcartesian_tree_sort_then21:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 88]
    pop rdx
    mov [rcx + rax*4], edx
.Lcartesian_tree_sort_else22:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 96]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
    inc qword ptr [rbp - 24]
    jmp .Lcartesian_tree_sort_ftop13
.Lcartesian_tree_sort_fend15:
    mov rax, 0
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, [rbp - 104]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, 1
    mov [rbp - 48], rax
    mov rax, 0
    mov [rbp - 56], rax
    mov rax, [rbp - 16]
    mov [rbp - 168], rax
.Lcartesian_tree_sort_ftop24:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 168]
    jl .Lcartesian_tree_sort_fbody25
    jmp .Lcartesian_tree_sort_fend26
.Lcartesian_tree_sort_fbody25:
    mov rax, 0
    mov rcx, [rbp - 104]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 64], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 104]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, [rbp - 104]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 72]
    push rax
    mov rax, [rbp - 104]
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 0
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call cartesian_tree_sort_x_sift_down
    mov rax, [rbp - 64]
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 64]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lcartesian_tree_sort_then27
    jmp .Lcartesian_tree_sort_else28
.Lcartesian_tree_sort_then27:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 104]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 72]
    push rax
    mov rax, [rbp - 104]
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call cartesian_tree_sort_x_sift_up
.Lcartesian_tree_sort_else28:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lcartesian_tree_sort_then30
    jmp .Lcartesian_tree_sort_else31
.Lcartesian_tree_sort_then30:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 104]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 72]
    push rax
    mov rax, [rbp - 104]
    push rax
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    pop rdx
    pop rsi
    pop rdi
    call cartesian_tree_sort_x_sift_up
.Lcartesian_tree_sort_else31:
    inc qword ptr [rbp - 56]
    jmp .Lcartesian_tree_sort_ftop24
.Lcartesian_tree_sort_fend26:
    xor eax, eax
.Lcartesian_tree_sort_ret1:
    push rax
    mov rdi, [rbp - 72]
    test rdi, rdi
    jz .Lcartesian_tree_sort_nofree33
    mov rsi, [rbp - 112]
    call asm_free
.Lcartesian_tree_sort_nofree33:
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Lcartesian_tree_sort_nofree34
    mov rsi, [rbp - 120]
    call asm_free
.Lcartesian_tree_sort_nofree34:
    mov rdi, [rbp - 88]
    test rdi, rdi
    jz .Lcartesian_tree_sort_nofree35
    mov rsi, [rbp - 128]
    call asm_free
.Lcartesian_tree_sort_nofree35:
    mov rdi, [rbp - 96]
    test rdi, rdi
    jz .Lcartesian_tree_sort_nofree36
    mov rsi, [rbp - 136]
    call asm_free
.Lcartesian_tree_sort_nofree36:
    mov rdi, [rbp - 104]
    test rdi, rdi
    jz .Lcartesian_tree_sort_nofree37
    mov rsi, [rbp - 144]
    call asm_free
.Lcartesian_tree_sort_nofree37:
    pop rax
    leave
    ret

cartesian_tree_sort_x_sift_up:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
.Lcartesian_tree_sort_wtop39:
    mov rax, [rbp - 24]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lcartesian_tree_sort_n42
    jmp .Lcartesian_tree_sort_wend41
.Lcartesian_tree_sort_n42:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcartesian_tree_sort_wbody40
    jmp .Lcartesian_tree_sort_wend41
.Lcartesian_tree_sort_wbody40:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 16]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 24]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cqo
    idiv rcx
    mov [rbp - 24], rax
    jmp .Lcartesian_tree_sort_wtop39
.Lcartesian_tree_sort_wend41:
    xor eax, eax
.Lcartesian_tree_sort_ret38:
    leave
    ret

cartesian_tree_sort_x_sift_down:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, 1
    mov [rbp - 40], rax
.Lcartesian_tree_sort_wtop45:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lcartesian_tree_sort_wbody46
    jmp .Lcartesian_tree_sort_wend47
.Lcartesian_tree_sort_wbody46:
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
    mov [rbp - 48], rax
    mov rax, [rbp - 48]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jge .Lcartesian_tree_sort_then48
    jmp .Lcartesian_tree_sort_else49
.Lcartesian_tree_sort_then48:
    mov rax, 0
    mov [rbp - 40], rax
    jmp .Lcartesian_tree_sort_endif50
.Lcartesian_tree_sort_else49:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcartesian_tree_sort_n54
    jmp .Lcartesian_tree_sort_else52
.Lcartesian_tree_sort_n54:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcartesian_tree_sort_then51
    jmp .Lcartesian_tree_sort_else52
.Lcartesian_tree_sort_then51:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
.Lcartesian_tree_sort_else52:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lcartesian_tree_sort_then56
    jmp .Lcartesian_tree_sort_else57
.Lcartesian_tree_sort_then56:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 48]
    mov rdx, rax
    pop rsi
    mov rcx, [rbp - 16]
    mov eax, [rcx + rsi*4]
    mov r8d, [rcx + rdx*4]
    mov [rcx + rsi*4], r8d
    mov [rcx + rdx*4], eax
    mov rax, [rbp - 48]
    mov [rbp - 32], rax
    jmp .Lcartesian_tree_sort_endif58
.Lcartesian_tree_sort_else57:
    mov rax, 0
    mov [rbp - 40], rax
.Lcartesian_tree_sort_endif58:
.Lcartesian_tree_sort_endif50:
    jmp .Lcartesian_tree_sort_wtop45
.Lcartesian_tree_sort_wend47:
    xor eax, eax
.Lcartesian_tree_sort_ret44:
    leave
    ret

.section .note.GNU-stack,"",@progbits
