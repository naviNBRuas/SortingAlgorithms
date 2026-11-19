/* GENERATED from kernels/algos/merge_sort_bottom_up.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void merge_sort_bottom_up_impl(int32_t *a, int64_t n);

static void merge_sort_bottom_up_impl(int32_t *a, int64_t n) {
    int64_t width = 0;
    int64_t lo = 0;
    int64_t mid = 0;
    int64_t hi = 0;
    int64_t x = 0;
    int64_t i = 0;
    int64_t j = 0;
    int64_t k = 0;
    int64_t _e1 = 0;
    int32_t *tmp = NULL;
    tmp = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    width = 1;
    while ((width < n)) {
        lo = 0;
        while ((lo < n)) {
            mid = k_min((lo + width), n);
            hi = k_min((lo + (2 * width)), n);
            x = lo;
            _e1 = mid;
            while ((x < _e1)) {
                tmp[x] = (int32_t)(((int64_t)a[x]));
                x = (x + 1);
            }
            i = lo;
            j = mid;
            k = lo;
            while (((i < mid) && (j < hi))) {
                if ((((int64_t)a[j]) < ((int64_t)tmp[i]))) {
                    a[k] = (int32_t)(((int64_t)a[j]));
                    j = (j + 1);
                } else {
                    a[k] = (int32_t)(((int64_t)tmp[i]));
                    i = (i + 1);
                }
                k = (k + 1);
            }
            while ((i < mid)) {
                a[k] = (int32_t)(((int64_t)tmp[i]));
                i = (i + 1);
                k = (k + 1);
            }
            lo = (lo + (2 * width));
        }
        width = (width * 2);
    }
    free(tmp);
}

void merge_sort_bottom_up(int *arr, size_t n) {
    merge_sort_bottom_up_impl((int32_t *)arr, (int64_t)n);
}
