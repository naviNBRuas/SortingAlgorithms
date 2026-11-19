# void heap_sort_asm(int *arr, size_t n)   (also used by intro sort on sub-ranges)
.intel_syntax noprefix
.text
.globl heap_sort_asm
heap_sort_asm:
    cmp rsi, 2
    jb .Lret
    mov r9, rsi                     # heap size
    mov r8, rsi
    shr r8, 1                       # build: i = n/2 .. 1
.Lbuild:
    test r8, r8
    jz .Lbuilt
    dec r8
    mov rcx, r8
    call .Lsift
    jmp .Lbuild
.Lbuilt:
    mov r8, rsi
.Lextract:
    dec r8
    jz .Lret
    mov eax, [rdi]
    mov edx, [rdi + r8*4]
    mov [rdi], edx
    mov [rdi + r8*4], eax
    mov r9, r8
    xor ecx, ecx
    call .Lsift
    jmp .Lextract
.Lsift:                             # rcx = root, r9 = size; clobbers rax rdx r10 r11
    lea r10, [rcx*2 + 1]
    cmp r10, r9
    jae .Lsift_ret
    lea r11, [r10 + 1]
    cmp r11, r9
    jae .Lchild
    mov eax, [rdi + r10*4]
    cmp eax, [rdi + r11*4]
    jge .Lchild
    mov r10, r11
.Lchild:
    mov eax, [rdi + rcx*4]
    mov edx, [rdi + r10*4]
    cmp eax, edx
    jge .Lsift_ret
    mov [rdi + rcx*4], edx
    mov [rdi + r10*4], eax
    mov rcx, r10
    jmp .Lsift
.Lsift_ret:
    ret
.Lret:
    ret
.section .note.GNU-stack,"",@progbits
