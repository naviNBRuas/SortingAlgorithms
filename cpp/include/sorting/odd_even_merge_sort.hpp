// GENERATED from kernels/algos/odd_even_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void odd_even_merge_sort_x_cmp_swap(int32_t *a, int64_t i, int64_t j);
inline void odd_even_merge_sort_impl(int32_t *a, int64_t n);

inline void odd_even_merge_sort_x_cmp_swap(int32_t *a, int64_t i, int64_t j) {
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
}

inline void odd_even_merge_sort_impl(int32_t *a, int64_t n) {
    int64_t p = 0;
    int64_t k = 0;
    int64_t j = 0;
    int64_t lim = 0;
    int64_t i = 0;
    int64_t _e1 = 0;
    p = 1;
    while ((p < n)) {
        k = p;
        while ((k >= 1)) {
            j = (k % p);
            while ((j < (n - k))) {
                lim = k_min(k, ((n - j) - k));
                i = 0;
                _e1 = lim;
                while ((i < _e1)) {
                    if ((((i + j) / (2 * p)) == (((i + j) + k) / (2 * p)))) {
                        odd_even_merge_sort_x_cmp_swap(a, (i + j), ((i + j) + k));
                    }
                    i = (i + 1);
                }
                j = (j + (2 * k));
            }
            k = (k / 2);
        }
        p = (p * 2);
    }
}

}  // namespace detail

inline void odd_even_merge_sort(std::vector<int>& v) {
    detail::odd_even_merge_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
