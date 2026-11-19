/* GENERATED from kernels/algos/insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void insertion_sort_impl(int32_t *a, int64_t n);

static void insertion_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        key = ((int64_t)a[i]);
        j = (i - 1);
        while (((j >= 0) && (((int64_t)a[j]) > key))) {
            a[(j + 1)] = (int32_t)(((int64_t)a[j]));
            j = (j - 1);
        }
        a[(j + 1)] = (int32_t)(key);
        i = (i + 1);
    }
}

void insertion_sort(int *arr, size_t n) {
    insertion_sort_impl((int32_t *)arr, (int64_t)n);
}
