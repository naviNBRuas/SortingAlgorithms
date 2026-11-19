/* GENERATED from kernels/algos/bitonic_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void bitonic_sort_x_cmp_swap(int32_t *a, int64_t i, int64_t j);
static void bitonic_sort_impl(int32_t *a, int64_t n);

static void bitonic_sort_x_cmp_swap(int32_t *a, int64_t i, int64_t j) {
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((((int64_t)a[i]) > ((int64_t)a[j]))) {
        _i1 = i;
        _i2 = j;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
    }
}

static void bitonic_sort_impl(int32_t *a, int64_t n) {
    int64_t size = 0;
    int64_t k = 0;
    int64_t blk = 0;
    int64_t t = 0;
    int64_t j = 0;
    int64_t i = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    size = 1;
    while ((size < n)) {
        size = (size * 2);
    }
    k = 2;
    while ((k <= size)) {
        blk = 0;
        while ((blk < size)) {
            t = 0;
            _e1 = (k / 2);
            while ((t < _e1)) {
                j = (((blk + k) - 1) - t);
                if ((j < n)) {
                    bitonic_sort_x_cmp_swap(a, (blk + t), j);
                }
                t = (t + 1);
            }
            blk = (blk + k);
        }
        j = (k / 4);
        while ((j >= 1)) {
            i = 0;
            _e2 = size;
            while ((i < _e2)) {
                if (((((i / j) % 2) == 0) && ((i + j) < n))) {
                    bitonic_sort_x_cmp_swap(a, i, (i + j));
                }
                i = (i + 1);
            }
            j = (j / 2);
        }
        k = (k * 2);
    }
}

void bitonic_sort(int *arr, size_t n) {
    bitonic_sort_impl((int32_t *)arr, (int64_t)n);
}
