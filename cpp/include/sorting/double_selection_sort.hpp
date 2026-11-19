// GENERATED from kernels/algos/double_selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void double_selection_sort_impl(int32_t *a, int64_t n);

inline void double_selection_sort_impl(int32_t *a, int64_t n) {
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t j = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    lo = 0;
    hi = (n - 1);
    while ((lo < hi)) {
        mn = lo;
        mx = lo;
        j = (lo + 1);
        while ((j <= hi)) {
            if ((((int64_t)a[j]) < ((int64_t)a[mn]))) {
                mn = j;
            } else {
                if ((((int64_t)a[j]) > ((int64_t)a[mx]))) {
                    mx = j;
                }
            }
            j = (j + 1);
        }
        _i1 = lo;
        _i2 = mn;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        if ((mx == lo)) {
            mx = mn;
        }
        _i1 = hi;
        _i2 = mx;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        lo = (lo + 1);
        hi = (hi - 1);
    }
}

}  // namespace detail

inline void double_selection_sort(std::vector<int>& v) {
    detail::double_selection_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
