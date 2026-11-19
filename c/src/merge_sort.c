/* GENERATED from kernels/algos/merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void merge_sort_x_rec(int32_t *a, int32_t *tmp, int64_t lo, int64_t hi);
static void merge_sort_impl(int32_t *a, int64_t n);

static void merge_sort_x_rec(int32_t *a, int32_t *tmp, int64_t lo, int64_t hi) {
    int64_t mid = 0;
    int64_t x = 0;
    int64_t i = 0;
    int64_t j = 0;
    int64_t k = 0;
    int64_t _e1 = 0;
    if (((hi - lo) < 2)) {
        return;
    }
    mid = ((lo + hi) / 2);
    merge_sort_x_rec(a, tmp, lo, mid);
    merge_sort_x_rec(a, tmp, mid, hi);
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
}

static void merge_sort_impl(int32_t *a, int64_t n) {
    int32_t *tmp = NULL;
    tmp = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    merge_sort_x_rec(a, tmp, 0, n);
    free(tmp);
}

void merge_sort(int *arr, size_t n) {
    merge_sort_impl((int32_t *)arr, (int64_t)n);
}
