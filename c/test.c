#include "sorting_algorithms.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef void (*sort_fn)(int *, size_t);
static int cmp(const void *a, const void *b) { return (*(const int *)a > *(const int *)b) - (*(const int *)a < *(const int *)b); }

static int check(const char *name, sort_fn f, size_t n, int *src) {
    int *a = malloc((n ? n : 1) * sizeof(int)), *w = malloc((n ? n : 1) * sizeof(int));
    memcpy(a, src, n * sizeof(int));
    memcpy(w, src, n * sizeof(int));
    qsort(w, n, sizeof(int), cmp);
    f(a, n);
    int ok = memcmp(a, w, n * sizeof(int)) == 0;
    if (!ok) printf("FAIL %s n=%zu\n", name, n);
    free(a); free(w);
    return ok;
}

int main(void) {
    struct { const char *name; sort_fn fn; } algos[] = {
    { "bubble_sort", bubble_sort },
    { "selection_sort", selection_sort },
    { "insertion_sort", insertion_sort },
    { "binary_insertion_sort", binary_insertion_sort },
    { "merge_sort", merge_sort },
    { "quick_sort", quick_sort },
    { "heap_sort", heap_sort },
    { "shell_sort", shell_sort },
    { "comb_sort", comb_sort },
    { "cocktail_shaker_sort", cocktail_shaker_sort },
    { "odd_even_sort", odd_even_sort },
    { "gnome_sort", gnome_sort },
    { "cycle_sort", cycle_sort },
    { "pancake_sort", pancake_sort },
    { "bitonic_sort", bitonic_sort },
    { "counting_sort", counting_sort },
    { "radix_sort_lsd", radix_sort_lsd },
    { "bucket_sort", bucket_sort },
    { "pigeonhole_sort", pigeonhole_sort },
    { "bead_sort", bead_sort },
    { "tree_sort", tree_sort },
    { "patience_sort", patience_sort },
    { "strand_sort", strand_sort },
    { "tim_sort", tim_sort },
    { "intro_sort", intro_sort },
    { "smooth_sort", smooth_sort },
    };
    srand(1);
    int failures = 0;
    for (size_t k = 0; k < sizeof algos / sizeof algos[0]; ++k)
        for (size_t n = 0; n <= 150; n += (n < 10 ? 1 : 7)) {
            int *d = malloc((n ? n : 1) * sizeof(int));
            for (size_t i = 0; i < n; ++i) d[i] = rand() % 21 - 10;
            failures += !check(algos[k].name, algos[k].fn, n, d);
            for (size_t i = 0; i < n; ++i) d[i] = (int)i;
            failures += !check(algos[k].name, algos[k].fn, n, d);
            for (size_t i = 0; i < n; ++i) d[i] = (int)(n - i);
            failures += !check(algos[k].name, algos[k].fn, n, d);
            free(d);
        }
    { int d[] = {5, 3, 1, 4, 2, 0}; int ok = 1; stooge_sort(d, 6); for (int i = 0; i < 6; ++i) ok &= d[i] == i; failures += !ok; }
    printf(failures ? "%d failures\n" : "all C sorts ok\n", failures);
    return failures != 0;
}
