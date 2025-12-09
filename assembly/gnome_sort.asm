; x86-64 System V implementation of gnome_sort
; void gnome_sort(int *arr, size_t n)
; arr in RDI, n in RSI

section .text
global gnome_sort_asm
gnome_sort_asm:
    push rbp
    mov rbp, rsp
    push rbx

    mov rbx, rdi        ; base pointer
    cmp rsi, 1
    jbe .done
    mov rcx, 1          ; i = 1

.loop:
    cmp rcx, rsi
    jae .done
    mov eax, DWORD [rbx + rcx*4]
    mov edx, DWORD [rbx + (rcx-1)*4]
    cmp eax, edx
    jl .swap_back
    inc rcx
    jmp .loop

.swap_back:
    ; swap arr[i], arr[i-1]
    mov DWORD [rbx + rcx*4], edx
    mov DWORD [rbx + (rcx-1)*4], eax
    cmp rcx, 1
    je .inc_forward
    dec rcx
    jmp .loop

.inc_forward:
    inc rcx
    jmp .loop

.done:
    pop rbx
    pop rbp
    ret
