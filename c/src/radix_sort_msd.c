/* GENERATED from kernels/algos/radix_sort_msd.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void radix_sort_msd_x_rec(int32_t *a, int32_t *tmp, int64_t mn, int64_t lo, int64_t hi, int64_t exp);
static void radix_sort_msd_impl(int32_t *a, int64_t n);

static void radix_sort_msd_x_rec(int32_t *a, int32_t *tmp, int64_t mn, int64_t lo, int64_t hi, int64_t exp) {
    int64_t i = 0;
    int64_t d = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    int32_t *count = NULL;
    int32_t *start = NULL;
    if ((((hi - lo) < 2) || (exp == 0))) {
        {
            free(count);
            free(start);
            return;
        }
    }
    count = (int32_t *)calloc((size_t)k_max(1, 11), sizeof(int32_t));
    i = lo;
    _e1 = hi;
    while ((i < _e1)) {
        count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)] = (int32_t)((((int64_t)count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)]) + 1));
        i = (i + 1);
    }
    d = 1;
    _e2 = 11;
    while ((d < _e2)) {
        count[d] = (int32_t)((((int64_t)count[d]) + ((int64_t)count[(d - 1)])));
        d = (d + 1);
    }
    start = (int32_t *)calloc((size_t)k_max(1, 11), sizeof(int32_t));
    d = 0;
    _e3 = 11;
    while ((d < _e3)) {
        start[d] = (int32_t)(((int64_t)count[d]));
        d = (d + 1);
    }
    i = lo;
    _e4 = hi;
    while ((i < _e4)) {
        d = (((((int64_t)a[i]) - mn) / exp) % 10);
        tmp[(lo + ((int64_t)count[d]))] = (int32_t)(((int64_t)a[i]));
        count[d] = (int32_t)((((int64_t)count[d]) + 1));
        i = (i + 1);
    }
    i = lo;
    _e5 = hi;
    while ((i < _e5)) {
        a[i] = (int32_t)(((int64_t)tmp[i]));
        i = (i + 1);
    }
    d = 0;
    _e6 = 10;
    while ((d < _e6)) {
        radix_sort_msd_x_rec(a, tmp, mn, (lo + ((int64_t)start[d])), (lo + ((int64_t)start[(d + 1)])), (exp / 10));
        d = (d + 1);
    }
    free(count);
    free(start);
}

static void radix_sort_msd_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t top = 0;
    int64_t _e1 = 0;
    int32_t *tmp = NULL;
    if ((n < 2)) {
        {
            free(tmp);
            return;
        }
    }
    mn = ((int64_t)a[0]);
    mx = ((int64_t)a[0]);
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        if ((((int64_t)a[i]) < mn)) {
            mn = ((int64_t)a[i]);
        }
        if ((((int64_t)a[i]) > mx)) {
            mx = ((int64_t)a[i]);
        }
        i = (i + 1);
    }
    tmp = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    top = 1;
    while ((((mx - mn) / top) >= 10)) {
        top = (top * 10);
    }
    radix_sort_msd_x_rec(a, tmp, mn, 0, n, top);
    free(tmp);
}

void radix_sort_msd(int *arr, size_t n) {
    radix_sort_msd_impl((int32_t *)arr, (int64_t)n);
}
