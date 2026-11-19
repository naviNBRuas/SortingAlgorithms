// GENERATED from kernels/algos/patience_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void patience_sort_impl(int32_t *a, int64_t n);

inline void patience_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t piles = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t mid = 0;
    int64_t out = 0;
    int64_t best = 0;
    int64_t p = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    std::vector<int32_t> vals;
    std::vector<int32_t> prev;
    std::vector<int32_t> top;
    if ((n < 2)) {
        return;
    }
    vals.assign((size_t)k_max(1, n), 0);
    prev.assign((size_t)k_max(1, n), 0);
    top.assign((size_t)k_max(1, n), 0);
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    piles = 0;
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        lo = 0;
        hi = piles;
        while ((lo < hi)) {
            mid = ((lo + hi) / 2);
            if ((((int64_t)vals[(((int64_t)top[mid]) - 1)]) < ((int64_t)vals[i]))) {
                lo = (mid + 1);
            } else {
                hi = mid;
            }
        }
        prev[i] = (int32_t)(((int64_t)top[lo]));
        top[lo] = (int32_t)((i + 1));
        if ((lo == piles)) {
            piles = (piles + 1);
        }
        i = (i + 1);
    }
    out = 0;
    _e3 = n;
    while ((out < _e3)) {
        best = (-1);
        p = 0;
        _e4 = piles;
        while ((p < _e4)) {
            if ((((int64_t)top[p]) != 0)) {
                if (((best < 0) || (((int64_t)vals[(((int64_t)top[p]) - 1)]) < ((int64_t)vals[(((int64_t)top[best]) - 1)])))) {
                    best = p;
                }
            }
            p = (p + 1);
        }
        a[out] = (int32_t)(((int64_t)vals[(((int64_t)top[best]) - 1)]));
        top[best] = (int32_t)(((int64_t)prev[(((int64_t)top[best]) - 1)]));
        out = (out + 1);
    }
}

}  // namespace detail

inline void patience_sort(std::vector<int>& v) {
    detail::patience_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
