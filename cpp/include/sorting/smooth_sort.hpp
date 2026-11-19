// GENERATED from kernels/algos/smooth_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline int64_t smooth_sort_x_tz(int64_t x);
inline int64_t smooth_sort_x_pow2(int64_t k);
inline void smooth_sort_x_sift(int32_t *a, int32_t *lp, int64_t head, int64_t pshift);
inline void smooth_sort_x_trinkle(int32_t *a, int32_t *lp, int64_t head, int64_t p, int64_t pshift, int64_t trusty);
inline void smooth_sort_impl(int32_t *a, int64_t n);

inline int64_t smooth_sort_x_tz(int64_t x) {
    int64_t c = 0;
    c = 0;
    while (((x % 2) == 0)) {
        x = (x / 2);
        c = (c + 1);
    }
    return c;
}

inline int64_t smooth_sort_x_pow2(int64_t k) {
    int64_t r = 0;
    int64_t i = 0;
    int64_t _e1 = 0;
    r = 1;
    i = 0;
    _e1 = k;
    while ((i < _e1)) {
        r = (r * 2);
        i = (i + 1);
    }
    return r;
}

inline void smooth_sort_x_sift(int32_t *a, int32_t *lp, int64_t head, int64_t pshift) {
    int64_t val = 0;
    int64_t going = 0;
    int64_t rt = 0;
    int64_t lf = 0;
    val = ((int64_t)a[head]);
    going = 1;
    while (((pshift > 1) && (going == 1))) {
        rt = (head - 1);
        lf = ((head - 1) - ((int64_t)lp[(pshift - 2)]));
        if (((val >= ((int64_t)a[lf])) && (val >= ((int64_t)a[rt])))) {
            going = 0;
        } else {
            if ((((int64_t)a[lf]) >= ((int64_t)a[rt]))) {
                a[head] = (int32_t)(((int64_t)a[lf]));
                head = lf;
                pshift = (pshift - 1);
            } else {
                a[head] = (int32_t)(((int64_t)a[rt]));
                head = rt;
                pshift = (pshift - 2);
            }
        }
    }
    a[head] = (int32_t)(val);
}

inline void smooth_sort_x_trinkle(int32_t *a, int32_t *lp, int64_t head, int64_t p, int64_t pshift, int64_t trusty) {
    int64_t val = 0;
    int64_t going = 0;
    int64_t stepson = 0;
    int64_t stop = 0;
    int64_t rt = 0;
    int64_t lf = 0;
    int64_t trail = 0;
    val = ((int64_t)a[head]);
    going = 1;
    while (((p != 1) && (going == 1))) {
        stepson = (head - ((int64_t)lp[pshift]));
        if ((((int64_t)a[stepson]) <= val)) {
            going = 0;
        } else {
            stop = 0;
            if (((trusty == 0) && (pshift > 1))) {
                rt = (head - 1);
                lf = ((head - 1) - ((int64_t)lp[(pshift - 2)]));
                if (((((int64_t)a[rt]) >= ((int64_t)a[stepson])) || (((int64_t)a[lf]) >= ((int64_t)a[stepson])))) {
                    stop = 1;
                }
            }
            if ((stop == 1)) {
                going = 0;
            } else {
                a[head] = (int32_t)(((int64_t)a[stepson]));
                head = stepson;
                trail = smooth_sort_x_tz((p - (p % 2)));
                p = (p / smooth_sort_x_pow2(trail));
                pshift = (pshift + trail);
                trusty = 0;
            }
        }
    }
    if ((trusty == 0)) {
        a[head] = (int32_t)(val);
        smooth_sort_x_sift(a, lp, head, pshift);
    }
}

inline void smooth_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t hi = 0;
    int64_t head = 0;
    int64_t p = 0;
    int64_t pshift = 0;
    int64_t trail = 0;
    int64_t _e1 = 0;
    std::vector<int32_t> lp;
    if ((n < 2)) {
        return;
    }
    lp.assign((size_t)k_max(1, 64), 0);
    lp[0] = (int32_t)(1);
    lp[1] = (int32_t)(1);
    i = 2;
    _e1 = 64;
    while ((i < _e1)) {
        lp[i] = (int32_t)(((((int64_t)lp[(i - 1)]) + ((int64_t)lp[(i - 2)])) + 1));
        i = (i + 1);
    }
    hi = (n - 1);
    head = 0;
    p = 1;
    pshift = 1;
    while ((head < hi)) {
        if (((p % 4) == 3)) {
            smooth_sort_x_sift(a, lp.data(), head, pshift);
            p = (p / 4);
            pshift = (pshift + 2);
        } else {
            if ((((int64_t)lp[(pshift - 1)]) >= (hi - head))) {
                smooth_sort_x_trinkle(a, lp.data(), head, p, pshift, 0);
            } else {
                smooth_sort_x_sift(a, lp.data(), head, pshift);
            }
            if ((pshift == 1)) {
                p = (p * 2);
                pshift = 0;
            } else {
                p = (p * smooth_sort_x_pow2((pshift - 1)));
                pshift = 1;
            }
        }
        p = ((p + 1) - (p % 2));
        head = (head + 1);
    }
    smooth_sort_x_trinkle(a, lp.data(), head, p, pshift, 0);
    while (((pshift != 1) || (p != 1))) {
        if ((pshift <= 1)) {
            trail = smooth_sort_x_tz((p - (p % 2)));
            p = (p / smooth_sort_x_pow2(trail));
            pshift = (pshift + trail);
        } else {
            p = (p * 4);
            if ((((p / 4) % 2) == 0)) {
                p = (p + 7);
            } else {
                p = (p - 1);
            }
            pshift = (pshift - 2);
            smooth_sort_x_trinkle(a, lp.data(), ((head - ((int64_t)lp[pshift])) - 1), (p / 2), (pshift + 1), 1);
            smooth_sort_x_trinkle(a, lp.data(), (head - 1), p, pshift, 1);
        }
        head = (head - 1);
    }
}

}  // namespace detail

inline void smooth_sort(std::vector<int>& v) {
    detail::smooth_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
