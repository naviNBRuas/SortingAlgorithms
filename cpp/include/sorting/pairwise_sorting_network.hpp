// GENERATED from kernels/algos/pairwise_sorting_network.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline void pairwise_sorting_network_x_cmp_swap(int32_t *a, int64_t i, int64_t j, int64_t n);
inline void pairwise_sorting_network_impl(int32_t *a, int64_t n);

inline void pairwise_sorting_network_x_cmp_swap(int32_t *a, int64_t i, int64_t j, int64_t n) {
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    if ((j < n)) {
        if ((((int64_t)a[i]) > ((int64_t)a[j]))) {
            _i1 = i;
            _i2 = j;
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
        }
    }
}

inline void pairwise_sorting_network_impl(int32_t *a, int64_t n) {
    int64_t size = 0;
    int64_t step = 0;
    int64_t b = 0;
    int64_t c = 0;
    int64_t e = 0;
    int64_t d = 0;
    size = 1;
    while ((size < n)) {
        size = (size * 2);
    }
    step = 1;
    while ((step < size)) {
        b = step;
        c = 0;
        while ((b < size)) {
            pairwise_sorting_network_x_cmp_swap(a, (b - step), b, n);
            b = (b + 1);
            c = (c + 1);
            if ((c >= step)) {
                c = 0;
                b = (b + step);
            }
        }
        step = (step * 2);
    }
    step = (step / 4);
    e = 1;
    while ((step > 0)) {
        d = e;
        while ((d > 0)) {
            b = ((d + 1) * step);
            c = 0;
            while ((b < size)) {
                pairwise_sorting_network_x_cmp_swap(a, (b - (d * step)), b, n);
                b = (b + 1);
                c = (c + 1);
                if ((c >= step)) {
                    c = 0;
                    b = (b + step);
                }
            }
            d = (d / 2);
        }
        step = (step / 2);
        e = ((e * 2) + 1);
    }
}

}  // namespace detail

inline void pairwise_sorting_network(std::vector<int>& v) {
    detail::pairwise_sorting_network_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()));
}
}  // namespace sorting
