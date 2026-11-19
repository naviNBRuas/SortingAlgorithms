/* GENERATED from kernels/algos/ford_johnson_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void ford_johnson_sort_x_fj(int32_t *key, int32_t *ids, int64_t m);
static void ford_johnson_sort_impl(int32_t *a, int64_t n);

static void ford_johnson_sort_x_fj(int32_t *key, int32_t *ids, int64_t m) {
    int64_t h = 0;
    int64_t k = 0;
    int64_t x = 0;
    int64_t y = 0;
    int64_t total = 0;
    int64_t size = 0;
    int64_t prev = 0;
    int64_t kk = 0;
    int64_t t = 0;
    int64_t pw = 0;
    int64_t c = 0;
    int64_t top = 0;
    int64_t i = 0;
    int64_t bound = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t mid = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int32_t *small = NULL;
    int32_t *big = NULL;
    int32_t *bk = NULL;
    int32_t *order = NULL;
    int32_t *chain = NULL;
    int32_t *bs = NULL;
    if ((m < 2)) {
        {
            free(small);
            free(big);
            free(bk);
            free(order);
            free(chain);
            free(bs);
            return;
        }
    }
    h = (m / 2);
    small = (int32_t *)calloc((size_t)k_max(1, h), sizeof(int32_t));
    big = (int32_t *)calloc((size_t)k_max(1, h), sizeof(int32_t));
    k = 0;
    _e1 = h;
    while ((k < _e1)) {
        x = ((int64_t)ids[(2 * k)]);
        y = ((int64_t)ids[((2 * k) + 1)]);
        if ((((int64_t)key[y]) < ((int64_t)key[x]))) {
            small[k] = (int32_t)(y);
            big[k] = (int32_t)(x);
        } else {
            small[k] = (int32_t)(x);
            big[k] = (int32_t)(y);
        }
        k = (k + 1);
    }
    bk = (int32_t *)calloc((size_t)k_max(1, h), sizeof(int32_t));
    order = (int32_t *)calloc((size_t)k_max(1, h), sizeof(int32_t));
    k = 0;
    _e2 = h;
    while ((k < _e2)) {
        bk[k] = (int32_t)(((int64_t)key[((int64_t)big[k])]));
        order[k] = (int32_t)(k);
        k = (k + 1);
    }
    ford_johnson_sort_x_fj(bk, order, h);
    total = h;
    if (((m % 2) == 1)) {
        total = (h + 1);
    }
    chain = (int32_t *)calloc((size_t)k_max(1, m), sizeof(int32_t));
    bs = (int32_t *)calloc((size_t)k_max(1, (total + 1)), sizeof(int32_t));
    chain[0] = (int32_t)(((int64_t)small[((int64_t)order[0])]));
    k = 0;
    _e3 = h;
    while ((k < _e3)) {
        chain[(k + 1)] = (int32_t)(((int64_t)big[((int64_t)order[k])]));
        bs[(k + 1)] = (int32_t)(((int64_t)small[((int64_t)order[k])]));
        k = (k + 1);
    }
    size = (h + 1);
    if (((m % 2) == 1)) {
        bs[(h + 1)] = (int32_t)(((int64_t)ids[(m - 1)]));
    }
    prev = 1;
    kk = 2;
    while ((prev < total)) {
        t = 1;
        pw = 1;
        c = 0;
        while ((c < (kk + 1))) {
            pw = (pw * 2);
            c = (c + 1);
        }
        if (((kk % 2) == 0)) {
            t = ((pw + 1) / 3);
        } else {
            t = ((pw - 1) / 3);
        }
        top = k_min(t, total);
        i = top;
        while ((i > prev)) {
            bound = size;
            if ((i <= h)) {
                bound = 0;
                while ((((int64_t)chain[bound]) != ((int64_t)big[((int64_t)order[(i - 1)])]))) {
                    bound = (bound + 1);
                }
            }
            lo = 0;
            hi = bound;
            while ((lo < hi)) {
                mid = ((lo + hi) / 2);
                if ((((int64_t)key[((int64_t)bs[i])]) < ((int64_t)key[((int64_t)chain[mid])]))) {
                    hi = mid;
                } else {
                    lo = (mid + 1);
                }
            }
            j = size;
            while ((j > lo)) {
                chain[j] = (int32_t)(((int64_t)chain[(j - 1)]));
                j = (j - 1);
            }
            chain[lo] = (int32_t)(((int64_t)bs[i]));
            size = (size + 1);
            i = (i - 1);
        }
        prev = top;
        kk = (kk + 1);
    }
    k = 0;
    _e4 = m;
    while ((k < _e4)) {
        ids[k] = (int32_t)(((int64_t)chain[k]));
        k = (k + 1);
    }
    free(small);
    free(big);
    free(bk);
    free(order);
    free(chain);
    free(bs);
}

static void ford_johnson_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int32_t *key = NULL;
    int32_t *ids = NULL;
    if ((n < 2)) {
        {
            free(key);
            free(ids);
            return;
        }
    }
    key = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    ids = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        key[i] = (int32_t)(((int64_t)a[i]));
        ids[i] = (int32_t)(i);
        i = (i + 1);
    }
    ford_johnson_sort_x_fj(key, ids, n);
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        a[i] = (int32_t)(((int64_t)key[((int64_t)ids[i])]));
        i = (i + 1);
    }
    free(key);
    free(ids);
}

void ford_johnson_sort(int *arr, size_t n) {
    ford_johnson_sort_impl((int32_t *)arr, (int64_t)n);
}
