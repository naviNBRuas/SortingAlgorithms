/* GENERATED from kernels/algos/cartesian_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void cartesian_tree_sort_x_sift_up(int32_t *vals, int32_t *heap, int64_t i);
static void cartesian_tree_sort_x_sift_down(int32_t *vals, int32_t *heap, int64_t size, int64_t i);
static void cartesian_tree_sort_impl(int32_t *a, int64_t n);

static void cartesian_tree_sort_x_sift_up(int32_t *vals, int32_t *heap, int64_t i) {
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    while (((i > 0) && (((int64_t)vals[((int64_t)heap[i])]) < ((int64_t)vals[((int64_t)heap[((i - 1) / 2)])])))) {
        _i1 = i;
        _i2 = ((i - 1) / 2);
        _t1 = ((int64_t)heap[_i1]);
        heap[_i1] = (int32_t)(((int64_t)heap[_i2]));
        heap[_i2] = (int32_t)(_t1);
        i = ((i - 1) / 2);
    }
}

static void cartesian_tree_sort_x_sift_down(int32_t *vals, int32_t *heap, int64_t size, int64_t i) {
    int64_t going = 0;
    int64_t c = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    going = 1;
    while ((going == 1)) {
        c = ((2 * i) + 1);
        if ((c >= size)) {
            going = 0;
        } else {
            if ((((c + 1) < size) && (((int64_t)vals[((int64_t)heap[(c + 1)])]) < ((int64_t)vals[((int64_t)heap[c])])))) {
                c = (c + 1);
            }
            if ((((int64_t)vals[((int64_t)heap[c])]) < ((int64_t)vals[((int64_t)heap[i])]))) {
                _i1 = i;
                _i2 = c;
                _t1 = ((int64_t)heap[_i1]);
                heap[_i1] = (int32_t)(((int64_t)heap[_i2]));
                heap[_i2] = (int32_t)(_t1);
                i = c;
            } else {
                going = 0;
            }
        }
    }
}

static void cartesian_tree_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t sp = 0;
    int64_t last = 0;
    int64_t size = 0;
    int64_t out = 0;
    int64_t node = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int32_t *vals = NULL;
    int32_t *left = NULL;
    int32_t *right = NULL;
    int32_t *stack = NULL;
    int32_t *heap = NULL;
    if ((n < 2)) {
        {
            free(vals);
            free(left);
            free(right);
            free(stack);
            free(heap);
            return;
        }
    }
    vals = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    left = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    right = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    stack = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    heap = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        left[i] = (int32_t)((-1));
        right[i] = (int32_t)((-1));
        i = (i + 1);
    }
    sp = 0;
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        last = (-1);
        while (((sp > 0) && (((int64_t)vals[i]) < ((int64_t)vals[((int64_t)stack[(sp - 1)])])))) {
            sp = (sp - 1);
            last = ((int64_t)stack[sp]);
        }
        left[i] = (int32_t)(last);
        if ((sp > 0)) {
            right[((int64_t)stack[(sp - 1)])] = (int32_t)(i);
        }
        stack[sp] = (int32_t)(i);
        sp = (sp + 1);
        i = (i + 1);
    }
    heap[0] = (int32_t)(((int64_t)stack[0]));
    size = 1;
    out = 0;
    _e3 = n;
    while ((out < _e3)) {
        node = ((int64_t)heap[0]);
        size = (size - 1);
        heap[0] = (int32_t)(((int64_t)heap[size]));
        cartesian_tree_sort_x_sift_down(vals, heap, size, 0);
        a[out] = (int32_t)(((int64_t)vals[node]));
        if ((((int64_t)left[node]) >= 0)) {
            heap[size] = (int32_t)(((int64_t)left[node]));
            size = (size + 1);
            cartesian_tree_sort_x_sift_up(vals, heap, (size - 1));
        }
        if ((((int64_t)right[node]) >= 0)) {
            heap[size] = (int32_t)(((int64_t)right[node]));
            size = (size + 1);
            cartesian_tree_sort_x_sift_up(vals, heap, (size - 1));
        }
        out = (out + 1);
    }
    free(vals);
    free(left);
    free(right);
    free(stack);
    free(heap);
}

void cartesian_tree_sort(int *arr, size_t n) {
    cartesian_tree_sort_impl((int32_t *)arr, (int64_t)n);
}
