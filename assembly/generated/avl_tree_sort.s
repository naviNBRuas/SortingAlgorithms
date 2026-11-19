# GENERATED from kernels/algos/avl_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl avl_tree_sort_asm
avl_tree_sort_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 160
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 64], 0
    mov qword ptr [rbp - 72], 0
    mov qword ptr [rbp - 80], 0
    mov qword ptr [rbp - 88], 0
    mov qword ptr [rbp - 96], 0
    mov rax, [rbp - 16]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lavl_tree_sort_then2
    jmp .Lavl_tree_sort_else3
.Lavl_tree_sort_then2:
    jmp .Lavl_tree_sort_ret1
.Lavl_tree_sort_else3:
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lavl_tree_sort_sz5
    mov eax, 1
.Lavl_tree_sort_sz5:
    shl rax, 2
    mov [rbp - 104], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 64], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lavl_tree_sort_sz6
    mov eax, 1
.Lavl_tree_sort_sz6:
    shl rax, 2
    mov [rbp - 112], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 72], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lavl_tree_sort_sz7
    mov eax, 1
.Lavl_tree_sort_sz7:
    shl rax, 2
    mov [rbp - 120], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 80], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lavl_tree_sort_sz8
    mov eax, 1
.Lavl_tree_sort_sz8:
    shl rax, 2
    mov [rbp - 128], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 88], rax
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lavl_tree_sort_sz9
    mov eax, 1
.Lavl_tree_sort_sz9:
    shl rax, 2
    mov [rbp - 136], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 96], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 144], rax
.Lavl_tree_sort_ftop10:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 144]
    jl .Lavl_tree_sort_fbody11
    jmp .Lavl_tree_sort_fend12
.Lavl_tree_sort_fbody11:
    mov rax, [rbp - 24]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 24]
    mov rcx, [rbp - 64]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 24]
    jmp .Lavl_tree_sort_ftop10
.Lavl_tree_sort_fend12:
    mov rax, 0
    mov [rbp - 32], rax
    mov rax, 0
    mov [rbp - 24], rax
    mov rax, [rbp - 16]
    mov [rbp - 152], rax
.Lavl_tree_sort_ftop13:
    mov rax, [rbp - 24]
    cmp rax, [rbp - 152]
    jl .Lavl_tree_sort_fbody14
    jmp .Lavl_tree_sort_fend15
.Lavl_tree_sort_fbody14:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 72]
    push rax
    mov rax, [rbp - 80]
    push rax
    mov rax, [rbp - 88]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    push rax
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_insert
    mov [rbp - 32], rax
    inc qword ptr [rbp - 24]
    jmp .Lavl_tree_sort_ftop13
.Lavl_tree_sort_fend15:
    mov rax, [rbp - 32]
    mov [rbp - 40], rax
    mov rax, 0
    mov [rbp - 48], rax
    mov rax, 0
    mov [rbp - 56], rax
.Lavl_tree_sort_wtop16:
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Lavl_tree_sort_wbody17
    jmp .Lavl_tree_sort_n19
.Lavl_tree_sort_n19:
    mov rax, [rbp - 48]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lavl_tree_sort_wbody17
    jmp .Lavl_tree_sort_wend18
.Lavl_tree_sort_wbody17:
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jne .Lavl_tree_sort_then21
    jmp .Lavl_tree_sort_else22
.Lavl_tree_sort_then21:
    mov rax, [rbp - 40]
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 96]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 72]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    jmp .Lavl_tree_sort_endif23
.Lavl_tree_sort_else22:
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 96]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 64]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 80]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
.Lavl_tree_sort_endif23:
    jmp .Lavl_tree_sort_wtop16
.Lavl_tree_sort_wend18:
    xor eax, eax
.Lavl_tree_sort_ret1:
    push rax
    mov rdi, [rbp - 64]
    test rdi, rdi
    jz .Lavl_tree_sort_nofree24
    mov rsi, [rbp - 104]
    call asm_free
.Lavl_tree_sort_nofree24:
    mov rdi, [rbp - 72]
    test rdi, rdi
    jz .Lavl_tree_sort_nofree25
    mov rsi, [rbp - 112]
    call asm_free
.Lavl_tree_sort_nofree25:
    mov rdi, [rbp - 80]
    test rdi, rdi
    jz .Lavl_tree_sort_nofree26
    mov rsi, [rbp - 120]
    call asm_free
.Lavl_tree_sort_nofree26:
    mov rdi, [rbp - 88]
    test rdi, rdi
    jz .Lavl_tree_sort_nofree27
    mov rsi, [rbp - 128]
    call asm_free
