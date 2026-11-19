/* GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void bottom_up_heap_sort_x_sift(int32_t *a, int64_t root, int64_t size);
static void bottom_up_heap_sort_impl(int32_t *a, int64_t n);

static void bottom_up_heap_sort_x_sift(int32_t *a, int64_t root, int64_t size) {
    int64_t j = 0;
    int64_t x = 0;
    int64_t cur = 0;
    int64_t c = 0;
    j = root;
    while ((((2 * j) + 2) < size)) {
        if ((((int64_t)a[((2 * j) + 1)]) < ((int64_t)a[((2 * j) + 2)]))) {
            j = ((2 * j) + 2);
        } else {
            j = ((2 * j) + 1);
        }
    }
    if ((((2 * j) + 1) < size)) {
        j = ((2 * j) + 1);
    }
    x = ((int64_t)a[root]);
    while ((((int64_t)a[j]) < x)) {
        j = ((j - 1) / 2);
    }
    cur = root;
    while ((cur != j)) {
        c = j;
        while ((((c - 1) / 2) != cur)) {
            c = ((c - 1) / 2);
        }
        a[cur] = (int32_t)(((int64_t)a[c]));
        cur = c;
    }
    a[j] = (int32_t)(x);
}

static void bottom_up_heap_sort_impl(int32_t *a, int64_t n) {
    int64_t s = 0;
    int64_t end = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    s = (n / 2);
    while ((s > 0)) {
        s = (s - 1);
        bottom_up_heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while ((end > 0)) {
        _i1 = 0;
        _i2 = end;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        bottom_up_heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

void bottom_up_heap_sort(int *arr, size_t n) {
    bottom_up_heap_sort_impl((int32_t *)arr, (int64_t)n);
}
