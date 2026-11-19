// GENERATED from kernels/algos/quick_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void quick_sort_x_qs(int32_t *a, int64_t lo, int64_t hi);
inline void quick_sort_impl(int32_t *a, int64_t n);

inline void quick_sort_x_qs(int32_t *a, int64_t lo, int64_t hi) {
    int64_t pivot = 0;
    int64_t i = 0;
    int64_t j = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    while ((lo < hi)) {
        pivot = ((int64_t)a[hi]);
        i = lo;
        j = lo;
        while ((j < hi)) {
            if ((((int64_t)a[j]) <= pivot)) {
                _i1 = i;
                _i2 = j;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                i = (i + 1);
            }
            j = (j + 1);
        }
        _i1 = i;
        _i2 = hi;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        if (((i - lo) < (hi - i))) {
            quick_sort_x_qs(a, lo, (i - 1));
            lo = (i + 1);
        } else {
            quick_sort_x_qs(a, (i + 1), hi);
            hi = (i - 1);
        }
    }
}

inline void quick_sort_impl(int32_t *a, int64_t n) {
    quick_sort_x_qs(a, 0, (n - 1));
}

}  // namespace detail

inline void quick_sort(std::vector<int>& v) {
    detail::quick_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
