/* GENERATED from kernels/algos/selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void selection_sort_impl(int32_t *a, int64_t n);

static void selection_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t m = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    i = 0;
    _e1 = (n - 1);
    while ((i < _e1)) {
        m = i;
        j = (i + 1);
        _e2 = n;
        while ((j < _e2)) {
            if ((((int64_t)a[j]) < ((int64_t)a[m]))) {
                m = j;
            }
            j = (j + 1);
        }
        if ((m != i)) {
            _i1 = i;
            _i2 = m;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        i = (i + 1);
    }
}

void selection_sort(int *arr, size_t n) {
    selection_sort_impl((int32_t *)arr, (int64_t)n);
}
