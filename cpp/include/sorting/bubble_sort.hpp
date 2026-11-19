// GENERATED from kernels/algos/bubble_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void bubble_sort_impl(int32_t *a, int64_t n);

inline void bubble_sort_impl(int32_t *a, int64_t n) {
    int64_t end = 0;
    int64_t swapped = 0;
    int64_t j = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    end = (n - 1);
    swapped = 1;
    while (((end > 0) && (swapped == 1))) {
        swapped = 0;
        j = 0;
        while ((j < end)) {
            if ((((int64_t)a[j]) > ((int64_t)a[(j + 1)]))) {
                _i1 = j;
                _i2 = (j + 1);
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                swapped = 1;
            }
            j = (j + 1);
        }
        end = (end - 1);
    }
}

}  // namespace detail

inline void bubble_sort(std::vector<int>& v) {
    detail::bubble_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
