// GENERATED from kernels/algos/gnome_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void gnome_sort_impl(int32_t *a, int64_t n);

inline void gnome_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    i = 0;
    while ((i < n)) {
        if (((i == 0) || (((int64_t)a[(i - 1)]) <= ((int64_t)a[i])))) {
            i = (i + 1);
        } else {
            _i1 = (i - 1);
            _i2 = i;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
            i = (i - 1);
        }
    }
}

}  // namespace detail

inline void gnome_sort(std::vector<int>& v) {
    detail::gnome_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
