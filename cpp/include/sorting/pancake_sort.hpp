// GENERATED from kernels/algos/pancake_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void pancake_sort_x_flip(int32_t *a, int64_t k);
inline void pancake_sort_impl(int32_t *a, int64_t n);

inline void pancake_sort_x_flip(int32_t *a, int64_t k) {
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    i = 0;
    while ((i < k)) {
        _i1 = i;
        _i2 = k;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        i = (i + 1);
        k = (k - 1);
    }
}

inline void pancake_sort_impl(int32_t *a, int64_t n) {
    int64_t size = 0;
    int64_t mx = 0;
    int64_t i = 0;
    size = n;
    while ((size > 1)) {
        mx = 0;
        i = 1;
        while ((i < size)) {
            if ((((int64_t)a[i]) > ((int64_t)a[mx]))) {
                mx = i;
            }
            i = (i + 1);
        }
        if ((mx != (size - 1))) {
            if ((mx > 0)) {
                pancake_sort_x_flip(a, mx);
            }
            pancake_sort_x_flip(a, (size - 1));
        }
        size = (size - 1);
    }
}

}  // namespace detail

inline void pancake_sort(std::vector<int>& v) {
    detail::pancake_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
