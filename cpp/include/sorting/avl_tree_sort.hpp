// GENERATED from kernels/algos/avl_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline int64_t avl_tree_sort_x_height(int32_t *ht, int64_t t);
inline void avl_tree_sort_x_fix(int32_t *lc, int32_t *rc, int32_t *ht, int64_t t);
inline int64_t avl_tree_sort_x_rot_right(int32_t *lc, int32_t *rc, int32_t *ht, int64_t y);
inline int64_t avl_tree_sort_x_rot_left(int32_t *lc, int32_t *rc, int32_t *ht, int64_t x);
inline int64_t avl_tree_sort_x_insert(int32_t *vals, int32_t *lc, int32_t *rc, int32_t *ht, int64_t t, int64_t v);
inline void avl_tree_sort_impl(int32_t *a, int64_t n);

inline int64_t avl_tree_sort_x_height(int32_t *ht, int64_t t) {
    if ((t == 0)) {
        return 0;
    }
    return ((int64_t)ht[(t - 1)]);
}

inline void avl_tree_sort_x_fix(int32_t *lc, int32_t *rc, int32_t *ht, int64_t t) {
    ht[(t - 1)] = (int32_t)((1 + k_max(avl_tree_sort_x_height(ht, ((int64_t)lc[(t - 1)])), avl_tree_sort_x_height(ht, ((int64_t)rc[(t - 1)])))));
}

inline int64_t avl_tree_sort_x_rot_right(int32_t *lc, int32_t *rc, int32_t *ht, int64_t y) {
    int64_t x = 0;
    x = ((int64_t)lc[(y - 1)]);
    lc[(y - 1)] = (int32_t)(((int64_t)rc[(x - 1)]));
    rc[(x - 1)] = (int32_t)(y);
    avl_tree_sort_x_fix(lc, rc, ht, y);
    avl_tree_sort_x_fix(lc, rc, ht, x);
    return x;
}

inline int64_t avl_tree_sort_x_rot_left(int32_t *lc, int32_t *rc, int32_t *ht, int64_t x) {
    int64_t y = 0;
    y = ((int64_t)rc[(x - 1)]);
    rc[(x - 1)] = (int32_t)(((int64_t)lc[(y - 1)]));
    lc[(y - 1)] = (int32_t)(x);
    avl_tree_sort_x_fix(lc, rc, ht, x);
    avl_tree_sort_x_fix(lc, rc, ht, y);
    return y;
}

inline int64_t avl_tree_sort_x_insert(int32_t *vals, int32_t *lc, int32_t *rc, int32_t *ht, int64_t t, int64_t v) {
    int64_t bal = 0;
    int64_t l = 0;
    int64_t r = 0;
    if ((t == 0)) {
        ht[v] = (int32_t)(1);
        return (v + 1);
    }
    if ((((int64_t)vals[v]) < ((int64_t)vals[(t - 1)]))) {
        lc[(t - 1)] = (int32_t)(avl_tree_sort_x_insert(vals, lc, rc, ht, ((int64_t)lc[(t - 1)]), v));
    } else {
        rc[(t - 1)] = (int32_t)(avl_tree_sort_x_insert(vals, lc, rc, ht, ((int64_t)rc[(t - 1)]), v));
    }
    avl_tree_sort_x_fix(lc, rc, ht, t);
    bal = (avl_tree_sort_x_height(ht, ((int64_t)lc[(t - 1)])) - avl_tree_sort_x_height(ht, ((int64_t)rc[(t - 1)])));
    if ((bal > 1)) {
        l = ((int64_t)lc[(t - 1)]);
        if ((avl_tree_sort_x_height(ht, ((int64_t)lc[(l - 1)])) < avl_tree_sort_x_height(ht, ((int64_t)rc[(l - 1)])))) {
            lc[(t - 1)] = (int32_t)(avl_tree_sort_x_rot_left(lc, rc, ht, l));
        }
        return avl_tree_sort_x_rot_right(lc, rc, ht, t);
    }
    if ((bal < (-1))) {
        r = ((int64_t)rc[(t - 1)]);
        if ((avl_tree_sort_x_height(ht, ((int64_t)rc[(r - 1)])) < avl_tree_sort_x_height(ht, ((int64_t)lc[(r - 1)])))) {
            rc[(t - 1)] = (int32_t)(avl_tree_sort_x_rot_right(lc, rc, ht, r));
        }
        return avl_tree_sort_x_rot_left(lc, rc, ht, t);
    }
    return t;
}

inline void avl_tree_sort_impl(int32_t *a, int64_t n) {
    int64_t i = 0;
    int64_t root = 0;
    int64_t node = 0;
    int64_t sp = 0;
    int64_t out = 0;
    int64_t _e1 = 0;
    int64_t _e2 = 0;
    std::vector<int32_t> vals;
    std::vector<int32_t> lc;
    std::vector<int32_t> rc;
    std::vector<int32_t> ht;
    std::vector<int32_t> stack;
    if ((n < 2)) {
        return;
    }
    vals.assign((size_t)k_max(1, n), 0);
    lc.assign((size_t)k_max(1, n), 0);
    rc.assign((size_t)k_max(1, n), 0);
    ht.assign((size_t)k_max(1, n), 0);
    stack.assign((size_t)k_max(1, n), 0);
    i = 0;
    _e1 = n;
    while ((i < _e1)) {
        vals[i] = (int32_t)(((int64_t)a[i]));
        i = (i + 1);
    }
    root = 0;
    i = 0;
    _e2 = n;
    while ((i < _e2)) {
        root = avl_tree_sort_x_insert(vals.data(), lc.data(), rc.data(), ht.data(), root, i);
        i = (i + 1);
    }
    node = root;
    sp = 0;
    out = 0;
    while (((node != 0) || (sp > 0))) {
        if ((node != 0)) {
            stack[sp] = (int32_t)(node);
            sp = (sp + 1);
            node = ((int64_t)lc[(node - 1)]);
        } else {
            sp = (sp - 1);
            node = ((int64_t)stack[sp]);
            a[out] = (int32_t)(((int64_t)vals[(node - 1)]));
            out = (out + 1);
            node = ((int64_t)rc[(node - 1)]);
        }
    }
}

}  // namespace detail

inline void avl_tree_sort(std::vector<int>& v) {
    detail::avl_tree_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
