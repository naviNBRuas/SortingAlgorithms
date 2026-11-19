/* GENERATED from kernels/algos/quick_sort_3way.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void quick_sort_3way_x_qs(int32_t *a, int64_t lo, int64_t hi);
static void quick_sort_3way_impl(int32_t *a, int64_t n);

static void quick_sort_3way_x_qs(int32_t *a, int64_t lo, int64_t hi) {
    int64_t pivot = 0;
    int64_t lt = 0;
    int64_t i = 0;
    int64_t gt = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    while ((lo < hi)) {
        pivot = ((int64_t)a[((lo + hi) / 2)]);
        lt = lo;
        i = lo;
        gt = hi;
        while ((i <= gt)) {
            if ((((int64_t)a[i]) < pivot)) {
                _i1 = lt;
                _i2 = i;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                lt = (lt + 1);
                i = (i + 1);
            } else {
                if ((((int64_t)a[i]) > pivot)) {
                    _i1 = i;
                    _i2 = gt;
                    _t1 = ((int64_t)a[_i1]);
                    a[_i1] = (int32_t)(((int64_t)a[_i2]));
                    a[_i2] = (int32_t)(_t1);
                    gt = (gt - 1);
                } else {
                    i = (i + 1);
                }
            }
        }
        if (((lt - lo) < (hi - gt))) {
            quick_sort_3way_x_qs(a, lo, (lt - 1));
            lo = (gt + 1);
        } else {
            quick_sort_3way_x_qs(a, (gt + 1), hi);
            hi = (lt - 1);
        }
    }
}

static void quick_sort_3way_impl(int32_t *a, int64_t n) {
    quick_sort_3way_x_qs(a, 0, (n - 1));
}

void quick_sort_3way(int *arr, size_t n) {
    quick_sort_3way_impl((int32_t *)arr, (int64_t)n);
}
