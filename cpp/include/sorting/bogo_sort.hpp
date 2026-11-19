// GENERATED from kernels/algos/bogo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.
#pragma once
#include <algorithm>
#include <cstddef>
#include <cstdint>
#include <vector>
#include "common.hpp"
namespace sorting {
namespace detail {

inline int64_t bogo_sort_x_is_sorted(int32_t *a, int64_t n);
inline void bogo_sort_impl(int32_t *a, int64_t n, int64_t max_shuffles);

inline int64_t bogo_sort_x_is_sorted(int32_t *a, int64_t n) {
    int64_t i = 0;
    i = 0;
    while (((i + 1) < n)) {
        if ((((int64_t)a[i]) > ((int64_t)a[(i + 1)]))) {
            return 0;
        }
        i = (i + 1);
    }
    return 1;
}

inline void bogo_sort_impl(int32_t *a, int64_t n, int64_t max_shuffles) {
    int64_t state = 0;
    int64_t count = 0;
    int64_t i = 0;
    int64_t _i1 = 0;
    int64_t _i2 = 0;
    int64_t _t1 = 0;
    state = 123456789;
    count = 0;
    while (((bogo_sort_x_is_sorted(a, n) == 0) && (count < max_shuffles))) {
        i = (n - 1);
        while ((i > 0)) {
            state = (((state * 1103515245) + 12345) % 2147483648LL);
            _i1 = i;
            _i2 = ((state / 16) % (i + 1));
            _t1 = ((int64_t)a[_i1]);
            a[_i1] = (int32_t)(((int64_t)a[_i2]));
            a[_i2] = (int32_t)(_t1);
            i = (i - 1);
        }
        count = (count + 1);
    }
}

}  // namespace detail

inline void bogo_sort(std::vector<int>& v, int64_t max_shuffles) {
    detail::bogo_sort_impl(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()), max_shuffles);
}
}  // namespace sorting
