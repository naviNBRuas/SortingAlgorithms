// GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void shell_sort_ciura_impl(int32_t *a, int64_t n);

inline void shell_sort_ciura_impl(int32_t *a, int64_t n) {
    int64_t k = 0;
    int64_t gap = 0;
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    std::vector<int32_t> g;
    g.assign((size_t)k_max(1, 10), 0);
    g[0] = (int32_t)(1);
    g[1] = (int32_t)(4);
    g[2] = (int32_t)(10);
    g[3] = (int32_t)(23);
    g[4] = (int32_t)(57);
    g[5] = (int32_t)(132);
    g[6] = (int32_t)(301);
    g[7] = (int32_t)(701);
    g[8] = (int32_t)(1750);
    g[9] = (int32_t)(4377);
    k = 9;
    while ((k >= 0)) {
        gap = ((int64_t)g[k]);
        if ((gap < n)) {
            i = gap;
            _e1 = n;
            while ((i < _e1)) {
                key = ((int64_t)a[i]);
                j = i;
                while (((j >= gap) && (((int64_t)a[(j - gap)]) > key))) {
                    a[j] = (int32_t)(((int64_t)a[(j - gap)]));
                    j = (j - gap);
                }
                a[j] = (int32_t)(key);
                i = (i + 1);
            }
        }
        k = (k - 1);
    }
}

}  // namespace detail

inline void shell_sort_ciura(std::vector<int>& v) {
    detail::shell_sort_ciura_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
