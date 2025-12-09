#include "../sorting_algorithms.h"
#include <stdbool.h>

static void bitonic_merge(int *arr, size_t low, size_t cnt, bool dir) {
    if (cnt <= 1) return;
    size_t k = cnt / 2;
    for (size_t i = low; i < low + k; ++i) {
        if ((dir && arr[i] > arr[i + k]) || (!dir && arr[i] < arr[i + k])) {
            int tmp = arr[i];
            arr[i] = arr[i + k];
            arr[i + k] = tmp;
        }
    }
    bitonic_merge(arr, low, k, dir);
    bitonic_merge(arr, low + k, k, dir);
}

static void bitonic_sort_rec(int *arr, size_t low, size_t cnt, bool dir) {
    if (cnt <= 1) return;
    size_t k = cnt / 2;
    bitonic_sort_rec(arr, low, k, true);
    bitonic_sort_rec(arr, low + k, k, false);
    bitonic_merge(arr, low, cnt, dir);
}

void bitonic_sort(int *arr, size_t n) {
    if (n == 0) return;
    bitonic_sort_rec(arr, 0, n, true);
}
