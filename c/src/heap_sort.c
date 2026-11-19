/* GENERATED from kernels/algos/heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void heap_sort_x_sift(int32_t *a, int64_t root, int64_t size);
static void heap_sort_impl(int32_t *a, int64_t n);

static void heap_sort_x_sift(int32_t *a, int64_t root, int64_t size) {
    int64_t going = 0;
    int64_t child = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    going = 1;
    while ((going == 1)) {
        child = ((2 * root) + 1);
        if ((child >= size)) {
            going = 0;
        } else {
            if ((((child + 1) < size) && (((int64_t)a[child]) < ((int64_t)a[(child + 1)])))) {
                child = (child + 1);
            }
            if ((((int64_t)a[root]) < ((int64_t)a[child]))) {
                _i1 = root;
                _i2 = child;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                root = child;
            } else {
                going = 0;
            }
        }
    }
}

static void heap_sort_impl(int32_t *a, int64_t n) {
    int64_t s = 0;
    int64_t end = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    s = (n / 2);
    while ((s > 0)) {
        s = (s - 1);
        heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while ((end > 0)) {
        _i1 = 0;
        _i2 = end;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

void heap_sort(int *arr, size_t n) {
    heap_sort_impl((int32_t *)arr, (int64_t)n);
}
