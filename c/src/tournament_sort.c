/* GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static int64_t tournament_sort_x_better(int32_t *vals, int64_t x, int64_t y);
static void tournament_sort_impl(int32_t *a, int64_t n);

static int64_t tournament_sort_x_better(int32_t *vals, int64_t x, int64_t y) {
    if ((x < 0)) {
        return y;
    }
    if ((y < 0)) {
        return x;
    }
    if ((((int64_t)vals[x]) <= ((int64_t)vals[y]))) {
        return x;
    }
    return y;
}

static void tournament_sort_impl(int32_t *a, int64_t n) {
    int64_t size = 0;
    int64_t i = 0;
    int64_t k = 0;
    int64_t w = 0;
    int64_t node = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int32_t *vals = NULL;
    int32_t *out = NULL;
    int32_t *tree = NULL;
    if ((n < 2)) {
        {
            free(vals);
            free(out);
            free(tree);
            return;
        }
    }
    size = 1;
    while ((size < n)) {
        size = (size * 2);
    }
    vals = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    out = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    tree = (int32_t *)calloc((size_t)k_max(1, (2 * size)), sizeof(int32_t));
    i = 0;
    _e1 = (2 * size);
    while ((i < _e1)) {
        tree[i] = (int32_t)((-1));
        i = (i + 1);
    }
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        tree[(size + i)] = (int32_t)(i);
        i = (i + 1);
    }
    i = (size - 1);
    while ((i >= 1)) {
        tree[i] = (int32_t)(tournament_sort_x_better(vals, ((int64_t)tree[(2 * i)]), ((int64_t)tree[((2 * i) + 1)])));
        i = (i - 1);
    }
    k = 0;
    _e3 = n;
    while ((k < _e3)) {
        w = ((int64_t)tree[1]);
        out[k] = (int32_t)(((int64_t)vals[w]));
        node = (size + w);
        tree[node] = (int32_t)((-1));
        node = (node / 2);
        while ((node >= 1)) {
            tree[node] = (int32_t)(tournament_sort_x_better(vals, ((int64_t)tree[(2 * node)]), ((int64_t)tree[((2 * node) + 1)])));
            node = (node / 2);
        }
        k = (k + 1);
    }
    i = 0;
    _e4 = n;
    while ((i < _e4)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
    free(vals);
    free(out);
    free(tree);
}

void tournament_sort(int *arr, size_t n) {
    tournament_sort_impl((int32_t *)arr, (int64_t)n);
}
