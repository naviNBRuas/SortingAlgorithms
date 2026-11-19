/* GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void shell_sort_ciura_impl(int32_t *a, int64_t n);

static void shell_sort_ciura_impl(int32_t *a, int64_t n) {
    int64_t k = 0;
    int64_t gap = 0;
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int32_t *g = NULL;
    g = (int32_t *)calloc((size_t)k_max(1, 10), sizeof(int32_t));
    g[0] = (int32_t)(1);
    g[1] = (int32_t)(4);
    g[2] = (int32_t)(10);
    g[3] = (int32_t)(23);
    g[4] = (int32_t)(57);
    g[5] = (int32_t)(132);
    g[6] = (int32_t)(301);
    g[7] = (int32_t)(701);
    g[8] = (int32_t)(1750);
    g[9] = (int32_t)(4377);
    k = 9;
    while ((k >= 0)) {
        gap = ((int64_t)g[k]);
        if ((gap < n)) {
            i = gap;
            _e1 = n;
            while ((i < _e1)) {
                key = ((int64_t)a[i]);
                j = i;
                while (((j >= gap) && (((int64_t)a[(j - gap)]) > key))) {
                    a[j] = (int32_t)(((int64_t)a[(j - gap)]));
                    j = (j - gap);
                }
                a[j] = (int32_t)(key);
                i = (i + 1);
            }
        }
        k = (k - 1);
    }
    free(g);
}

void shell_sort_ciura(int *arr, size_t n) {
    shell_sort_ciura_impl((int32_t *)arr, (int64_t)n);
}
