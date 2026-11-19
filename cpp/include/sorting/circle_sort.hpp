// GENERATED from kernels/algos/circle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline int64_t circle_sort_x_circle_pass(int32_t *a, int64_t lo, int64_t hi);
inline void circle_sort_impl(int32_t *a, int64_t n);

inline int64_t circle_sort_x_circle_pass(int32_t *a, int64_t lo, int64_t hi) {
    int64_t m = 0;
    int64_t swaps = 0;
    int64_t half = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    m = (hi - lo);
    if ((m < 2)) {
        return 0;
    }
    swaps = 0;
    half = (m / 2);
    i = 0;
    while ((i < half)) {
        if ((((int64_t)a[((hi - 1) - i)]) < ((int64_t)a[(lo + i)]))) {
            _i1 = ((hi - 1) - i);
            _i2 = (lo + i);
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
            swaps = (swaps + 1);
        }
        i = (i + 1);
    }
    if (((m % 2) == 1)) {
        if ((((int64_t)a[(lo + half)]) < ((int64_t)a[((lo + half) - 1)]))) {
            _i1 = ((lo + half) - 1);
            _i2 = (lo + half);
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
            swaps = (swaps + 1);
        }
    }
    swaps = (swaps + circle_sort_x_circle_pass(a, lo, (lo + half)));
    swaps = (swaps + circle_sort_x_circle_pass(a, (lo + half), hi));
    return swaps;
}

inline void circle_sort_impl(int32_t *a, int64_t n) {
    int64_t s = 0;
    s = 1;
    while ((s > 0)) {
        s = circle_sort_x_circle_pass(a, 0, n);
    }
}

}  // namespace detail

inline void circle_sort(std::vector<int>& v) {
    detail::circle_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
