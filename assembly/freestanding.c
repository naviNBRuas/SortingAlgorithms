/* Links the assembly sorts with NO libc (-nostdlib -static): proves they depend on nothing
 * but the Linux kernel ABI. Exit status 0 = every sort produced sorted output. */
typedef unsigned long size_t;

#define ALGOS(X) \
    X(bubble) X(selection) X(insertion) X(binary_insertion) X(shell) X(comb) X(cocktail_shaker) \
    X(odd_even) X(gnome) X(cycle) X(pancake) X(stooge) X(bitonic) X(merge) X(quick) X(heap) \
    X(counting) X(pigeonhole) X(radix_lsd) X(bucket) X(bead) X(tree) X(patience) X(strand) \
    X(tim) X(intro) X(smooth)
#define radix_lsd_sort_asm radix_sort_lsd_asm
#define DECL(n) void n##_sort_asm(int *, size_t);
ALGOS(DECL)
#define ROW(n) n##_sort_asm,
static void (*const fns[])(int *, size_t) = { ALGOS(ROW) };
#define COUNT (sizeof fns / sizeof fns[0])

static unsigned long long rs = 88172645463325252ULL;
static unsigned rnd(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return (unsigned)(rs >> 11); }

static void say(const char *s) {
    size_t n = 0;
    while (s[n]) ++n;
    long r;
    __asm__ volatile("syscall" : "=a"(r) : "0"(1L), "D"(1L), "S"(s), "d"(n) : "rcx", "r11", "memory");
}

void c_start(void) {
    int bad = 0;
    for (size_t k = 0; k < COUNT; ++k) {
        int a[200];
        size_t n = k == 11 ? 30 : 200;              /* stooge sort is O(n^2.7) */
        for (size_t i = 0; i < n; ++i) a[i] = (int)(rnd() % 2001) - 1000;
        fns[k](a, n);
        for (size_t i = 1; i < n; ++i) if (a[i - 1] > a[i]) { bad = 1; break; }
    }
    say(bad ? "freestanding: FAIL\n" : "freestanding: all 27 sorts ok without libc\n");
    long r;
    __asm__ volatile("syscall" : "=a"(r) : "0"(60L), "D"((long)bad) : "rcx", "r11", "memory");
    for (;;) {}
}

__asm__(".globl _start\n_start:\n  xor %ebp,%ebp\n  and $-16,%rsp\n  call c_start\n");
