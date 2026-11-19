// GENERATED from kernels/algos/odd_even_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void odd_even_sort_impl(int32_t *a, int64_t n);

inline void odd_even_sort_impl(int32_t *a, int64_t n) {
    int64_t done = 0;
    int64_t start = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    done = 0;
    while ((done == 0)) {
        done = 1;
        start = 1;
        while ((start >= 0)) {
            i = start;
            while (((i + 1) < n)) {
                if ((((int64_t)a[i]) > ((int64_t)a[(i + 1)]))) {
                    _i1 = i;
                    _i2 = (i + 1);
                    _t1 = ((int64_t)a[_i1]);
                    a[_i1] = (int32_t)(((int64_t)a[_i2]));
                    a[_i2] = (int32_t)(_t1);
                    done = 0;
                }
                i = (i + 2);
            }
            start = (start - 1);
        }
    }
}

}  // namespace detail

inline void odd_even_sort(std::vector<int>& v) {
    detail::odd_even_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
