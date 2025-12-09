; x86-64 System V implementation of comb_sort
; void comb_sort(int *arr, size_t n)
; arr in RDI, n in RSI

section .text
global comb_sort_asm
comb_sort_asm:
    push rbp
    mov rbp, rsp
    push rbx

    mov rbx, rdi
    mov r8, rsi        ; n
    cmp r8, 1
    jbe .done
    mov r9, r8         ; gap = n
    mov r10b, 1        ; swapped = true (1)

.outer:
    ; gap = floor(gap / 1.3)
    ; approximate by (gap * 10) / 13
    mov rax, r9
    imul rax, 10
    cqo
    mov rcx, 13
    idiv rcx           ; rax = gap/1.3
    cmp rax, 1
    jae .gap_ok
    mov rax, 1
.gap_ok:
    mov r9, rax
    mov r10b, 0        ; swapped = false

    xor rcx, rcx       ; i = 0
.inner:
    mov rdx, rcx
    add rdx, r9
    cmp rdx, r8
    jae .after_inner
    mov eax, DWORD [rbx + rcx*4]
    mov edi, DWORD [rbx + rdx*4]
    cmp eax, edi
    jle .inner_next
    mov DWORD [rbx + rcx*4], edi
    mov DWORD [rbx + rdx*4], eax
    mov r10b, 1
.inner_next:
    inc rcx
    jmp .inner

.after_inner:
    cmp r9, 1
    ja .outer_continue
    cmp r10b, 0
    jne .outer_continue
    jmp .done
.outer_continue:
    jmp .outer

.done:
    pop rbx
    pop rbp
    ret
