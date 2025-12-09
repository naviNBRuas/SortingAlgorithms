global insertion_sort
; x86-64 System V ABI implementation of insertion_sort
; void insertion_sort(int *arr, size_t n)
; arr pointer in RDI, n in RSI

section .text
global insertion_sort
insertion_sort:
    push rbp
    mov rbp, rsp
    push rbx

    cmp rsi, 1              ; n <= 1
    jbe .done

    mov rbx, rdi            ; base pointer
    mov rcx, 1              ; i = 1

.outer:
    cmp rcx, rsi
    jae .done_outer
    mov eax, DWORD [rbx + rcx*4] ; key = arr[i]
    mov r8, rcx                    ; j = i

.inner:
    cmp r8, 0
    je .place
    mov edx, DWORD [rbx + (r8-1)*4]
    cmp edx, eax
    jle .place
    mov DWORD [rbx + r8*4], edx
    dec r8
    jmp .inner

.place:
    mov DWORD [rbx + r8*4], eax
    inc rcx
    jmp .outer

.done_outer:
.done:
    pop rbx
    pop rbp
    ret
