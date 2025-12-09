#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <string.h>

#define MIN_RUN 32

static size_t min_run_length(size_t n) {
    size_t r = 0;
    while (n >= MIN_RUN) { r |= n & 1; n >>= 1; }
    return n + r;
}

static void insertion_sort_range(int *arr, size_t left, size_t right) {
    for (size_t i = left + 1; i <= right; ++i) {
        int key = arr[i];
        size_t j = i;
        while (j > left && arr[j - 1] > key) { arr[j] = arr[j - 1]; --j; }
        arr[j] = key;
    }
}

static void merge(int *arr, size_t l, size_t m, size_t r) {
    size_t len1 = m - l + 1;
    size_t len2 = r - m;
    int *left = (int *)malloc(len1 * sizeof(int));
    int *right = (int *)malloc(len2 * sizeof(int));
    if (!left || !right) { free(left); free(right); return; }
    memcpy(left, arr + l, len1 * sizeof(int));
    memcpy(right, arr + m + 1, len2 * sizeof(int));
    size_t i = 0, j = 0, k = l;
    while (i < len1 && j < len2) arr[k++] = (left[i] <= right[j]) ? left[i++] : right[j++];
    while (i < len1) arr[k++] = left[i++];
    while (j < len2) arr[k++] = right[j++];
    free(left); free(right);
}

void tim_sort(int *arr, size_t n) {
    if (n <= 1) return;
    size_t min_run = min_run_length(n);
    for (size_t i = 0; i < n; i += min_run) {
        size_t right = i + min_run - 1;
        if (right >= n) right = n - 1;
        insertion_sort_range(arr, i, right);
    }
    for (size_t size = min_run; size < n; size *= 2) {
        for (size_t left = 0; left < n; left += 2 * size) {
            size_t mid = left + size - 1;
            if (mid >= n - 1) break;
            size_t right = left + 2 * size - 1;
            if (right >= n) right = n - 1;
            merge(arr, left, mid, right);
        }
    }
}
