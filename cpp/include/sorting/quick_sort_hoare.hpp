// GENERATED from kernels/algos/quick_sort_hoare.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void quick_sort_hoare_x_qs(int32_t *a, int64_t lo, int64_t hi);
inline void quick_sort_hoare_impl(int32_t *a, int64_t n);

inline void quick_sort_hoare_x_qs(int32_t *a, int64_t lo, int64_t hi) {
    int64_t pivot = 0;
    int64_t i = 0;
    int64_t j = 0;
    int64_t going = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    while ((lo < hi)) {
        pivot = ((int64_t)a[((lo + hi) / 2)]);
        i = (lo - 1);
        j = (hi + 1);
        going = 1;
        while ((going == 1)) {
            i = (i + 1);
            while ((((int64_t)a[i]) < pivot)) {
                i = (i + 1);
            }
            j = (j - 1);
            while ((((int64_t)a[j]) > pivot)) {
                j = (j - 1);
            }
            if ((i >= j)) {
                going = 0;
            } else {
                _i1 = i;
                _i2 = j;
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
            }
        }
        if (((j - lo) < ((hi - j) - 1))) {
            quick_sort_hoare_x_qs(a, lo, j);
            lo = (j + 1);
        } else {
            quick_sort_hoare_x_qs(a, (j + 1), hi);
            hi = j;
        }
    }
}

inline void quick_sort_hoare_impl(int32_t *a, int64_t n) {
    quick_sort_hoare_x_qs(a, 0, (n - 1));
}

}  // namespace detail

inline void quick_sort_hoare(std::vector<int>& v) {
    detail::quick_sort_hoare_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
