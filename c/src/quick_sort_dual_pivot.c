/* GENERATED from kernels/algos/quick_sort_dual_pivot.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void quick_sort_dual_pivot_x_qs(int32_t *a, int64_t lo, int64_t hi);
static void quick_sort_dual_pivot_impl(int32_t *a, int64_t n);

static void quick_sort_dual_pivot_x_qs(int32_t *a, int64_t lo, int64_t hi) {
    int64_t p = 0;
    int64_t q = 0;
    int64_t lt = 0;
    int64_t gt = 0;
    int64_t k = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    while ((lo < hi)) {
        if ((((int64_t)a[lo]) > ((int64_t)a[hi]))) {
            _i1 = lo;
            _i2 = hi;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        p = ((int64_t)a[lo]);
        q = ((int64_t)a[hi]);
        lt = (lo + 1);
        gt = (hi - 1);
        k = (lo + 1);
        while ((k <= gt)) {
            if ((((int64_t)a[k]) < p)) {
                _i1 = k;
                _i2 = lt;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                lt = (lt + 1);
            } else {
                if ((((int64_t)a[k]) > q)) {
                    while (((k < gt) && (((int64_t)a[gt]) > q))) {
                        gt = (gt - 1);
                    }
                    _i1 = k;
                    _i2 = gt;
                    _t1 = ((int64_t)a[_i1]);
                    a[_i1] = (int32_t)(((int64_t)a[_i2]));
                    a[_i2] = (int32_t)(_t1);
                    gt = (gt - 1);
                    if ((((int64_t)a[k]) < p)) {
                        _i1 = k;
                        _i2 = lt;
                        _t1 = ((int64_t)a[_i1]);
                        a[_i1] = (int32_t)(((int64_t)a[_i2]));
                        a[_i2] = (int32_t)(_t1);
                        lt = (lt + 1);
                    }
                }
            }
            k = (k + 1);
        }
        lt = (lt - 1);
        gt = (gt + 1);
        _i1 = lo;
        _i2 = lt;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        _i1 = hi;
        _i2 = gt;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        quick_sort_dual_pivot_x_qs(a, lo, (lt - 1));
        quick_sort_dual_pivot_x_qs(a, (gt + 1), hi);
        lo = (lt + 1);
        hi = (gt - 1);
    }
}

static void quick_sort_dual_pivot_impl(int32_t *a, int64_t n) {
    quick_sort_dual_pivot_x_qs(a, 0, (n - 1));
}

void quick_sort_dual_pivot(int *arr, size_t n) {
    quick_sort_dual_pivot_impl((int32_t *)arr, (int64_t)n);
}
