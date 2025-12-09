; x86-64 System V implementation of cocktail_shaker_sort
; void cocktail_shaker_sort(int *arr, size_t n)
; arr in RDI, n in RSI

section .text
global cocktail_shaker_sort_asm
cocktail_shaker_sort_asm:
    push rbp
    mov rbp, rsp
    push rbx

    cmp rsi, 1
    jbe .done
    mov rbx, rdi        ; base
    mov rcx, 0          ; start
    mov rdx, rsi
    dec rdx             ; end = n-1

.outer:
    mov r8b, 0          ; swapped flag
    ; forward pass
    mov r9, rcx
    cmp r9, rdx
    jae .check_swapped
.fwd_loop:
    mov eax, DWORD [rbx + r9*4]
    mov edi, DWORD [rbx + r9*4 + 4]
    cmp eax, edi
    jle .fwd_next
    mov DWORD [rbx + r9*4], edi
    mov DWORD [rbx + r9*4 + 4], eax
    mov r8b, 1
.fwd_next:
    inc r9
    cmp r9, rdx
    jb .fwd_loop

.check_swapped:
    cmp r8b, 0
    je .done
    mov r8b, 0
    dec rdx            ; end--
    ; backward pass
    cmp rcx, rdx
    jae .after_bwd
    mov r9, rdx
.bwd_loop:
    mov eax, DWORD [rbx + (r9-1)*4]
    mov edi, DWORD [rbx + r9*4]
    cmp eax, edi
    jle .bwd_next
    mov DWORD [rbx + (r9-1)*4], edi
    mov DWORD [rbx + r9*4], eax
    mov r8b, 1
.bwd_next:
    dec r9
    cmp r9, rcx
    ja .bwd_loop

.after_bwd:
    inc rcx            ; start++
    jmp .outer

.done:
    pop rbx
    pop rbp
    ret
