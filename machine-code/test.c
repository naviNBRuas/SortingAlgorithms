/* Loads each raw machine-code image into executable memory and runs it against qsort(). */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

static const struct { const char *name; size_t cap; int extras; } table[] = {
#include "table.h"
};

static int cmp(const void *a, const void *b) { return (*(const int *)a > *(const int *)b) - (*(const int *)a < *(const int *)b); }
static unsigned long long state = 12345;
static long long rnd(void) { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; return (long long)(state / 16); }

static void fill(int *d, size_t n, int mode) {
    for (size_t i = 0; i < n; ++i) {
        switch (mode) {
        case 0: d[i] = (int)(rnd() % 21) - 10; break;
        case 1: d[i] = (int)(rnd() % 2000001) - 1000000; break;
        case 2: d[i] = (int)i; break;
        case 3: d[i] = (int)(n - i); break;
        default: d[i] = 7; break;
        }
    }
}

static void *load(const char *name, size_t *len) {
    char path[256];
    snprintf(path, sizeof path, "bin/%s.bin", name);
    FILE *f = fopen(path, "rb");
    if (!f) { perror(path); exit(2); }
    fseek(f, 0, SEEK_END); *len = (size_t)ftell(f); fseek(f, 0, SEEK_SET);
    void *mem = mmap(NULL, *len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (mem == MAP_FAILED || fread(mem, 1, *len, f) != *len) { perror("load"); exit(2); }
    fclose(f);
    if (mprotect(mem, *len, PROT_READ | PROT_EXEC)) { perror("mprotect"); exit(2); }
    return mem;
}

static int check(const char *name, void *code, int extras, const int *src, size_t n) {
    int *a = malloc(n * sizeof(int) + 4), *w = malloc(n * sizeof(int) + 4);
    memcpy(a, src, n * sizeof(int));
    memcpy(w, src, n * sizeof(int));
    qsort(w, n, sizeof(int), cmp);
    if (extras) ((void (*)(int *, size_t, size_t))code)(a, n, 5000000);
    else ((void (*)(int *, size_t))code)(a, n);
    int ok = memcmp(a, w, n * sizeof(int)) == 0;
    if (!ok) printf("FAIL %s n=%zu\n", name, n);
    free(a); free(w);
    return ok;
}

int main(void) {
    static const size_t sizes[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,25,30,40,64,100,257,1000};
    int failures = 0;
    size_t total = 0;
    int *d = malloc(1100 * sizeof(int));
    for (size_t k = 0; k < sizeof table / sizeof table[0]; ++k) {
        size_t len;
        void *code = load(table[k].name, &len);
        total += len;
        for (size_t s = 0; s < sizeof sizes / sizeof sizes[0]; ++s) {
            size_t n = sizes[s];
            if (table[k].cap && n > table[k].cap) continue;
            for (int mode = 0; mode < 5; ++mode) { fill(d, n, mode); failures += !check(table[k].name, code, table[k].extras, d, n); }
        }
        int e[] = {2147483647, -2147483647 - 1, 0, -1, 2147483647, -2147483647 - 1, 5, 5};
        failures += !check(table[k].name, code, table[k].extras, e, table[k].cap && table[k].cap < 8 ? table[k].cap : 8);
    }
    free(d);
    if (failures) { printf("%d failures\n", failures); return 1; }
    printf("all %zu machine-code images ok (%zu bytes of raw x86-64)\n", sizeof table / sizeof table[0], total);
    return 0;
}
