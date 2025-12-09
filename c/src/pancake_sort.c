#include "../sorting_algorithms.h"

static void flip(int *arr, size_t i) {
    size_t start = 0;
    while (start < i) {
        int tmp = arr[start];
        arr[start] = arr[i];
        arr[i] = tmp;
        ++start;
        --i;
    }
}

void pancake_sort(int *arr, size_t n) {
    for (size_t curr_size = n; curr_size > 1; --curr_size) {
        size_t max_idx = 0;
        for (size_t i = 1; i < curr_size; ++i) {
            if (arr[i] > arr[max_idx]) max_idx = i;
        }
        if (max_idx == curr_size - 1) continue;
        flip(arr, max_idx);
        flip(arr, curr_size - 1);
    }
}
