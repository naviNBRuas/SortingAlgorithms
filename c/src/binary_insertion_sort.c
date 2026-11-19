/* GENERATED from kernels/algos/binary_insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void binary_insertion_sort_impl(int32_t *a, int64_t n);

static void binary_insertion_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t key = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t mid = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        key = ((int64_t)a[i]);
        lo = 0;
        hi = i;
        while ((lo < hi)) {
            mid = ((lo + hi) / 2);
            if ((key < ((int64_t)a[mid]))) {
                hi = mid;
            } else {
                lo = (mid + 1);
            }
        }
        j = i;
        while ((j > lo)) {
            a[j] = (int32_t)(((int64_t)a[(j - 1)]));
            j = (j - 1);
        }
        a[lo] = (int32_t)(key);
        i = (i + 1);
    }
}

void binary_insertion_sort(int *arr, size_t n) {
    binary_insertion_sort_impl((int32_t *)arr, (int64_t)n);
}
