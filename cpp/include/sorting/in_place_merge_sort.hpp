// GENERATED from kernels/algos/in_place_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void in_place_merge_sort_x_reverse(int32_t *a, int64_t i, int64_t j);
inline void in_place_merge_sort_x_rotate(int32_t *a, int64_t i, int64_t m, int64_t j);
inline void in_place_merge_sort_x_merge(int32_t *a, int64_t lo, int64_t mid, int64_t hi);
inline void in_place_merge_sort_x_rec(int32_t *a, int64_t lo, int64_t hi);
inline void in_place_merge_sort_impl(int32_t *a, int64_t n);

inline void in_place_merge_sort_x_reverse(int32_t *a, int64_t i, int64_t j) {
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    j = (j - 1);
    while ((i < j)) {
        _i1 = i;
        _i2 = j;
        _t1 = ((int64_t)a[_i1]);
        a[_i1] = (int32_t)(((int64_t)a[_i2]));
        a[_i2] = (int32_t)(_t1);
        i = (i + 1);
        j = (j - 1);
    }
}

inline void in_place_merge_sort_x_rotate(int32_t *a, int64_t i, int64_t m, int64_t j) {
    in_place_merge_sort_x_reverse(a, i, m);
    in_place_merge_sort_x_reverse(a, m, j);
    in_place_merge_sort_x_reverse(a, i, j);
}

inline void in_place_merge_sort_x_merge(int32_t *a, int64_t lo, int64_t mid, int64_t hi) {
    int64_t i = 0;
    int64_t pivot = 0;
    int64_t l = 0;
    int64_t h = 0;
    int64_t m = 0;
    int64_t j = 0;
    int64_t nm = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if (((lo >= mid) || (mid >= hi))) {
        return;
    }
    if (((hi - lo) == 2)) {
        if ((((int64_t)a[mid]) < ((int64_t)a[lo]))) {
            _i1 = lo;
            _i2 = mid;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
        return;
    }
    if (((mid - lo) >= (hi - mid))) {
        i = ((lo + mid) / 2);
        pivot = ((int64_t)a[i]);
        l = mid;
        h = hi;
        while ((l < h)) {
            m = ((l + h) / 2);
            if ((((int64_t)a[m]) < pivot)) {
                l = (m + 1);
            } else {
                h = m;
            }
        }
        j = l;
        in_place_merge_sort_x_rotate(a, i, mid, j);
        nm = (i + (j - mid));
        in_place_merge_sort_x_merge(a, lo, i, nm);
        in_place_merge_sort_x_merge(a, (nm + 1), j, hi);
    } else {
        j = ((mid + hi) / 2);
        pivot = ((int64_t)a[j]);
        l = lo;
        h = mid;
        while ((l < h)) {
            m = ((l + h) / 2);
            if ((pivot < ((int64_t)a[m]))) {
                h = m;
            } else {
                l = (m + 1);
            }
        }
        i = l;
        in_place_merge_sort_x_rotate(a, i, mid, (j + 1));
        nm = (i + ((j + 1) - mid));
        in_place_merge_sort_x_merge(a, lo, i, (nm - 1));
        in_place_merge_sort_x_merge(a, nm, (j + 1), hi);
    }
}

inline void in_place_merge_sort_x_rec(int32_t *a, int64_t lo, int64_t hi) {
    int64_t mid = 0;
    if (((hi - lo) < 2)) {
        return;
    }
    mid = ((lo + hi) / 2);
    in_place_merge_sort_x_rec(a, lo, mid);
    in_place_merge_sort_x_rec(a, mid, hi);
    in_place_merge_sort_x_merge(a, lo, mid, hi);
}

inline void in_place_merge_sort_impl(int32_t *a, int64_t n) {
    in_place_merge_sort_x_rec(a, 0, n);
}

}  // namespace detail

inline void in_place_merge_sort(std::vector<int>& v) {
    detail::in_place_merge_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
