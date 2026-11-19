/* GENERATED from kernels/algos/tim_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate. */
#include "../sorting_algorithms.h"
#include <stdint.h>
#include <stdlib.h>
static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }
static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }

static void tim_sort_x_insertion(int32_t *a, int64_t lo, int64_t hi);
static int64_t tim_sort_x_merge_at(int32_t *a, int32_t *tmp, int32_t *rs, int32_t *rl, int64_t cnt, int64_t i);
static int64_t tim_sort_x_collapse(int32_t *a, int32_t *tmp, int32_t *rs, int32_t *rl, int64_t cnt);
static void tim_sort_impl(int32_t *a, int64_t n);

static void tim_sort_x_insertion(int32_t *a, int64_t lo, int64_t hi) {
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    i = (lo + 1);
    _e1 = hi;
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

static int64_t tim_sort_x_merge_at(int32_t *a, int32_t *tmp, int32_t *rs, int32_t *rl, int64_t cnt, int64_t i) {
    int64_t s1 = 0;
    int64_t l1 = 0;
    int64_t l2 = 0;
    int64_t x = 0;
    int64_t j = 0;
    int64_t k = 0;
    int64_t end = 0;
    int64_t t = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    s1 = ((int64_t)rs[i]);
    l1 = ((int64_t)rl[i]);
    l2 = ((int64_t)rl[(i + 1)]);
    x = 0;
    _e1 = l1;
    while ((x < _e1)) {
        tmp[x] = (int32_t)(((int64_t)a[(s1 + x)]));
        x = (x + 1);
    }
    x = 0;
    j = (s1 + l1);
    k = s1;
    end = (j + l2);
    while (((x < l1) && (j < end))) {
        if ((((int64_t)a[j]) < ((int64_t)tmp[x]))) {
            a[k] = (int32_t)(((int64_t)a[j]));
            j = (j + 1);
        } else {
            a[k] = (int32_t)(((int64_t)tmp[x]));
            x = (x + 1);
        }
        k = (k + 1);
    }
    while ((x < l1)) {
        a[k] = (int32_t)(((int64_t)tmp[x]));
        x = (x + 1);
        k = (k + 1);
    }
    rl[i] = (int32_t)((l1 + l2));
    t = (i + 1);
    _e2 = (cnt - 1);
    while ((t < _e2)) {
        rs[t] = (int32_t)(((int64_t)rs[(t + 1)]));
        rl[t] = (int32_t)(((int64_t)rl[(t + 1)]));
        t = (t + 1);
    }
    return (cnt - 1);
}

static int64_t tim_sort_x_collapse(int32_t *a, int32_t *tmp, int32_t *rs, int32_t *rl, int64_t cnt) {
    int64_t going = 0;
    int64_t m = 0;
    int64_t need = 0;
    going = 1;
    while (((going == 1) && (cnt > 1))) {
        m = (cnt - 2);
        need = 0;
        if (((m > 0) && (((int64_t)rl[(m - 1)]) <= (((int64_t)rl[m]) + ((int64_t)rl[(m + 1)]))))) {
            need = 1;
        }
        if (((m > 1) && (((int64_t)rl[(m - 2)]) <= (((int64_t)rl[(m - 1)]) + ((int64_t)rl[m]))))) {
            need = 1;
        }
        if ((need == 1)) {
            if (((m > 0) && (((int64_t)rl[(m - 1)]) < ((int64_t)rl[(m + 1)])))) {
                m = (m - 1);
            }
            cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
        } else {
            if ((((int64_t)rl[m]) <= ((int64_t)rl[(m + 1)]))) {
                cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
            } else {
                going = 0;
            }
        }
    }
    return cnt;
}

static void tim_sort_impl(int32_t *a, int64_t n) {
    int64_t r = 0;
    int64_t t = 0;
    int64_t minrun = 0;
    int64_t cnt = 0;
    int64_t lo = 0;
    int64_t e = 0;
    int64_t x = 0;
    int64_t y = 0;
    int64_t force = 0;
    int64_t m = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    int32_t *tmp = NULL;
    int32_t *rs = NULL;
    int32_t *rl = NULL;
    if ((n < 2)) {
        {
            free(tmp);
            free(rs);
            free(rl);
            return;
        }
    }
    tmp = (int32_t *)calloc((size_t)k_max(1, n), sizeof(int32_t));
    rs = (int32_t *)calloc((size_t)k_max(1, 128), sizeof(int32_t));
    rl = (int32_t *)calloc((size_t)k_max(1, 128), sizeof(int32_t));
    r = 0;
    t = n;
    while ((t >= 64)) {
        r = (r + (t % 2));
        if ((r > 1)) {
            r = 1;
        }
        t = (t / 2);
    }
    minrun = (t + r);
    cnt = 0;
    lo = 0;
    while ((lo < n)) {
        e = (lo + 1);
        if ((e < n)) {
            if ((((int64_t)a[e]) < ((int64_t)a[(e - 1)]))) {
                while (((e < n) && (((int64_t)a[e]) < ((int64_t)a[(e - 1)])))) {
                    e = (e + 1);
                }
                x = lo;
                y = (e - 1);
                while ((x < y)) {
                    _i1 = x;
                    _i2 = y;
                    _t1 = ((int64_t)a[_i1]);
                    a[_i1] = (int32_t)(((int64_t)a[_i2]));
                    a[_i2] = (int32_t)(_t1);
                    x = (x + 1);
                    y = (y - 1);
                }
            } else {
                while (((e < n) && (((int64_t)a[e]) >= ((int64_t)a[(e - 1)])))) {
                    e = (e + 1);
                }
            }
        }
        force = k_min(minrun, (n - lo));
        if (((e - lo) < force)) {
            tim_sort_x_insertion(a, lo, (lo + force));
            e = (lo + force);
        }
        rs[cnt] = (int32_t)(lo);
        rl[cnt] = (int32_t)((e - lo));
        cnt = (cnt + 1);
        cnt = tim_sort_x_collapse(a, tmp, rs, rl, cnt);
        lo = e;
    }
    while ((cnt > 1)) {
        m = (cnt - 2);
        if (((m > 0) && (((int64_t)rl[(m - 1)]) < ((int64_t)rl[(m + 1)])))) {
            m = (m - 1);
        }
        cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m);
    }
    free(tmp);
    free(rs);
    free(rl);
}

void tim_sort(int *arr, size_t n) {
    tim_sort_impl((int32_t *)arr, (int64_t)n);
}
