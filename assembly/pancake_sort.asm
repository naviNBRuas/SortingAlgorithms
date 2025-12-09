; x86-64 System V implementation of pancake_sort
; void pancake_sort(int *arr, size_t n)

section .text
global pancake_sort_asm
pancake_sort_asm:
    push rbp
    mov rbp, rsp
    push rbx

    mov rbx, rdi        ; arr
    mov r8, rsi         ; n
    cmp r8, 1
    jbe .done

.outer:
    cmp r8, 1
    jbe .done
    ; find max in arr[0..n-1]
    xor rcx, rcx        ; max_idx = 0
    mov rdx, 1
.find_max:
    cmp rdx, r8
    jae .found
    mov eax, DWORD [rbx + rdx*4]
    mov edi, DWORD [rbx + rcx*4]
    cmp eax, edi
    jle .next
    mov rcx, rdx
.next:
    inc rdx
    jmp .find_max
.found:
    ; if max_idx == n-1 skip
    mov rax, r8
    dec rax
    cmp rcx, rax
    je .shrink
    ; flip to front
    mov rdi, rcx
    call flip_prefix
    ; flip to end
    mov rdi, r8
    dec rdi
    call flip_prefix

.shrink:
    dec r8
    jmp .outer

.done:
    pop rbx
    pop rbp
    ret

; helper: flip first (k+1) elements, k in RDI, uses rbx as base arr
; clobbers rax, rcx, rdx
flip_prefix:
    push rbp
    mov rbp, rsp
    mov rcx, 0
    mov rdx, rdi
.flip_loop:
    cmp rcx, rdx
    jge .flip_done
    mov eax, DWORD [rbx + rcx*4]
    mov edi, DWORD [rbx + rdx*4]
    mov DWORD [rbx + rcx*4], edi
    mov DWORD [rbx + rdx*4], eax
    inc rcx
    dec rdx
    jmp .flip_loop
.flip_done:
    pop rbp
    ret
