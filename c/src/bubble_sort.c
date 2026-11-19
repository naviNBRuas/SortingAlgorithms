/* GENERATED from kernels/algos/bubble_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void bubble_sort_impl(int32_t *a, int64_t n);

static void bubble_sort_impl(int32_t *a, int64_t n) {
    int64_t end = 0;
    int64_t swapped = 0;
    int64_t j = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    end = (n - 1);
    swapped = 1;
    while (((end > 0) && (swapped == 1))) {
        swapped = 0;
        j = 0;
        while ((j < end)) {
            if ((((int64_t)a[j]) > ((int64_t)a[(j + 1)]))) {
                _i1 = j;
                _i2 = (j + 1);
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                swapped = 1;
            }
            j = (j + 1);
        }
        end = (end - 1);
    }
}

void bubble_sort(int *arr, size_t n) {
    bubble_sort_impl((int32_t *)arr, (int64_t)n);
}
