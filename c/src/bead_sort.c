/* GENERATED from kernels/algos/bead_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void bead_sort_x_fallback(int32_t *a, int64_t n);
static void bead_sort_impl(int32_t *a, int64_t n);

static void bead_sort_x_fallback(int32_t *a, int64_t n) {
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

static void bead_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t maxv = 0;
    int64_t r = 0;
    int64_t level = 0;
    int64_t k = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int32_t *ge = NULL;
    int32_t *rods = NULL;
    if ((n < 2)) {
        {
            free(ge);
            free(rods);
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
    maxv = (mx - mn);
    if ((maxv > 20000)) {
        bead_sort_x_fallback(a, n);
        {
            free(ge);
            free(rods);
            return;
        }
    }
    ge = (int32_t *)calloc((size_t)k_max(1, (maxv + 2)), sizeof(int32_t));
    rods = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        ge[(((int64_t)a[i]) - mn)] = (int32_t)((((int64_t)ge[(((int64_t)a[i]) - mn)]) + 1));
        i = (i + 1);
    }
    r = maxv;
    while ((r > 0)) {
        r = (r - 1);
        ge[r] = (int32_t)((((int64_t)ge[r]) + ((int64_t)ge[(r + 1)])));
    }
    level = 1;
    _e3 = (maxv + 1);
    while ((level < _e3)) {
        k = 0;
        _e4 = ((int64_t)ge[level]);
        while ((k < _e4)) {
            rods[((n - 1) - k)] = (int32_t)((((int64_t)rods[((n - 1) - k)]) + 1));
            k = (k + 1);
        }
        level = (level + 1);
    }
    i = 0;
    _e5 = n;
    while ((i < _e5)) {
        a[i] = (int32_t)((((int64_t)rods[i]) + mn));
        i = (i + 1);
    }
    free(ge);
    free(rods);
}

void bead_sort(int *arr, size_t n) {
    bead_sort_impl((int32_t *)arr, (int64_t)n);
}
