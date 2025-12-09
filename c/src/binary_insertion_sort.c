#include "../sorting_algorithms.h"
#include <stddef.h>

static size_t binary_search(int *arr, size_t lo, size_t hi, int key) {
    while (lo < hi) {
        size_t mid = lo + (hi - lo) / 2;
        if (arr[mid] <= key) lo = mid + 1;
        else hi = mid;
    }
    return lo;
}

void binary_insertion_sort(int *arr, size_t n) {
    for (size_t i = 1; i < n; ++i) {
        int key = arr[i];
        size_t pos = binary_search(arr, 0, i, key);
        for (size_t j = i; j > pos; --j) {
            arr[j] = arr[j - 1];
        }
        arr[pos] = key;
    }
}
