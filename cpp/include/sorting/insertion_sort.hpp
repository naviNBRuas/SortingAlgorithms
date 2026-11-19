// GENERATED from kernels/algos/insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void insertion_sort_impl(int32_t *a, int64_t n);

inline void insertion_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        key = ((int64_t)a[i]);
        j = (i - 1);
        while (((j >= 0) && (((int64_t)a[j]) > key))) {
            a[(j + 1)] = (int32_t)(((int64_t)a[j]));
            j = (j - 1);
        }
        a[(j + 1)] = (int32_t)(key);
        i = (i + 1);
    }
}

}  // namespace detail

inline void insertion_sort(std::vector<int>& v) {
    detail::insertion_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
