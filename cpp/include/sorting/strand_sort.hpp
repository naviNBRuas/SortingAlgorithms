// GENERATED from kernels/algos/strand_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void strand_sort_impl(int32_t *a, int64_t n);

inline void strand_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t left = 0;
    int64_t o = 0;
    int64_t s = 0;
    int64_t keep = 0;
    int64_t j = 0;
    int64_t k = 0;
    int64_t x = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    std::vector<int32_t> rem;
    std::vector<int32_t> strand;
    std::vector<int32_t> out;
    std::vector<int32_t> tmp;
    if ((n < 2)) {
        return;
    }
    rem.assign((size_t)k_max(1, n), 0);
    strand.assign((size_t)k_max(1, n), 0);
    out.assign((size_t)k_max(1, n), 0);
    tmp.assign((size_t)k_max(1, n), 0);
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        rem[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    left = n;
    o = 0;
    while ((left > 0)) {
        strand[0] = (int32_t)(((int64_t)rem[0]));
        s = 1;
        keep = 0;
        i = 1;
        _e2 = left;
        while ((i < _e2)) {
            if ((((int64_t)rem[i]) >= ((int64_t)strand[(s - 1)]))) {
                strand[s] = (int32_t)(((int64_t)rem[i]));
                s = (s + 1);
            } else {
                rem[keep] = (int32_t)(((int64_t)rem[i]));
                keep = (keep + 1);
            }
            i = (i + 1);
        }
        left = keep;
        i = 0;
        j = 0;
        k = 0;
        while (((i < o) && (j < s))) {
            if ((((int64_t)strand[j]) < ((int64_t)out[i]))) {
                tmp[k] = (int32_t)(((int64_t)strand[j]));
                j = (j + 1);
            } else {
                tmp[k] = (int32_t)(((int64_t)out[i]));
                i = (i + 1);
            }
            k = (k + 1);
        }
        while ((i < o)) {
            tmp[k] = (int32_t)(((int64_t)out[i]));
            i = (i + 1);
            k = (k + 1);
        }
        while ((j < s)) {
            tmp[k] = (int32_t)(((int64_t)strand[j]));
            j = (j + 1);
            k = (k + 1);
        }
        o = k;
        x = 0;
        _e3 = o;
        while ((x < _e3)) {
            out[x] = (int32_t)(((int64_t)tmp[x]));
            x = (x + 1);
        }
    }
    i = 0;
    _e4 = n;
    while ((i < _e4)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
}

}  // namespace detail

inline void strand_sort(std::vector<int>& v) {
    detail::strand_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
