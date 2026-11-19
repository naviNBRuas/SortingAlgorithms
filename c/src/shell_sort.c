/* GENERATED from kernels/algos/shell_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void shell_sort_impl(int32_t *a, int64_t n);

static void shell_sort_impl(int32_t *a, int64_t n) {
    int64_t gap = 0;
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    gap = (n / 2);
    while ((gap > 0)) {
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
        gap = (gap / 2);
    }
}

void shell_sort(int *arr, size_t n) {
    shell_sort_impl((int32_t *)arr, (int64_t)n);
}
