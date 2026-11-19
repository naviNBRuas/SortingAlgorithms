// GENERATED from kernels/algos/stooge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void stooge_sort_x_st(int32_t *a, int64_t i, int64_t j);
inline void stooge_sort_impl(int32_t *a, int64_t n);

inline void stooge_sort_x_st(int32_t *a, int64_t i, int64_t j) {
    int64_t t = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((((int64_t)a[i]) > ((int64_t)a[j]))) {
        _i1 = i;
        _i2 = j;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
    }
    if ((((j - i) + 1) > 2)) {
        t = (((j - i) + 1) / 3);
        stooge_sort_x_st(a, i, (j - t));
        stooge_sort_x_st(a, (i + t), j);
        stooge_sort_x_st(a, i, (j - t));
    }
}

inline void stooge_sort_impl(int32_t *a, int64_t n) {
    if ((n > 1)) {
        stooge_sort_x_st(a, 0, (n - 1));
    }
}

}  // namespace detail

inline void stooge_sort(std::vector<int>& v) {
    detail::stooge_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
