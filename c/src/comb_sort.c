/* GENERATED from kernels/algos/comb_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void comb_sort_impl(int32_t *a, int64_t n);

static void comb_sort_impl(int32_t *a, int64_t n) {
    int64_t gap = 0;
    int64_t swapped = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    gap = n;
    swapped = 1;
    while (((gap > 1) || (swapped == 1))) {
        gap = ((gap * 10) / 13);
        if ((gap < 1)) {
            gap = 1;
        }
        swapped = 0;
        i = 0;
        while (((i + gap) < n)) {
            if ((((int64_t)a[i]) > ((int64_t)a[(i + gap)]))) {
                _i1 = i;
                _i2 = (i + gap);
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                swapped = 1;
            }
            i = (i + 1);
        }
    }
}

void comb_sort(int *arr, size_t n) {
    comb_sort_impl((int32_t *)arr, (int64_t)n);
}
