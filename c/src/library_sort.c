/* GENERATED from kernels/algos/library_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static int64_t library_sort_x_locate(int32_t *vals, int32_t *s, int64_t size, int64_t x);
static void library_sort_impl(int32_t *a, int64_t n);

static int64_t library_sort_x_locate(int32_t *vals, int32_t *s, int64_t size, int64_t x) {
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t mid = 0;
    int64_t m = 0;
    lo = 0;
    hi = (size - 1);
    while ((lo <= hi)) {
        mid = ((lo + hi) / 2);
        m = mid;
        while (((m <= hi) && (((int64_t)s[m]) == 0))) {
            m = (m + 1);
        }
        if ((m > hi)) {
            hi = (mid - 1);
        } else {
            if ((x < ((int64_t)vals[(((int64_t)s[m]) - 1)]))) {
                hi = (mid - 1);
            } else {
                lo = (m + 1);
            }
        }
    }
    return lo;
}

static void library_sort_impl(int32_t *a, int64_t n) {
    int64_t size = 0;
    int64_t i = 0;
    int64_t nextpow = 0;
    int64_t k = 0;
    int64_t cnt = 0;
    int64_t j = 0;
    int64_t lo = 0;
    int64_t p = 0;
    int64_t q = 0;
    int64_t g = 0;
    int64_t out = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    int32_t *vals = NULL;
    int32_t *s = NULL;
    int32_t *tmp = NULL;
    if ((n < 2)) {
        {
            free(vals);
            free(s);
            free(tmp);
            return;
        }
    }
    size = ((2 * n) + 2);
    vals = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    s = (int32_t *)calloc((size_t)k_max(1, size), sizeof(int32_t));
    tmp = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    nextpow = 1;
    k = 0;
    _e2 = n;
    while ((k < _e2)) {
        if ((k == nextpow)) {
            nextpow = (nextpow * 2);
            cnt = 0;
            i = 0;
            _e3 = size;
            while ((i < _e3)) {
                if ((((int64_t)s[i]) != 0)) {
                    tmp[cnt] = (int32_t)(((int64_t)s[i]));
                    cnt = (cnt + 1);
                    s[i] = (int32_t)(0);
                }
                i = (i + 1);
            }
            j = 0;
            _e4 = cnt;
            while ((j < _e4)) {
                s[((j * size) / cnt)] = (int32_t)(((int64_t)tmp[j]));
                j = (j + 1);
            }
        }
        lo = library_sort_x_locate(vals, s, size, ((int64_t)vals[k]));
        p = (lo - 1);
        while (((p >= 0) && (((int64_t)s[p]) == 0))) {
            p = (p - 1);
        }
        q = lo;
        while (((q < size) && (((int64_t)s[q]) == 0))) {
            q = (q + 1);
        }
        if (((q - p) > 1)) {
            s[((p + q) / 2)] = (int32_t)((k + 1));
        } else {
            g = q;
            while (((g < size) && (((int64_t)s[g]) != 0))) {
                g = (g + 1);
            }
            if ((g < size)) {
                j = g;
                while ((j > q)) {
                    s[j] = (int32_t)(((int64_t)s[(j - 1)]));
                    j = (j - 1);
                }
                s[q] = (int32_t)((k + 1));
            } else {
                g = p;
                while ((((int64_t)s[g]) != 0)) {
                    g = (g - 1);
                }
                j = g;
                while ((j < p)) {
                    s[j] = (int32_t)(((int64_t)s[(j + 1)]));
                    j = (j + 1);
                }
                s[p] = (int32_t)((k + 1));
            }
        }
        k = (k + 1);
    }
    out = 0;
    i = 0;
    _e5 = size;
    while ((i < _e5)) {
        if ((((int64_t)s[i]) != 0)) {
            tmp[out] = (int32_t)(((int64_t)vals[(((int64_t)s[i]) - 1)]));
            out = (out + 1);
        }
        i = (i + 1);
    }
    i = 0;
    _e6 = n;
    while ((i < _e6)) {
        a[i] = (int32_t)(((int64_t)tmp[i]));
        i = (i + 1);
    }
    free(vals);
    free(s);
    free(tmp);
}

void library_sort(int *arr, size_t n) {
    library_sort_impl((int32_t *)arr, (int64_t)n);
}
