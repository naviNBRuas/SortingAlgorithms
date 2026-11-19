# GENERATED from kernels/algos/merge_sort_bottom_up.py by kernels/generate.py - do not edit; edit the kernel and regenerate. (compiler output, not hand-written)
.intel_syntax noprefix
.text

.globl merge_sort_bottom_up_asm
merge_sort_bottom_up_asm:
    push rbp
    mov rbp, rsp
    sub rsp, 112
    mov [rbp - 8], rdi
    mov [rbp - 16], rsi
    mov qword ptr [rbp - 88], 0
    mov rax, [rbp - 16]
    cmp rax, 1
    jge .Lmerge_sort_bottom_up_sz2
    mov eax, 1
.Lmerge_sort_bottom_up_sz2:
    shl rax, 2
    mov [rbp - 96], rax
    mov rdi, rax
    call asm_alloc
    mov [rbp - 88], rax
    mov rax, 1
    mov [rbp - 24], rax
.Lmerge_sort_bottom_up_wtop3:
    mov rax, [rbp - 24]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lmerge_sort_bottom_up_wbody4
    jmp .Lmerge_sort_bottom_up_wend5
.Lmerge_sort_bottom_up_wbody4:
    mov rax, 0
    mov [rbp - 32], rax
.Lmerge_sort_bottom_up_wtop6:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 16]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lmerge_sort_bottom_up_wbody7
    jmp .Lmerge_sort_bottom_up_wend8
.Lmerge_sort_bottom_up_wbody7:
    mov rax, [rbp - 32]
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 16]
    pop rcx
    cmp rcx, rax
    cmovl rax, rcx
    mov [rbp - 40], rax
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, rax
    pop rax
    add rax, rcx
    push rax
    mov rax, [rbp - 16]
    pop rcx
    cmp rcx, rax
    cmovl rax, rcx
    mov [rbp - 48], rax
    mov rax, [rbp - 32]
    mov [rbp - 56], rax
    mov rax, [rbp - 40]
    mov [rbp - 104], rax
.Lmerge_sort_bottom_up_ftop9:
    mov rax, [rbp - 56]
    cmp rax, [rbp - 104]
    jl .Lmerge_sort_bottom_up_fbody10
    jmp .Lmerge_sort_bottom_up_fend11
.Lmerge_sort_bottom_up_fbody10:
    mov rax, [rbp - 56]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 56]
    mov rcx, [rbp - 88]
    pop rdx
    mov [rcx + rax*4], edx
    inc qword ptr [rbp - 56]
    jmp .Lmerge_sort_bottom_up_ftop9
.Lmerge_sort_bottom_up_fend11:
    mov rax, [rbp - 32]
    mov [rbp - 64], rax
    mov rax, [rbp - 40]
    mov [rbp - 72], rax
    mov rax, [rbp - 32]
    mov [rbp - 80], rax
.Lmerge_sort_bottom_up_wtop12:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lmerge_sort_bottom_up_n15
    jmp .Lmerge_sort_bottom_up_wend14
.Lmerge_sort_bottom_up_n15:
    mov rax, [rbp - 72]
    push rax
    mov rax, [rbp - 48]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lmerge_sort_bottom_up_wbody13
    jmp .Lmerge_sort_bottom_up_wend14
.Lmerge_sort_bottom_up_wbody13:
    mov rax, [rbp - 72]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 64]
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lmerge_sort_bottom_up_then17
    jmp .Lmerge_sort_bottom_up_else18
.Lmerge_sort_bottom_up_then17:
    mov rax, [rbp - 72]
    mov rcx, [rbp - 8]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 80]
    mov rcx, [rbp - 8]
    pop rdx
    mov [rcx + rax*4], edx
    mov rax, [rbp - 72]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 72], rax
    jmp .Lmerge_sort_bottom_up_endif19
.Lmerge_sort_bottom_up_else18:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 80]
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
.Lmerge_sort_bottom_up_endif19:
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 80], rax
    jmp .Lmerge_sort_bottom_up_wtop12
.Lmerge_sort_bottom_up_wend14:
.Lmerge_sort_bottom_up_wtop20:
    mov rax, [rbp - 64]
    push rax
    mov rax, [rbp - 40]
    mov rcx, rax
    pop rax
    cmp rax, rcx
    jl .Lmerge_sort_bottom_up_wbody21
    jmp .Lmerge_sort_bottom_up_wend22
.Lmerge_sort_bottom_up_wbody21:
    mov rax, [rbp - 64]
    mov rcx, [rbp - 88]
    movsxd rax, dword ptr [rcx + rax*4]
    push rax
    mov rax, [rbp - 80]
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
    mov rax, [rbp - 80]
    push rax
    mov rax, 1
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 80], rax
    jmp .Lmerge_sort_bottom_up_wtop20
.Lmerge_sort_bottom_up_wend22:
    mov rax, [rbp - 32]
    push rax
    mov rax, 2
    push rax
    mov rax, [rbp - 24]
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov rcx, rax
    pop rax
    add rax, rcx
    mov [rbp - 32], rax
    jmp .Lmerge_sort_bottom_up_wtop6
.Lmerge_sort_bottom_up_wend8:
    mov rax, [rbp - 24]
    push rax
    mov rax, 2
    mov rcx, rax
    pop rax
    imul rax, rcx
    mov [rbp - 24], rax
    jmp .Lmerge_sort_bottom_up_wtop3
.Lmerge_sort_bottom_up_wend5:
    xor eax, eax
.Lmerge_sort_bottom_up_ret1:
    push rax
    mov rdi, [rbp - 88]
    test rdi, rdi
    jz .Lmerge_sort_bottom_up_nofree23
    mov rsi, [rbp - 96]
    call asm_free
.Lmerge_sort_bottom_up_nofree23:
    pop rax
    leave
    ret

.section .note.GNU-stack,"",@progbits
