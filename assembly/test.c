/* Test harness for the pure-assembly sorts: links against the *_asm symbols only. */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define ALGOS(X) \
    X(bubble) X(selection) X(insertion) X(binary_insertion) X(shell) X(comb) X(cocktail_shaker) \
    X(odd_even) X(gnome) X(cycle) X(pancake) X(stooge) X(bitonic) X(merge) X(quick) X(heap) \
    X(counting) X(pigeonhole) X(radix_lsd) X(bucket) X(bead) X(tree) X(patience) X(strand) \
    X(tim) X(intro) X(smooth)
#define radix_lsd_sort_asm radix_sort_lsd_asm
#define DECL(n) void n##_sort_asm(int *, size_t);
ALGOS(DECL)
void bogo_sort_asm(int *, size_t, size_t);

typedef void (*fn)(int *, size_t);
static const struct { const char *name; fn f; } table[] = {
#define ROW(n) { #n, n##_sort_asm },
    ALGOS(ROW)
};
#ifndef ONLY
#define ONLY NULL
#endif

static int cmp(const void *a, const void *b) { return (*(const int *)a > *(const int *)b) - (*(const int *)a < *(const int *)b); }
static unsigned long long rs = 88172645463325252ULL;
static unsigned rnd(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return (unsigned)(rs >> 11); }

static int check(const char *name, fn f, const int *src, size_t n) {
    int *a = malloc(n * sizeof(int) + 1), *w = malloc(n * sizeof(int) + 1);
    memcpy(a, src, n * sizeof(int));
    memcpy(w, src, n * sizeof(int));
    qsort(w, n, sizeof(int), cmp);
    f(a, n);
    int ok = memcmp(a, w, n * sizeof(int)) == 0;
    if (!ok) {
        printf("FAIL %s n=%zu\n", name, n);
        if (n <= 24) { for (size_t i = 0; i < n; ++i) printf("%d ", src[i]); printf("-> "); for (size_t i = 0; i < n; ++i) printf("%d ", a[i]); printf("\n"); }
    }
    free(a); free(w);
    return ok;
}

static void fill(int *d, size_t n, int mode) {
    for (size_t i = 0; i < n; ++i) {
        switch (mode) {
        case 0: d[i] = (int)(rnd() % 21) - 10; break;          /* many duplicates, negatives */
        case 1: d[i] = (int)(rnd() % 1000000) - 500000; break; /* wide range */
        case 2: d[i] = (int)i; break;                          /* sorted */
        case 3: d[i] = (int)(n - i); break;                    /* reversed */
        default: d[i] = 7; break;                              /* all equal */
        }
    }
}

int main(void) {
    int failures = 0;
    int *d = malloc(6000 * sizeof(int));
    for (size_t k = 0; k < sizeof table / sizeof table[0]; ++k) {
        if (ONLY && strcmp(ONLY, table[k].name)) continue;
        size_t cap = !strcmp(table[k].name, "stooge") ? 40 : 300;
        for (size_t n = 0; n <= cap; n += (n < 20 ? 1 : 3))
            for (int mode = 0; mode < 5; ++mode) {
                fill(d, n, mode);
                failures += !check(table[k].name, table[k].f, d, n);
            }
        if (strcmp(table[k].name, "stooge"))
            for (int mode = 1; mode <= 3; ++mode) {
                fill(d, 5000, mode);
                failures += !check(table[k].name, table[k].f, d, 5000);
            }
        int e[] = {2147483647, -2147483647 - 1, 0, -1, 2147483647, -2147483647 - 1, 5, 5};
        failures += !check(table[k].name, table[k].f, e, 8);
    }
    if (!ONLY || !strcmp(ONLY, "bogo")) {
        int b[6] = {3, 1, 2, 6, 5, 4};
        bogo_sort_asm(b, 6, 2000000);
        int ok = 1; for (int i = 0; i < 6; ++i) ok &= b[i] == i + 1;
        if (!ok) { printf("FAIL bogo\n"); ++failures; }
    }
    free(d);
    printf(failures ? "%d failures\n" : "all assembly sorts ok\n", failures);
    return failures != 0;
}
