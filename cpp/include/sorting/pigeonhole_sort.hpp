// GENERATED from kernels/algos/pigeonhole_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void pigeonhole_sort_x_fallback(int32_t *a, int64_t n);
inline void pigeonhole_sort_impl(int32_t *a, int64_t n);

inline void pigeonhole_sort_x_fallback(int32_t *a, int64_t n) {
    int64_t gap = 0;
    int64_t i = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    gap = (n / 2);
    while ((gap > 0)) {
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
        gap = (gap / 2);
    }
}

inline void pigeonhole_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t rng = 0;
    int64_t k = 0;
    int64_t h = 0;
    int64_t c = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    std::vector<int32_t> holes;
    if ((n < 2)) {
        return;
    }
    mn = ((int64_t)a[0]);
    mx = ((int64_t)a[0]);
    i = 1;
    _e1 = n;
    while ((i < _e1)) {
        if ((((int64_t)a[i]) < mn)) {
            mn = ((int64_t)a[i]);
        }
        if ((((int64_t)a[i]) > mx)) {
            mx = ((int64_t)a[i]);
        }
        i = (i + 1);
    }
    rng = ((mx - mn) + 1);
    if ((rng > 4000000)) {
        pigeonhole_sort_x_fallback(a, n);
        return;
    }
    holes.assign((size_t)k_max(1, rng), 0);
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        holes[(((int64_t)a[i]) - mn)] = (int32_t)((((int64_t)holes[(((int64_t)a[i]) - mn)]) + 1));
        i = (i + 1);
    }
    k = 0;
    h = 0;
    _e3 = rng;
    while ((h < _e3)) {
        c = ((int64_t)holes[h]);
        while ((c > 0)) {
            a[k] = (int32_t)((mn + h));
            k = (k + 1);
            c = (c - 1);
        }
        h = (h + 1);
    }
}

}  // namespace detail

inline void pigeonhole_sort(std::vector<int>& v) {
    detail::pigeonhole_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
