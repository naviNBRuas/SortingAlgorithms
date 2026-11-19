// GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline int64_t tournament_sort_x_better(int32_t *vals, int64_t x, int64_t y);
inline void tournament_sort_impl(int32_t *a, int64_t n);

inline int64_t tournament_sort_x_better(int32_t *vals, int64_t x, int64_t y) {
    if ((x < 0)) {
        return y;
    }
    if ((y < 0)) {
        return x;
    }
    if ((((int64_t)vals[x]) <= ((int64_t)vals[y]))) {
        return x;
    }
    return y;
}

inline void tournament_sort_impl(int32_t *a, int64_t n) {
    int64_t size = 0;
    int64_t i = 0;
    int64_t k = 0;
    int64_t w = 0;
    int64_t node = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    int64_t _e3 = 0;
    int64_t _e4 = 0;
    std::vector<int32_t> vals;
    std::vector<int32_t> out;
    std::vector<int32_t> tree;
    if ((n < 2)) {
        return;
    }
    size = 1;
    while ((size < n)) {
        size = (size * 2);
    }
    vals.assign((size_t)k_max(1, n), 0);
    out.assign((size_t)k_max(1, n), 0);
    tree.assign((size_t)k_max(1, (2 * size)), 0);
    i = 0;
    _e1 = (2 * size);
    while ((i < _e1)) {
        tree[i] = (int32_t)((-1));
        i = (i + 1);
    }
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        tree[(size + i)] = (int32_t)(i);
        i = (i + 1);
    }
    i = (size - 1);
    while ((i >= 1)) {
        tree[i] = (int32_t)(tournament_sort_x_better(vals.data(), ((int64_t)tree[(2 * i)]), ((int64_t)tree[((2 * i) + 1)])));
        i = (i - 1);
    }
    k = 0;
    _e3 = n;
    while ((k < _e3)) {
        w = ((int64_t)tree[1]);
        out[k] = (int32_t)(((int64_t)vals[w]));
        node = (size + w);
        tree[node] = (int32_t)((-1));
        node = (node / 2);
        while ((node >= 1)) {
            tree[node] = (int32_t)(tournament_sort_x_better(vals.data(), ((int64_t)tree[(2 * node)]), ((int64_t)tree[((2 * node) + 1)])));
            node = (node / 2);
        }
        k = (k + 1);
    }
    i = 0;
    _e4 = n;
    while ((i < _e4)) {
        a[i] = (int32_t)(((int64_t)out[i]));
        i = (i + 1);
    }
}

}  // namespace detail

inline void tournament_sort(std::vector<int>& v) {
    detail::tournament_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
