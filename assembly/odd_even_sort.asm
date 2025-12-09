; x86-64 System V implementation of odd_even_sort
; void odd_even_sort(int *arr, size_t n)
; arr in RDI, n in RSI

section .text
global odd_even_sort_asm
odd_even_sort_asm:
    push rbp
    mov rbp, rsp
    push rbx

    mov rbx, rdi
    mov r8, rsi        ; n
    cmp r8, 1
    jbe .done

.outer:
    mov r9b, 1         ; sorted = true (1)
    ; odd phase (indices 1,3,...)
    mov rcx, 1
.odd_loop:
    mov rdx, rcx
    inc rdx
    cmp rdx, r8
    jae .even_phase
    mov eax, DWORD [rbx + rcx*4]
    mov edi, DWORD [rbx + rdx*4]
    cmp eax, edi
    jle .odd_next
    mov DWORD [rbx + rcx*4], edi
    mov DWORD [rbx + rdx*4], eax
    mov r9b, 0
.odd_next:
    add rcx, 2
    jmp .odd_loop

.even_phase:
    mov rcx, 0
.even_loop:
    mov rdx, rcx
    inc rdx
    cmp rdx, r8
    jae .check
    mov eax, DWORD [rbx + rcx*4]
    mov edi, DWORD [rbx + rdx*4]
    cmp eax, edi
    jle .even_next
    mov DWORD [rbx + rcx*4], edi
    mov DWORD [rbx + rdx*4], eax
    mov r9b, 0
.even_next:
    add rcx, 2
    jmp .even_loop

.check:
    cmp r9b, 1
    jne .outer
    ; sorted
    jmp .done

.done:
    pop rbx
    pop rbp
    ret
