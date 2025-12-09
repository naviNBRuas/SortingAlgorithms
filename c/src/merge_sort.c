#include "../sorting_algorithms.h"
#include <stdlib.h>

static void merge(int *arr, int *tmp, size_t left, size_t mid, size_t right) {
    size_t i = left, j = mid, k = left;
    while (i < mid && j < right) {
        if (arr[i] <= arr[j]) tmp[k++] = arr[i++];
        else tmp[k++] = arr[j++];
    }
    while (i < mid) tmp[k++] = arr[i++];
    while (j < right) tmp[k++] = arr[j++];
    for (size_t t = left; t < right; ++t) arr[t] = tmp[t];
}

static void merge_sort_impl(int *arr, int *tmp, size_t left, size_t right) {
    if (right - left <= 1) return;
    size_t mid = (left + right) / 2;
    merge_sort_impl(arr, tmp, left, mid);
    merge_sort_impl(arr, tmp, mid, right);
    merge(arr, tmp, left, mid, right);
}

void merge_sort(int *arr, size_t n) {
    int *tmp = malloc(n * sizeof(int));
    if (!tmp) return;
    merge_sort_impl(arr, tmp, 0, n);
    free(tmp);
}
