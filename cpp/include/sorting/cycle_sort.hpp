// GENERATED from kernels/algos/cycle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline int64_t cycle_sort_x_rank_of(int32_t *a, int64_t n, int64_t start, int64_t item);
inline void cycle_sort_impl(int32_t *a, int64_t n);

inline int64_t cycle_sort_x_rank_of(int32_t *a, int64_t n, int64_t start, int64_t item) {
    int64_t pos = 0;
    int64_t i = 0;
    int64_t _e1 = 0;
    pos = start;
    i = (start + 1);
    _e1 = n;
    while ((i < _e1)) {
        if ((((int64_t)a[i]) < item)) {
            pos = (pos + 1);
        }
        i = (i + 1);
    }
    return pos;
}

inline void cycle_sort_impl(int32_t *a, int64_t n) {
    int64_t start = 0;
    int64_t item = 0;
    int64_t pos = 0;
    int64_t tmp = 0;
    int64_t _e1 = 0;
    start = 0;
    _e1 = (n - 1);
    while ((start < _e1)) {
        item = ((int64_t)a[start]);
        pos = cycle_sort_x_rank_of(a, n, start, item);
        if ((pos != start)) {
            while ((item == ((int64_t)a[pos]))) {
                pos = (pos + 1);
            }
            tmp = ((int64_t)a[pos]);
            a[pos] = (int32_t)(item);
            item = tmp;
            while ((pos != start)) {
                pos = cycle_sort_x_rank_of(a, n, start, item);
                while ((item == ((int64_t)a[pos]))) {
                    pos = (pos + 1);
                }
                tmp = ((int64_t)a[pos]);
                a[pos] = (int32_t)(item);
                item = tmp;
            }
        }
        start = (start + 1);
    }
}

}  // namespace detail

inline void cycle_sort(std::vector<int>& v) {
    detail::cycle_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
