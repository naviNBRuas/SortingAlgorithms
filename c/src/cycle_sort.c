/* GENERATED from kernels/algos/cycle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static int64_t cycle_sort_x_rank_of(int32_t *a, int64_t n, int64_t start, int64_t item);
static void cycle_sort_impl(int32_t *a, int64_t n);

static int64_t cycle_sort_x_rank_of(int32_t *a, int64_t n, int64_t start, int64_t item) {
    int64_t pos = 0;
    int64_t i = 0;
    int64_t _e1 = 0;
    pos = start;
    i = (start + 1);
    _e1 = n;
    while ((i < _e1)) {
        if ((((int64_t)a[i]) < item)) {
            pos = (pos + 1);
        }
        i = (i + 1);
    }
    return pos;
}

static void cycle_sort_impl(int32_t *a, int64_t n) {
    int64_t start = 0;
    int64_t item = 0;
    int64_t pos = 0;
    int64_t tmp = 0;
    int64_t _e1 = 0;
    start = 0;
    _e1 = (n - 1);
    while ((start < _e1)) {
        item = ((int64_t)a[start]);
        pos = cycle_sort_x_rank_of(a, n, start, item);
        if ((pos != start)) {
            while ((item == ((int64_t)a[pos]))) {
                pos = (pos + 1);
            }
            tmp = ((int64_t)a[pos]);
            a[pos] = (int32_t)(item);
            item = tmp;
            while ((pos != start)) {
                pos = cycle_sort_x_rank_of(a, n, start, item);
                while ((item == ((int64_t)a[pos]))) {
                    pos = (pos + 1);
                }
                tmp = ((int64_t)a[pos]);
                a[pos] = (int32_t)(item);
                item = tmp;
            }
        }
        start = (start + 1);
    }
}

void cycle_sort(int *arr, size_t n) {
    cycle_sort_impl((int32_t *)arr, (int64_t)n);
}
