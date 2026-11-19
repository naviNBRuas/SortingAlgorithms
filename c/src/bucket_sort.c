/* GENERATED from kernels/algos/bucket_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void bucket_sort_impl(int32_t *a, int64_t n);

static void bucket_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t rng = 0;
    int64_t b = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    int64_t _e7 = 0;
    int64_t _e8 = 0;
    int32_t *count = NULL;
    int32_t *out = NULL;
    int32_t *start = NULL;
    if ((n < 2)) {
        {
            free(count);
            free(out);
            free(start);
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
    rng = (mx - mn);
    if ((rng == 0)) {
        {
            free(count);
            free(out);
            free(start);
            return;
        }
    }
    count = (int32_t *)calloc((size_t)k_max(1, (n + 1)), sizeof(int32_t));
    out = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        count[((((((int64_t)a[i]) - mn) * (n - 1)) / rng) + 1)] = (int32_t)((((int64_t)count[((((((int64_t)a[i]) - mn) * (n - 1)) / rng) + 1)]) + 1));
        i = (i + 1);
    }
    b = 1;
    _e3 = (n + 1);
    while ((b < _e3)) {
        count[b] = (int32_t)((((int64_t)count[b]) + ((int64_t)count[(b - 1)])));
        b = (b + 1);
    }
    start = (int32_t *)calloc((size_t)k_max(1, (n + 1)), sizeof(int32_t));
    b = 0;
    _e4 = (n + 1);
    while ((b < _e4)) {
        start[b] = (int32_t)(((int64_t)count[b]));
        b = (b + 1);
    }
    i = 0;
    _e5 = n;
    while ((i < _e5)) {
        b = (((((int64_t)a[i]) - mn) * (n - 1)) / rng);
        out[((int64_t)count[b])] = (int32_t)(((int64_t)a[i]));
        count[b] = (int32_t)((((int64_t)count[b]) + 1));
        i = (i + 1);
    }
    b = 0;
    _e6 = n;
    while ((b < _e6)) {
        lo = ((int64_t)start[b]);
        hi = ((int64_t)start[(b + 1)]);
        i = (lo + 1);
        _e7 = hi;
        while ((i < _e7)) {
            key = ((int64_t)out[i]);
            j = (i - 1);
            while (((j >= lo) && (((int64_t)out[j]) > key))) {
                out[(j + 1)] = (int32_t)(((int64_t)out[j]));
                j = (j - 1);
            }
            out[(j + 1)] = (int32_t)(key);
            i = (i + 1);
        }
        b = (b + 1);
    }
    i = 0;
    _e8 = n;
    while ((i < _e8)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
    free(count);
    free(out);
    free(start);
}

void bucket_sort(int *arr, size_t n) {
    bucket_sort_impl((int32_t *)arr, (int64_t)n);
}
