/* GENERATED from kernels/algos/gnome_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void gnome_sort_impl(int32_t *a, int64_t n);

static void gnome_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    i = 0;
    while ((i < n)) {
        if (((i == 0) || (((int64_t)a[(i - 1)]) <= ((int64_t)a[i])))) {
            i = (i + 1);
        } else {
            _i1 = (i - 1);
            _i2 = i;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
            i = (i - 1);
        }
    }
}

void gnome_sort(int *arr, size_t n) {
    gnome_sort_impl((int32_t *)arr, (int64_t)n);
}
