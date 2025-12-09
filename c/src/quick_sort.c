#include "../sorting_algorithms.h"

static size_t partition(int *arr, size_t lo, size_t hi) {
    int pivot = arr[hi];
    size_t i = lo;
    for (size_t j = lo; j < hi; ++j) {
        if (arr[j] <= pivot) {
            int tmp = arr[i]; arr[i] = arr[j]; arr[j] = tmp;
            ++i;
        }
    }
    int tmp = arr[i]; arr[i] = arr[hi]; arr[hi] = tmp;
    return i;
}

static void quick_sort_impl(int *arr, size_t lo, size_t hi) {
    if (lo < hi) {
        size_t p = partition(arr, lo, hi);
        if (p > 0) quick_sort_impl(arr, lo, p - 1);
        quick_sort_impl(arr, p + 1, hi);
    }
}

void quick_sort(int *arr, size_t n) {
    if (n > 0) quick_sort_impl(arr, 0, n - 1);
}