.Lavl_tree_sort_nofree27:
    mov rdi, [rbp - 96]
    test rdi, rdi
    jz .Lavl_tree_sort_nofree28
    mov rsi, [rbp - 136]
    call asm_free
.Lavl_tree_sort_nofree28:
    pop rax
    leave
    ret

avl_tree_sort_x_height:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov rax, [rbp - 16]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lavl_tree_sort_then30
    jmp .Lavl_tree_sort_else31
.Lavl_tree_sort_then30:
    mov rax, 0
    jmp .Lavl_tree_sort_ret29
.Lavl_tree_sort_else31:
    mov rax, [rbp - 16]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    jmp .Lavl_tree_sort_ret29
    xor eax, eax
.Lavl_tree_sort_ret29:
    leave
    ret

avl_tree_sort_x_fix:
    push rbp
    mov rbp, rsp
    sub rsp, 32
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, 1
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    pop rcx
    cmp rcx, rax
    cmovg rax, rcx
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    pop rdx
    mov [rcx + rax*4], edx
    xor eax, eax
.Lavl_tree_sort_ret33:
    leave
    ret

avl_tree_sort_x_rot_right:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
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
    sub rax, rcx
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_fix
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 40]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_fix
    mov rax, [rbp - 40]
    jmp .Lavl_tree_sort_ret34
    xor eax, eax
.Lavl_tree_sort_ret34:
    leave
    ret

avl_tree_sort_x_rot_left:
    push rbp
    mov rbp, rsp
    sub rsp, 48
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 40], rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_fix
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 40]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_fix
    mov rax, [rbp - 40]
    jmp .Lavl_tree_sort_ret35
    xor eax, eax
.Lavl_tree_sort_ret35:
    leave
    ret

avl_tree_sort_x_insert:
    push rbp
    mov rbp, rsp
    sub rsp, 80
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov [rbp - 24], rdx
    mov [rbp - 32], rcx
    mov [rbp - 40], r8
    mov [rbp - 48], r9
    mov rax, [rbp - 40]
    push rax
    mov rax, 0
    mov rcx, rax
    pop rax
    cmp rax, rcx
    je .Lavl_tree_sort_then37
    jmp .Lavl_tree_sort_else38
.Lavl_tree_sort_then37:
    mov rax, 1
    push rax
    mov rax, [rbp - 48]
    mov rcx, [rbp - 32]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 48]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    jmp .Lavl_tree_sort_ret36
.Lavl_tree_sort_else38:
    mov rax, [rbp - 48]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 40]
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
    jl .Lavl_tree_sort_then40
    jmp .Lavl_tree_sort_else41
.Lavl_tree_sort_then40:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    push rax
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_insert
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
    jmp .Lavl_tree_sort_endif42
.Lavl_tree_sort_else41:
    mov rax, [rbp - 8]
    push rax
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 48]
    push rax
    pop r9
    pop r8
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_insert
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    pop rdx
    mov [rcx + rax*4], edx
.Lavl_tree_sort_endif42:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_fix
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov [rbp - 56], rax
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jg .Lavl_tree_sort_then43
    jmp .Lavl_tree_sort_else44
.Lavl_tree_sort_then43:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 64], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lavl_tree_sort_then46
    jmp .Lavl_tree_sort_else47
.Lavl_tree_sort_then46:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 64]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_rot_left
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    pop rdx
    mov [rcx + rax*4], edx
.Lavl_tree_sort_else47:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_rot_right
    jmp .Lavl_tree_sort_ret36
.Lavl_tree_sort_else44:
    mov rax, [rbp - 56]
    push rax
    mov rax, 1
    neg rax
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lavl_tree_sort_then49
    jmp .Lavl_tree_sort_else50
.Lavl_tree_sort_then49:
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    movsxd rax, dword ptr [rcx + rax*4]
    mov [rbp - 72], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 16]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    pop rsi
    pop rdi
    call avl_tree_sort_x_height
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lavl_tree_sort_then52
    jmp .Lavl_tree_sort_else53
.Lavl_tree_sort_then52:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 72]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_rot_right
    push rax
    mov rax, [rbp - 40]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    sub rax, rcx
    mov rcx, [rbp - 24]
    pop rdx
    mov [rcx + rax*4], edx
.Lavl_tree_sort_else53:
    mov rax, [rbp - 16]
    push rax
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 40]
    push rax
    pop rcx
    pop rdx
    pop rsi
    pop rdi
    call avl_tree_sort_x_rot_left
    jmp .Lavl_tree_sort_ret36
.Lavl_tree_sort_else50:
    mov rax, [rbp - 40]
    jmp .Lavl_tree_sort_ret36
    xor eax, eax
.Lavl_tree_sort_ret36:
    leave
    ret

.section .note.GNU-stack,"",@progbits
