#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <math.h>

static void swap(int *a, int *b) { int t = *a; *a = *b; *b = t; }

static size_t partition(int *arr, size_t low, size_t high) {
    int pivot = arr[high];
    size_t i = low;
    for (size_t j = low; j < high; ++j) {
        if (arr[j] < pivot) { swap(&arr[i], &arr[j]); ++i; }
    }
    swap(&arr[i], &arr[high]);
    return i;
}

static void heapify(int *arr, size_t n, size_t i, size_t offset) {
    size_t largest = i;
    size_t l = 2 * i + 1;
    size_t r = 2 * i + 2;
    if (l < n && arr[offset + l] > arr[offset + largest]) largest = l;
    if (r < n && arr[offset + r] > arr[offset + largest]) largest = r;
    if (largest != i) { swap(&arr[offset + i], &arr[offset + largest]); heapify(arr, n, largest, offset); }
}

static void heapsort_range(int *arr, size_t low, size_t high) {
    size_t n = high - low + 1;
    for (int i = (int)n / 2 - 1; i >= 0; --i) heapify(arr, n, (size_t)i, low);
    for (int i = (int)n - 1; i > 0; --i) { swap(&arr[low], &arr[low + (size_t)i]); heapify(arr, (size_t)i, 0, low); }
}

static void introsort_rec(int *arr, size_t low, size_t high, int depth_limit) {
    size_t size = high - low + 1;
    if (size <= 16) {
        for (size_t i = low + 1; i <= high; ++i) {
            int key = arr[i];
            size_t j = i;
            while (j > low && arr[j - 1] > key) { arr[j] = arr[j - 1]; --j; }
            arr[j] = key;
        }
        return;
    }
    if (depth_limit == 0) {
        heapsort_range(arr, low, high);
        return;
    }
    size_t p = partition(arr, low, high);
    if (p > low) introsort_rec(arr, low, p - 1, depth_limit - 1);
    if (p + 1 < high) introsort_rec(arr, p + 1, high, depth_limit - 1);
}

void intro_sort(int *arr, size_t n) {
    if (n <= 1) return;
    int depth_limit = (int)(2 * log((double)n));
    introsort_rec(arr, 0, n - 1, depth_limit);
}
