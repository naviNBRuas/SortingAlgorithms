// GENERATED from kernels/algos/enumeration_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void enumeration_sort_impl(int32_t *a, int64_t n);

inline void enumeration_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t rank = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    std::vector<int32_t> out;
    out.assign((size_t)k_max(1, n), 0);
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        rank = 0;
        j = 0;
        _e2 = n;
        while ((j < _e2)) {
            if (((((int64_t)a[j]) < ((int64_t)a[i])) || ((((int64_t)a[j]) == ((int64_t)a[i])) && (j < i)))) {
                rank = (rank + 1);
            }
            j = (j + 1);
        }
        out[rank] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    i = 0;
    _e3 = n;
    while ((i < _e3)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
}

}  // namespace detail

inline void enumeration_sort(std::vector<int>& v) {
    detail::enumeration_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
