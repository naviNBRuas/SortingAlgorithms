/* GENERATED from kernels/algos/permutation_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void permutation_sort_impl(int32_t *a, int64_t n);

static void permutation_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t found = 0;
    int64_t ok = 0;
    int64_t j = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    int32_t *vals = NULL;
    int32_t *idx = NULL;
    vals = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    idx = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        idx[i] = (int32_t)(i);
        i = (i + 1);
    }
    found = 0;
    while ((found == 0)) {
        ok = 1;
        i = 0;
        _e2 = (n - 1);
        while ((i < _e2)) {
            if ((((int64_t)vals[((int64_t)idx[(i + 1)])]) < ((int64_t)vals[((int64_t)idx[i])]))) {
                ok = 0;
            }
            i = (i + 1);
        }
        if ((ok == 1)) {
            found = 1;
        } else {
            i = (n - 2);
            while (((i >= 0) && (((int64_t)idx[i]) > ((int64_t)idx[(i + 1)])))) {
                i = (i - 1);
            }
            if ((i < 0)) {
                found = 1;
            } else {
                j = (n - 1);
                while ((((int64_t)idx[j]) < ((int64_t)idx[i]))) {
                    j = (j - 1);
                }
                _i1 = i;
                _i2 = j;
                _t1 = ((int64_t)idx[_i1]);
                idx[_i1] = (int32_t)(((int64_t)idx[_i2]));
                idx[_i2] = (int32_t)(_t1);
                lo = (i + 1);
                hi = (n - 1);
                while ((lo < hi)) {
                    _i1 = lo;
                    _i2 = hi;
                    _t1 = ((int64_t)idx[_i1]);
                    idx[_i1] = (int32_t)(((int64_t)idx[_i2]));
                    idx[_i2] = (int32_t)(_t1);
                    lo = (lo + 1);
                    hi = (hi - 1);
                }
            }
        }
    }
    i = 0;
    _e3 = n;
    while ((i < _e3)) {
        a[i] = (int32_t)(((int64_t)vals[((int64_t)idx[i])]));
        i = (i + 1);
    }
    free(vals);
    free(idx);
}

void permutation_sort(int *arr, size_t n) {
    permutation_sort_impl((int32_t *)arr, (int64_t)n);
}
