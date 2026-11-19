// GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void bottom_up_heap_sort_x_sift(int32_t *a, int64_t root, int64_t size);
inline void bottom_up_heap_sort_impl(int32_t *a, int64_t n);

inline void bottom_up_heap_sort_x_sift(int32_t *a, int64_t root, int64_t size) {
    int64_t j = 0;
    int64_t x = 0;
    int64_t cur = 0;
    int64_t c = 0;
    j = root;
    while ((((2 * j) + 2) < size)) {
        if ((((int64_t)a[((2 * j) + 1)]) < ((int64_t)a[((2 * j) + 2)]))) {
            j = ((2 * j) + 2);
        } else {
            j = ((2 * j) + 1);
        }
    }
    if ((((2 * j) + 1) < size)) {
        j = ((2 * j) + 1);
    }
    x = ((int64_t)a[root]);
    while ((((int64_t)a[j]) < x)) {
        j = ((j - 1) / 2);
    }
    cur = root;
    while ((cur != j)) {
        c = j;
        while ((((c - 1) / 2) != cur)) {
            c = ((c - 1) / 2);
        }
        a[cur] = (int32_t)(((int64_t)a[c]));
        cur = c;
    }
    a[j] = (int32_t)(x);
}

inline void bottom_up_heap_sort_impl(int32_t *a, int64_t n) {
    int64_t s = 0;
    int64_t end = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    s = (n / 2);
    while ((s > 0)) {
        s = (s - 1);
        bottom_up_heap_sort_x_sift(a, s, n);
    }
    end = (n - 1);
    while ((end > 0)) {
        _i1 = 0;
        _i2 = end;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        bottom_up_heap_sort_x_sift(a, 0, end);
        end = (end - 1);
    }
}

}  // namespace detail

inline void bottom_up_heap_sort(std::vector<int>& v) {
    detail::bottom_up_heap_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
