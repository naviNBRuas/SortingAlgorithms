/* GENERATED from kernels/algos/weak_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static int64_t weak_heap_sort_x_gparent(int32_t *r, int64_t j);
static void weak_heap_sort_x_join(int32_t *a, int32_t *r, int64_t i, int64_t j);
static void weak_heap_sort_impl(int32_t *a, int64_t n);

static int64_t weak_heap_sort_x_gparent(int32_t *r, int64_t j) {
    while (((j % 2) == ((int64_t)r[(j / 2)]))) {
        j = (j / 2);
    }
    return (j / 2);
}

static void weak_heap_sort_x_join(int32_t *a, int32_t *r, int64_t i, int64_t j) {
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((((int64_t)a[i]) < ((int64_t)a[j]))) {
        _i1 = i;
        _i2 = j;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        r[j] = (int32_t)((1 - ((int64_t)r[j])));
    }
}

static void weak_heap_sort_impl(int32_t *a, int64_t n) {
    int64_t j = 0;
    int64_t g = 0;
    int64_t m = 0;
    int64_t x = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    int32_t *r = NULL;
    if ((n < 2)) {
        {
            free(r);
            return;
        }
    }
    r = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    j = (n - 1);
    while ((j > 0)) {
        g = weak_heap_sort_x_gparent(r, j);
        weak_heap_sort_x_join(a, r, g, j);
        j = (j - 1);
    }
    m = (n - 1);
    while ((m > 1)) {
        _i1 = 0;
        _i2 = m;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        x = 1;
        while ((((2 * x) + ((int64_t)r[x])) < m)) {
            x = ((2 * x) + ((int64_t)r[x]));
        }
        while ((x > 0)) {
            weak_heap_sort_x_join(a, r, 0, x);
            x = (x / 2);
        }
        m = (m - 1);
    }
    _i1 = 0;
    _i2 = 1;
    _t1 = ((int64_t)a[_i1]);
    a[_i1] = (int32_t)(((int64_t)a[_i2]));
    a[_i2] = (int32_t)(_t1);
    free(r);
}

void weak_heap_sort(int *arr, size_t n) {
    weak_heap_sort_impl((int32_t *)arr, (int64_t)n);
}
