; x86-64 System V ABI implementation of selection_sort
; void selection_sort(int *arr, size_t n)
; arr in RDI, n in RSI

section .text
global selection_sort
selection_sort:
    push rbp
    mov rbp, rsp
    push rbx

    cmp rsi, 1
    jbe .done
    mov rbx, rdi            ; base
    xor rcx, rcx            ; i = 0

.outer:
    cmp rcx, rsi
    jae .done
    mov r8, rcx             ; min_idx = i
    mov r9, rcx
    inc r9                  ; j = i+1

.inner:
    cmp r9, rsi
    jae .after_inner
    mov eax, DWORD [rbx + r9*4]
    mov edx, DWORD [rbx + r8*4]
    cmp eax, edx
    jge .skip
    mov r8, r9              ; new min_idx
.skip:
    inc r9
    jmp .inner

.after_inner:
    cmp r8, rcx
    je .next_i
    ; swap arr[i], arr[min_idx]
    mov eax, DWORD [rbx + rcx*4]
    mov edx, DWORD [rbx + r8*4]
    mov DWORD [rbx + rcx*4], edx
    mov DWORD [rbx + r8*4], eax

.next_i:
    inc rcx
    jmp .outer

.done:
    pop rbx
    pop rbp
    ret
