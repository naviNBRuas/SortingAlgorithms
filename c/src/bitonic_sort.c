#include "../sorting_algorithms.h"

static void cmp_swap(int *a, size_t i, size_t j) {
    if (a[i] > a[j]) { int t = a[i]; a[i] = a[j]; a[j] = t; }
}

/* Ascending-only bitonic network (flip-first formulation). Comparators that fall
 * outside the array are skipped, which is equivalent to padding with +infinity,
 * so any length n works. */
void bitonic_sort(int *arr, size_t n) {
    size_t size = 1;
    while (size < n) size <<= 1;
    for (size_t k = 2; k <= size; k <<= 1) {
        for (size_t blk = 0; blk < size; blk += k)
            for (size_t t = 0; t < k / 2; ++t) {
                size_t j = blk + k - 1 - t;
                if (j < n) cmp_swap(arr, blk + t, j);
            }
        for (size_t j = k / 4; j >= 1; j >>= 1)
            for (size_t i = 0; i < size; ++i)
                if (!(i & j) && i + j < n) cmp_swap(arr, i, i + j);
    }
}
