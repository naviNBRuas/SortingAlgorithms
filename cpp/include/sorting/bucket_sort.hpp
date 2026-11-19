// GENERATED from kernels/algos/bucket_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void bucket_sort_impl(int32_t *a, int64_t n);

inline void bucket_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t rng = 0;
    int64_t b = 0;
    int64_t lo = 0;
    int64_t hi = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _e6 = 0;
    int64_t _e7 = 0;
    int64_t _e8 = 0;
    std::vector<int32_t> count;
    std::vector<int32_t> out;
    std::vector<int32_t> start;
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
    rng = (mx - mn);
    if ((rng == 0)) {
        return;
    }
    count.assign((size_t)k_max(1, (n + 1)), 0);
    out.assign((size_t)k_max(1, n), 0);
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        count[((((((int64_t)a[i]) - mn) * (n - 1)) / rng) + 1)] = (int32_t)((((int64_t)count[((((((int64_t)a[i]) - mn) * (n - 1)) / rng) + 1)]) + 1));
        i = (i + 1);
    }
    b = 1;
    _e3 = (n + 1);
    while ((b < _e3)) {
        count[b] = (int32_t)((((int64_t)count[b]) + ((int64_t)count[(b - 1)])));
        b = (b + 1);
    }
    start.assign((size_t)k_max(1, (n + 1)), 0);
    b = 0;
    _e4 = (n + 1);
    while ((b < _e4)) {
        start[b] = (int32_t)(((int64_t)count[b]));
        b = (b + 1);
    }
    i = 0;
    _e5 = n;
    while ((i < _e5)) {
        b = (((((int64_t)a[i]) - mn) * (n - 1)) / rng);
        out[((int64_t)count[b])] = (int32_t)(((int64_t)a[i]));
        count[b] = (int32_t)((((int64_t)count[b]) + 1));
        i = (i + 1);
    }
    b = 0;
    _e6 = n;
    while ((b < _e6)) {
        lo = ((int64_t)start[b]);
        hi = ((int64_t)start[(b + 1)]);
        i = (lo + 1);
        _e7 = hi;
        while ((i < _e7)) {
            key = ((int64_t)out[i]);
            j = (i - 1);
            while (((j >= lo) && (((int64_t)out[j]) > key))) {
                out[(j + 1)] = (int32_t)(((int64_t)out[j]));
                j = (j - 1);
            }
            out[(j + 1)] = (int32_t)(key);
            i = (i + 1);
        }
        b = (b + 1);
    }
    i = 0;
    _e8 = n;
    while ((i < _e8)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
}

}  // namespace detail

inline void bucket_sort(std::vector<int>& v) {
    detail::bucket_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
