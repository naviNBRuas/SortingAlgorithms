/* GENERATED from kernels/algos/strand_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void strand_sort_impl(int32_t *a, int64_t n);

static void strand_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t left = 0;
    int64_t o = 0;
    int64_t s = 0;
    int64_t keep = 0;
    int64_t j = 0;
    int64_t k = 0;
    int64_t x = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int32_t *rem = NULL;
    int32_t *strand = NULL;
    int32_t *out = NULL;
    int32_t *tmp = NULL;
    if ((n < 2)) {
        {
            free(rem);
            free(strand);
            free(out);
            free(tmp);
            return;
        }
    }
    rem = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    strand = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    out = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    tmp = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        rem[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    left = n;
    o = 0;
    while ((left > 0)) {
        strand[0] = (int32_t)(((int64_t)rem[0]));
        s = 1;
        keep = 0;
        i = 1;
        _e2 = left;
        while ((i < _e2)) {
            if ((((int64_t)rem[i]) >= ((int64_t)strand[(s - 1)]))) {
                strand[s] = (int32_t)(((int64_t)rem[i]));
                s = (s + 1);
            } else {
                rem[keep] = (int32_t)(((int64_t)rem[i]));
                keep = (keep + 1);
            }
            i = (i + 1);
        }
        left = keep;
        i = 0;
        j = 0;
        k = 0;
        while (((i < o) && (j < s))) {
            if ((((int64_t)strand[j]) < ((int64_t)out[i]))) {
                tmp[k] = (int32_t)(((int64_t)strand[j]));
                j = (j + 1);
            } else {
                tmp[k] = (int32_t)(((int64_t)out[i]));
                i = (i + 1);
            }
            k = (k + 1);
        }
        while ((i < o)) {
            tmp[k] = (int32_t)(((int64_t)out[i]));
            i = (i + 1);
            k = (k + 1);
        }
        while ((j < s)) {
            tmp[k] = (int32_t)(((int64_t)strand[j]));
            j = (j + 1);
            k = (k + 1);
        }
        o = k;
        x = 0;
        _e3 = o;
        while ((x < _e3)) {
            out[x] = (int32_t)(((int64_t)tmp[x]));
            x = (x + 1);
        }
    }
    i = 0;
    _e4 = n;
    while ((i < _e4)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
    free(rem);
    free(strand);
    free(out);
    free(tmp);
}

void strand_sort(int *arr, size_t n) {
    strand_sort_impl((int32_t *)arr, (int64_t)n);
}
