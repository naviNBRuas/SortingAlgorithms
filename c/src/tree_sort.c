/* GENERATED from kernels/algos/tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void tree_sort_impl(int32_t *a, int64_t n);

static void tree_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t cur = 0;
    int64_t placed = 0;
    int64_t node = 0;
    int64_t sp = 0;
    int64_t out = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int32_t *vals = NULL;
    int32_t *left = NULL;
    int32_t *right = NULL;
    int32_t *stack = NULL;
    if ((n < 2)) {
        {
            free(vals);
            free(left);
            free(right);
            free(stack);
            return;
        }
    }
    vals = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    left = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    right = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    stack = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    i = 1;
    _e2 = n;
    while ((i < _e2)) {
        cur = 0;
        placed = 0;
        while ((placed == 0)) {
            if ((((int64_t)vals[i]) < ((int64_t)vals[cur]))) {
                if ((((int64_t)left[cur]) == 0)) {
                    left[cur] = (int32_t)((i + 1));
                    placed = 1;
                } else {
                    cur = (((int64_t)left[cur]) - 1);
                }
            } else {
                if ((((int64_t)right[cur]) == 0)) {
                    right[cur] = (int32_t)((i + 1));
                    placed = 1;
                } else {
                    cur = (((int64_t)right[cur]) - 1);
                }
            }
        }
        i = (i + 1);
    }
    node = 1;
    sp = 0;
    out = 0;
    while (((node != 0) || (sp > 0))) {
        if ((node != 0)) {
            stack[sp] = (int32_t)(node);
            sp = (sp + 1);
            node = ((int64_t)left[(node - 1)]);
        } else {
            sp = (sp - 1);
            node = ((int64_t)stack[sp]);
            a[out] = (int32_t)(((int64_t)vals[(node - 1)]));
            out = (out + 1);
            node = ((int64_t)right[(node - 1)]);
        }
    }
    free(vals);
    free(left);
    free(right);
    free(stack);
}

void tree_sort(int *arr, size_t n) {
    tree_sort_impl((int32_t *)arr, (int64_t)n);
}
