/* GENERATED from kernels/algos/odd_even_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void odd_even_sort_impl(int32_t *a, int64_t n);

static void odd_even_sort_impl(int32_t *a, int64_t n) {
    int64_t done = 0;
    int64_t start = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    done = 0;
    while ((done == 0)) {
        done = 1;
        start = 1;
        while ((start >= 0)) {
            i = start;
            while (((i + 1) < n)) {
                if ((((int64_t)a[i]) > ((int64_t)a[(i + 1)]))) {
                    _i1 = i;
                    _i2 = (i + 1);
                    _t1 = ((int64_t)a[_i1]);
                    a[_i1] = (int32_t)(((int64_t)a[_i2]));
                    a[_i2] = (int32_t)(_t1);
                    done = 0;
                }
                i = (i + 2);
            }
            start = (start - 1);
        }
    }
}

void odd_even_sort(int *arr, size_t n) {
    odd_even_sort_impl((int32_t *)arr, (int64_t)n);
}
