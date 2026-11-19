// GENERATED from kernels/algos/radix_sort_msd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void radix_sort_msd_x_rec(int32_t *a, int32_t *tmp, int64_t mn, int64_t lo, int64_t hi, int64_t exp);
inline void radix_sort_msd_impl(int32_t *a, int64_t n);

inline void radix_sort_msd_x_rec(int32_t *a, int32_t *tmp, int64_t mn, int64_t lo, int64_t hi, int64_t exp) {
    int64_t i = 0;
    int64_t d = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    std::vector<int32_t> count;
    std::vector<int32_t> start;
    if ((((hi - lo) < 2) || (exp == 0))) {
        return;
    }
    count.assign((size_t)k_max(1, 11), 0);
    i = lo;
    _e1 = hi;
    while ((i < _e1)) {
        count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)] = (int32_t)((((int64_t)count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)]) + 1));
        i = (i + 1);
    }
    d = 1;
    _e2 = 11;
    while ((d < _e2)) {
        count[d] = (int32_t)((((int64_t)count[d]) + ((int64_t)count[(d - 1)])));
        d = (d + 1);
    }
    start.assign((size_t)k_max(1, 11), 0);
    d = 0;
    _e3 = 11;
    while ((d < _e3)) {
        start[d] = (int32_t)(((int64_t)count[d]));
        d = (d + 1);
    }
    i = lo;
    _e4 = hi;
    while ((i < _e4)) {
        d = (((((int64_t)a[i]) - mn) / exp) % 10);
        tmp[(lo + ((int64_t)count[d]))] = (int32_t)(((int64_t)a[i]));
        count[d] = (int32_t)((((int64_t)count[d]) + 1));
        i = (i + 1);
    }
    i = lo;
    _e5 = hi;
    while ((i < _e5)) {
        a[i] = (int32_t)(((int64_t)tmp[i]));
        i = (i + 1);
    }
    d = 0;
    _e6 = 10;
    while ((d < _e6)) {
        radix_sort_msd_x_rec(a, tmp, mn, (lo + ((int64_t)start[d])), (lo + ((int64_t)start[(d + 1)])), (exp / 10));
        d = (d + 1);
    }
}

inline void radix_sort_msd_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t top = 0;
    int64_t _e1 = 0;
    std::vector<int32_t> tmp;
    if ((n < 2)) {
        return;
    }
    mn = ((int64_t)a[0]);
    mx = ((int64_t)a[0]);
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        if ((((int64_t)a[i]) < mn)) {
            mn = ((int64_t)a[i]);
        }
        if ((((int64_t)a[i]) > mx)) {
            mx = ((int64_t)a[i]);
        }
        i = (i + 1);
    }
    tmp.assign((size_t)k_max(1, n), 0);
    top = 1;
    while ((((mx - mn) / top) >= 10)) {
        top = (top * 10);
    }
    radix_sort_msd_x_rec(a, tmp.data(), mn, 0, n, top);
}

}  // namespace detail

inline void radix_sort_msd(std::vector<int>& v) {
    detail::radix_sort_msd_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
