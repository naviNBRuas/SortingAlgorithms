// GENERATED from kernels/algos/binary_insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void binary_insertion_sort_impl(int32_t *a, int64_t n);

inline void binary_insertion_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t key = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t mid = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        key = ((int64_t)a[i]);
        lo = 0;
        hi = i;
        while ((lo < hi)) {
            mid = ((lo + hi) / 2);
            if ((key < ((int64_t)a[mid]))) {
                hi = mid;
            } else {
                lo = (mid + 1);
            }
        }
        j = i;
        while ((j > lo)) {
            a[j] = (int32_t)(((int64_t)a[(j - 1)]));
            j = (j - 1);
        }
        a[lo] = (int32_t)(key);
        i = (i + 1);
    }
}

}  // namespace detail

inline void binary_insertion_sort(std::vector<int>& v) {
    detail::binary_insertion_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
