// GENERATED from kernels/algos/selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void selection_sort_impl(int32_t *a, int64_t n);

inline void selection_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t m = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    i = 0;
    _e1 = (n - 1);
    while ((i < _e1)) {
        m = i;
        j = (i + 1);
        _e2 = n;
        while ((j < _e2)) {
            if ((((int64_t)a[j]) < ((int64_t)a[m]))) {
                m = j;
            }
            j = (j + 1);
        }
        if ((m != i)) {
            _i1 = i;
            _i2 = m;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        i = (i + 1);
    }
}

}  // namespace detail

inline void selection_sort(std::vector<int>& v) {
    detail::selection_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
