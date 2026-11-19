/* GENERATED from kernels/algos/counting_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void counting_sort_x_fallback(int32_t *a, int64_t n);
static void counting_sort_impl(int32_t *a, int64_t n);

static void counting_sort_x_fallback(int32_t *a, int64_t n) {
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

static void counting_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t rng = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int32_t *count = NULL;
    int32_t *out = NULL;
    if ((n < 2)) {
        {
            free(count);
            free(out);
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
    rng = ((mx - mn) + 1);
    if ((rng > 4000000)) {
        counting_sort_x_fallback(a, n);
        {
            free(count);
            free(out);
            return;
        }
    }
    count = (int32_t *)calloc((size_t)k_max(1, (rng + 1)), sizeof(int32_t));
    out = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        count[((((int64_t)a[i]) - mn) + 1)] = (int32_t)((((int64_t)count[((((int64_t)a[i]) - mn) + 1)]) + 1));
        i = (i + 1);
    }
    i = 1;
    _e3 = (rng + 1);
    while ((i < _e3)) {
        count[i] = (int32_t)((((int64_t)count[i]) + ((int64_t)count[(i - 1)])));
        i = (i + 1);
    }
    i = 0;
    _e4 = n;
    while ((i < _e4)) {
        out[((int64_t)count[(((int64_t)a[i]) - mn)])] = (int32_t)(((int64_t)a[i]));
        count[(((int64_t)a[i]) - mn)] = (int32_t)((((int64_t)count[(((int64_t)a[i]) - mn)]) + 1));
        i = (i + 1);
    }
    i = 0;
    _e5 = n;
    while ((i < _e5)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
    free(count);
    free(out);
}

void counting_sort(int *arr, size_t n) {
    counting_sort_impl((int32_t *)arr, (int64_t)n);
}
