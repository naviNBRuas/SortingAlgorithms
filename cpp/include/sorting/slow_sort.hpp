// GENERATED from kernels/algos/slow_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void slow_sort_x_slow(int32_t *a, int64_t i, int64_t j);
inline void slow_sort_impl(int32_t *a, int64_t n);

inline void slow_sort_x_slow(int32_t *a, int64_t i, int64_t j) {
    int64_t m = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((i >= j)) {
        return;
    }
    m = ((i + j) / 2);
    slow_sort_x_slow(a, i, m);
    slow_sort_x_slow(a, (m + 1), j);
    if ((((int64_t)a[m]) > ((int64_t)a[j]))) {
        _i1 = m;
        _i2 = j;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
    }
    slow_sort_x_slow(a, i, (j - 1));
}

inline void slow_sort_impl(int32_t *a, int64_t n) {
    slow_sort_x_slow(a, 0, (n - 1));
}

}  // namespace detail

inline void slow_sort(std::vector<int>& v) {
    detail::slow_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
