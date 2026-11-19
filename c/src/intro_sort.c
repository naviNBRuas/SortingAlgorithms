/* GENERATED from kernels/algos/intro_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void intro_sort_x_insertion(int32_t *a, int64_t lo, int64_t hi);
static void intro_sort_x_sift(int32_t *a, int64_t base, int64_t root, int64_t size);
static void intro_sort_x_heap(int32_t *a, int64_t lo, int64_t hi);
static void intro_sort_x_sort(int32_t *a, int64_t lo, int64_t hi, int64_t depth);
static void intro_sort_impl(int32_t *a, int64_t n);

static void intro_sort_x_insertion(int32_t *a, int64_t lo, int64_t hi) {
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    i = (lo + 1);
    _e1 = (hi + 1);
    while ((i < _e1)) {
        key = ((int64_t)a[i]);
        j = (i - 1);
        while (((j >= lo) && (((int64_t)a[j]) > key))) {
            a[(j + 1)] = (int32_t)(((int64_t)a[j]));
            j = (j - 1);
        }
        a[(j + 1)] = (int32_t)(key);
        i = (i + 1);
    }
}

static void intro_sort_x_sift(int32_t *a, int64_t base, int64_t root, int64_t size) {
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
            if ((((child + 1) < size) && (((int64_t)a[(base + child)]) < ((int64_t)a[((base + child) + 1)])))) {
                child = (child + 1);
            }
            if ((((int64_t)a[(base + root)]) < ((int64_t)a[(base + child)]))) {
                _i1 = (base + root);
                _i2 = (base + child);
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

static void intro_sort_x_heap(int32_t *a, int64_t lo, int64_t hi) {
    int64_t size = 0;
    int64_t s = 0;
    int64_t end = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    size = ((hi - lo) + 1);
    s = (size / 2);
    while ((s > 0)) {
        s = (s - 1);
        intro_sort_x_sift(a, lo, s, size);
    }
    end = (size - 1);
    while ((end > 0)) {
        _i1 = lo;
        _i2 = (lo + end);
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        intro_sort_x_sift(a, lo, 0, end);
        end = (end - 1);
    }
}

static void intro_sort_x_sort(int32_t *a, int64_t lo, int64_t hi, int64_t depth) {
    int64_t mid = 0;
    int64_t pivot = 0;
    int64_t i = 0;
    int64_t j = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    while ((((hi - lo) + 1) > 16)) {
        if ((depth == 0)) {
            intro_sort_x_heap(a, lo, hi);
            return;
        }
        depth = (depth - 1);
        mid = ((lo + hi) / 2);
        if ((((int64_t)a[mid]) < ((int64_t)a[lo]))) {
            _i1 = mid;
            _i2 = lo;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        if ((((int64_t)a[hi]) < ((int64_t)a[lo]))) {
            _i1 = hi;
            _i2 = lo;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        if ((((int64_t)a[hi]) < ((int64_t)a[mid]))) {
            _i1 = hi;
            _i2 = mid;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        pivot = ((int64_t)a[mid]);
        i = lo;
        j = hi;
        while ((i <= j)) {
            while ((((int64_t)a[i]) < pivot)) {
                i = (i + 1);
            }
            while ((((int64_t)a[j]) > pivot)) {
                j = (j - 1);
            }
            if ((i <= j)) {
                _i1 = i;
                _i2 = j;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                i = (i + 1);
                j = (j - 1);
            }
        }
        intro_sort_x_sort(a, lo, j, depth);
        lo = i;
    }
    intro_sort_x_insertion(a, lo, hi);
}

static void intro_sort_impl(int32_t *a, int64_t n) {
    int64_t depth = 0;
    int64_t t = 0;
    depth = 0;
    t = n;
    while ((t > 1)) {
        t = (t / 2);
        depth = (depth + 2);
    }
    intro_sort_x_sort(a, 0, (n - 1), depth);
}

void intro_sort(int *arr, size_t n) {
    intro_sort_impl((int32_t *)arr, (int64_t)n);
}
