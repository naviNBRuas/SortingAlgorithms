/* GENERATED from kernels/algos/radix_sort_lsd.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void radix_sort_lsd_impl(int32_t *a, int64_t n);

static void radix_sort_lsd_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t exp = 0;
    int64_t d = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    int32_t *out = NULL;
    int32_t *count = NULL;
    if ((n < 2)) {
        {
            free(out);
            free(count);
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
    out = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    count = (int32_t *)calloc((size_t)k_max(1, 11), sizeof(int32_t));
    exp = 1;
    while ((((mx - mn) / exp) > 0)) {
        d = 0;
        _e2 = 11;
        while ((d < _e2)) {
            count[d] = (int32_t)(0);
            d = (d + 1);
        }
        i = 0;
        _e3 = n;
        while ((i < _e3)) {
            count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)] = (int32_t)((((int64_t)count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)]) + 1));
            i = (i + 1);
        }
        d = 1;
        _e4 = 11;
        while ((d < _e4)) {
            count[d] = (int32_t)((((int64_t)count[d]) + ((int64_t)count[(d - 1)])));
            d = (d + 1);
        }
        i = 0;
        _e5 = n;
        while ((i < _e5)) {
            d = (((((int64_t)a[i]) - mn) / exp) % 10);
            out[((int64_t)count[d])] = (int32_t)(((int64_t)a[i]));
            count[d] = (int32_t)((((int64_t)count[d]) + 1));
            i = (i + 1);
        }
        i = 0;
        _e6 = n;
        while ((i < _e6)) {
            a[i] = (int32_t)(((int64_t)out[i]));
            i = (i + 1);
        }
        exp = (exp * 10);
    }
    free(out);
    free(count);
}

void radix_sort_lsd(int *arr, size_t n) {
    radix_sort_lsd_impl((int32_t *)arr, (int64_t)n);
}
