// GENERATED from kernels/algos/sleep_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void sleep_sort_x_fallback(int32_t *a, int64_t n);
inline void sleep_sort_impl(int32_t *a, int64_t n);

inline void sleep_sort_x_fallback(int32_t *a, int64_t n) {
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

inline void sleep_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t rng = 0;
    int64_t t = 0;
    int64_t out = 0;
    int64_t node = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    std::vector<int32_t> head;
    std::vector<int32_t> nxt;
    std::vector<int32_t> vals;
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
        sleep_sort_x_fallback(a, n);
        return;
    }
    head.assign((size_t)k_max(1, rng), 0);
    nxt.assign((size_t)k_max(1, n), 0);
    i = (n - 1);
    while ((i >= 0)) {
        t = (((int64_t)a[i]) - mn);
        nxt[i] = (int32_t)(((int64_t)head[t]));
        head[t] = (int32_t)((i + 1));
        i = (i - 1);
    }
    vals.assign((size_t)k_max(1, n), 0);
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    out = 0;
    t = 0;
    _e3 = rng;
    while ((t < _e3)) {
        node = ((int64_t)head[t]);
        while ((node != 0)) {
            a[out] = (int32_t)(((int64_t)vals[(node - 1)]));
            out = (out + 1);
            node = ((int64_t)nxt[(node - 1)]);
        }
        t = (t + 1);
    }
}

}  // namespace detail

inline void sleep_sort(std::vector<int>& v) {
    detail::sleep_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
