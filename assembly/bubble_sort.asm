global bubble_sort
; x86-64 System V ABI implementation of bubble_sort
; void bubble_sort(int *arr, size_t n)
; arr pointer in RDI, n in RSI

section .text
global bubble_sort
bubble_sort:
    push rbp
    mov rbp, rsp
    push rbx                ; save callee-saved

    cmp rsi, 1              ; n <= 1? return
    jbe .done

    mov rbx, rdi            ; base pointer to arr
    mov r8, rsi             ; r8 = n
    xor rcx, rcx            ; outer index i = 0

.outer_loop:
    mov rdx, r8             ; rdx = n
    sub rdx, rcx            ; rdx = n - i
    cmp rdx, 1
    jbe .outer_next         ; if remaining <=1, skip

    xor r9, r9              ; inner index j = 0
.inner_loop:
    mov eax, DWORD [rbx + r9*4]      ; arr[j]
    mov edx, DWORD [rbx + r9*4 + 4]  ; arr[j+1]
    cmp eax, edx
    jle .no_swap
    ; swap arr[j], arr[j+1]
    mov DWORD [rbx + r9*4], edx
    mov DWORD [rbx + r9*4 + 4], eax
.no_swap:
    inc r9
    mov r10, r8
    sub r10, rcx            ; r10 = n - i
    sub r10, 1              ; last inner index
    cmp r9, r10
    jb .inner_loop

.outer_next:
    inc rcx
    cmp rcx, r8
    jb .outer_loop

.done:
    pop rbx
    pop rbp
    ret
