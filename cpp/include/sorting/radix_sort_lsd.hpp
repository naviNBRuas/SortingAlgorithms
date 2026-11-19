// GENERATED from kernels/algos/radix_sort_lsd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void radix_sort_lsd_impl(int32_t *a, int64_t n);

inline void radix_sort_lsd_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t exp = 0;
    int64_t d = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    std::vector<int32_t> out;
    std::vector<int32_t> count;
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
    out.assign((size_t)k_max(1, n), 0);
    count.assign((size_t)k_max(1, 11), 0);
    exp = 1;
    while ((((mx - mn) / exp) > 0)) {
        d = 0;
        _e2 = 11;
        while ((d < _e2)) {
            count[d] = (int32_t)(0);
            d = (d + 1);
        }
        i = 0;
        _e3 = n;
        while ((i < _e3)) {
            count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)] = (int32_t)((((int64_t)count[((((((int64_t)a[i]) - mn) / exp) % 10) + 1)]) + 1));
            i = (i + 1);
        }
        d = 1;
        _e4 = 11;
        while ((d < _e4)) {
            count[d] = (int32_t)((((int64_t)count[d]) + ((int64_t)count[(d - 1)])));
            d = (d + 1);
        }
        i = 0;
        _e5 = n;
        while ((i < _e5)) {
            d = (((((int64_t)a[i]) - mn) / exp) % 10);
            out[((int64_t)count[d])] = (int32_t)(((int64_t)a[i]));
            count[d] = (int32_t)((((int64_t)count[d]) + 1));
            i = (i + 1);
        }
        i = 0;
        _e6 = n;
        while ((i < _e6)) {
            a[i] = (int32_t)(((int64_t)out[i]));
            i = (i + 1);
        }
        exp = (exp * 10);
    }
}

}  // namespace detail

inline void radix_sort_lsd(std::vector<int>& v) {
    detail::radix_sort_lsd_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
