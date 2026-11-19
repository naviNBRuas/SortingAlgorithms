/* GENERATED from kernels/algos/bozo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static int64_t bozo_sort_x_is_sorted(int32_t *a, int64_t n);
static void bozo_sort_impl(int32_t *a, int64_t n, int64_t max_swaps);

static int64_t bozo_sort_x_is_sorted(int32_t *a, int64_t n) {
    int64_t i = 0;
    i = 0;
    while (((i + 1) < n)) {
        if ((((int64_t)a[i]) > ((int64_t)a[(i + 1)]))) {
            return 0;
        }
        i = (i + 1);
    }
    return 1;
}

static void bozo_sort_impl(int32_t *a, int64_t n, int64_t max_swaps) {
    int64_t state = 0;
    int64_t count = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    state = 987654321;
    count = 0;
    while (((bozo_sort_x_is_sorted(a, n) == 0) && (count < max_swaps))) {
        state = (((state * 1103515245) + 12345) % 2147483648LL);
        i = ((state / 16) % n);
        state = (((state * 1103515245) + 12345) % 2147483648LL);
        _i1 = i;
        _i2 = ((state / 16) % n);
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        count = (count + 1);
    }
}

void bozo_sort(int *arr, size_t n, size_t max_swaps) {
    bozo_sort_impl((int32_t *)arr, (int64_t)n, (int64_t)max_swaps);
}
