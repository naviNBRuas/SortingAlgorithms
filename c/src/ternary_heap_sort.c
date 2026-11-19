/* GENERATED from kernels/algos/ternary_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void ternary_heap_sort_x_sift(int32_t *a, int64_t root, int64_t size);
static void ternary_heap_sort_impl(int32_t *a, int64_t n);

static void ternary_heap_sort_x_sift(int32_t *a, int64_t root, int64_t size) {
    int64_t going = 0;
    int64_t first = 0;
    int64_t best = 0;
    int64_t c = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    going = 1;
    while ((going == 1)) {
        first = ((3 * root) + 1);
        if ((first >= size)) {
            going = 0;
        } else {
            best = first;
            c = (first + 1);
            while (((c < (first + 3)) && (c < size))) {
                if ((((int64_t)a[best]) < ((int64_t)a[c]))) {
                    best = c;
                }
                c = (c + 1);
            }
            if ((((int64_t)a[root]) < ((int64_t)a[best]))) {
                _i1 = root;
                _i2 = best;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                root = best;
            } else {
                going = 0;
            }
        }
    }
}

static void ternary_heap_sort_impl(int32_t *a, int64_t n) {
    int64_t s = 0;
    int64_t end = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((n < 2)) {
        return;
    }
    s = (((n - 2) / 3) + 1);
    while ((s > 0)) {
        s = (s - 1);
        ternary_heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while ((end > 0)) {
        _i1 = 0;
        _i2 = end;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        ternary_heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

void ternary_heap_sort(int *arr, size_t n) {
    ternary_heap_sort_impl((int32_t *)arr, (int64_t)n);
}
