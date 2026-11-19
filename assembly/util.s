# util.s - tiny libc-free runtime shared by the assembly sorts (x86-64 Linux, System V ABI).
#   void *asm_alloc(size_t bytes)        -> zeroed memory via mmap(2), or NULL
#   void  asm_free(void *p, size_t bytes) -> munmap(2)
.intel_syntax noprefix
.text
.globl asm_alloc
asm_alloc:
    mov rsi, rdi
    test rsi, rsi
    jnz 1f
    mov esi, 1                  # mmap rejects length 0
1:  xor edi, edi                # addr = NULL
    mov edx, 3                  # PROT_READ | PROT_WRITE
    mov r10d, 0x22              # MAP_PRIVATE | MAP_ANONYMOUS
    mov r8, -1                  # fd
    xor r9d, r9d                # offset
    mov eax, 9                  # SYS_mmap
    syscall
    cmp rax, -4096
    ja 2f
    ret
2:  xor eax, eax
    ret

.globl asm_free
asm_free:
    mov eax, 11                 # SYS_munmap
    test rsi, rsi
    jnz 1f
    mov esi, 1
1:  syscall
    ret
.section .note.GNU-stack,"",@progbits
