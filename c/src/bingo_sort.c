/* GENERATED from kernels/algos/bingo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void bingo_sort_impl(int32_t *a, int64_t n);

static void bingo_sort_impl(int32_t *a, int64_t n) {
    int64_t mx = 0;
    int64_t nxt = 0;
    int64_t i = 0;
    int64_t bingo = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((n < 2)) {
        return;
    }
    mx = (n - 1);
    nxt = ((int64_t)a[mx]);
    i = (mx - 1);
    while ((i >= 0)) {
        if ((((int64_t)a[i]) > nxt)) {
            nxt = ((int64_t)a[i]);
        }
        i = (i - 1);
    }
    while (((mx > 0) && (((int64_t)a[mx]) == nxt))) {
        mx = (mx - 1);
    }
    while ((mx > 0)) {
        bingo = nxt;
        nxt = ((int64_t)a[mx]);
        i = (mx - 1);
        while ((i >= 0)) {
            if ((((int64_t)a[i]) == bingo)) {
                _i1 = i;
                _i2 = mx;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                mx = (mx - 1);
            } else {
                if ((((int64_t)a[i]) > nxt)) {
                    nxt = ((int64_t)a[i]);
                }
            }
            i = (i - 1);
        }
        while (((mx > 0) && (((int64_t)a[mx]) == nxt))) {
            mx = (mx - 1);
        }
    }
}

void bingo_sort(int *arr, size_t n) {
    bingo_sort_impl((int32_t *)arr, (int64_t)n);
}
