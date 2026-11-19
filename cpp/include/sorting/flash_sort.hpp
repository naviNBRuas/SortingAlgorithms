// GENERATED from kernels/algos/flash_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void flash_sort_impl(int32_t *a, int64_t n);

inline void flash_sort_impl(int32_t *a, int64_t n) {
    int64_t mn = 0;
    int64_t mx = 0;
    int64_t i = 0;
    int64_t m = 0;
    int64_t rng = 0;
    int64_t s = 0;
    int64_t c = 0;
    int64_t b = 0;
    int64_t d = 0;
    int64_t key = 0;
    int64_t j = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    int64_t _e5 = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    std::vector<int32_t> count;
    std::vector<int32_t> starts;
    std::vector<int32_t> nxt;
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
    if ((mn == mx)) {
        return;
    }
    m = k_max(2, ((43 * n) / 100));
    rng = (mx - mn);
    count.assign((size_t)k_max(1, m), 0);
    starts.assign((size_t)k_max(1, (m + 1)), 0);
    nxt.assign((size_t)k_max(1, m), 0);
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        count[(((((int64_t)a[i]) - mn) * (m - 1)) / rng)] = (int32_t)((((int64_t)count[(((((int64_t)a[i]) - mn) * (m - 1)) / rng)]) + 1));
        i = (i + 1);
    }
    s = 0;
    c = 0;
    _e3 = m;
    while ((c < _e3)) {
        starts[c] = (int32_t)(s);
        nxt[c] = (int32_t)(s);
        s = (s + ((int64_t)count[c]));
        c = (c + 1);
    }
    starts[m] = (int32_t)(s);
    b = 0;
    _e4 = m;
    while ((b < _e4)) {
        while ((((int64_t)nxt[b]) < ((int64_t)starts[(b + 1)]))) {
            d = (((((int64_t)a[((int64_t)nxt[b])]) - mn) * (m - 1)) / rng);
            if ((d == b)) {
                nxt[b] = (int32_t)((((int64_t)nxt[b]) + 1));
            } else {
                _i1 = ((int64_t)nxt[b]);
                _i2 = ((int64_t)nxt[d]);
                _t1 = ((int64_t)a[_i1]);
                a[_i1] = (int32_t)(((int64_t)a[_i2]));
                a[_i2] = (int32_t)(_t1);
                nxt[d] = (int32_t)((((int64_t)nxt[d]) + 1));
            }
        }
        b = (b + 1);
    }
    i = 1;
    _e5 = n;
    while ((i < _e5)) {
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

inline void flash_sort(std::vector<int>& v) {
    detail::flash_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
