// GENERATED from kernels/algos/cocktail_shaker_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void cocktail_shaker_sort_impl(int32_t *a, int64_t n);

inline void cocktail_shaker_sort_impl(int32_t *a, int64_t n) {
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t swapped = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    lo = 0;
    hi = (n - 1);
    swapped = 1;
    while (((lo < hi) && (swapped == 1))) {
        swapped = 0;
        i = lo;
        while ((i < hi)) {
            if ((((int64_t)a[i]) > ((int64_t)a[(i + 1)]))) {
                _i1 = i;
                _i2 = (i + 1);
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                swapped = 1;
            }
            i = (i + 1);
        }
        hi = (hi - 1);
        i = hi;
        while ((i > lo)) {
            if ((((int64_t)a[(i - 1)]) > ((int64_t)a[i]))) {
                _i1 = (i - 1);
                _i2 = i;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                swapped = 1;
            }
            i = (i - 1);
        }
        lo = (lo + 1);
    }
}

}  // namespace detail

inline void cocktail_shaker_sort(std::vector<int>& v) {
    detail::cocktail_shaker_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
