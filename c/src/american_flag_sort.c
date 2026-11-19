/* GENERATED from kernels/algos/american_flag_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void american_flag_sort_x_rec(int32_t *a, int64_t mn, int64_t lo, int64_t hi, int64_t exp);
static void american_flag_sort_impl(int32_t *a, int64_t n);

static void american_flag_sort_x_rec(int32_t *a, int64_t mn, int64_t lo, int64_t hi, int64_t exp) {
    int64_t i = 0;
    int64_t s = 0;
    int64_t d = 0;
    int64_t b = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    int32_t *count = NULL;
    int32_t *starts = NULL;
    int32_t *nxt = NULL;
    if ((((hi - lo) < 2) || (exp == 0))) {
        {
            free(count);
            free(starts);
            free(nxt);
            return;
        }
    }
    count = (int32_t *)calloc((size_t)k_max(1, 10), sizeof(int32_t));
    starts = (int32_t *)calloc((size_t)k_max(1, 11), sizeof(int32_t));
    nxt = (int32_t *)calloc((size_t)k_max(1, 10), sizeof(int32_t));
    i = lo;
    _e1 = hi;
    while ((i < _e1)) {
        count[(((((int64_t)a[i]) - mn) / exp) % 10)] = (int32_t)((((int64_t)count[(((((int64_t)a[i]) - mn) / exp) % 10)]) + 1));
        i = (i + 1);
    }
    s = lo;
    d = 0;
    _e2 = 10;
    while ((d < _e2)) {
        starts[d] = (int32_t)(s);
        nxt[d] = (int32_t)(s);
        s = (s + ((int64_t)count[d]));
        d = (d + 1);
    }
    starts[10] = (int32_t)(s);
    b = 0;
    _e3 = 10;
    while ((b < _e3)) {
        while ((((int64_t)nxt[b]) < ((int64_t)starts[(b + 1)]))) {
            d = (((((int64_t)a[((int64_t)nxt[b])]) - mn) / exp) % 10);
            if ((d == b)) {
                nxt[b] = (int32_t)((((int64_t)nxt[b]) + 1));
            } else {
                _i1 = ((int64_t)nxt[b]);
                _i2 = ((int64_t)nxt[d]);
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                nxt[d] = (int32_t)((((int64_t)nxt[d]) + 1));
            }
        }
        b = (b + 1);
    }
    b = 0;
    _e4 = 10;
    while ((b < _e4)) {
        american_flag_sort_x_rec(a, mn, ((int64_t)starts[b]), ((int64_t)starts[(b + 1)]), (exp / 10));
        b = (b + 1);
    }
    free(count);
    free(starts);
    free(nxt);
}

static void american_flag_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t top = 0;
    int64_t _e1 = 0;
    if ((n < 2)) {
        return;
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
    top = 1;
    while ((((mx - mn) / top) >= 10)) {
        top = (top * 10);
    }
    american_flag_sort_x_rec(a, mn, 0, n, top);
}

void american_flag_sort(int *arr, size_t n) {
    american_flag_sort_impl((int32_t *)arr, (int64_t)n);
}
