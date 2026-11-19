/* GENERATED from kernels/algos/enumeration_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void enumeration_sort_impl(int32_t *a, int64_t n);

static void enumeration_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t rank = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int32_t *out = NULL;
    out = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        rank = 0;
        j = 0;
        _e2 = n;
        while ((j < _e2)) {
            if (((((int64_t)a[j]) < ((int64_t)a[i])) || ((((int64_t)a[j]) == ((int64_t)a[i])) && (j < i)))) {
                rank = (rank + 1);
            }
            j = (j + 1);
        }
        out[rank] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    i = 0;
    _e3 = n;
    while ((i < _e3)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
    free(out);
}

void enumeration_sort(int *arr, size_t n) {
    enumeration_sort_impl((int32_t *)arr, (int64_t)n);
}
