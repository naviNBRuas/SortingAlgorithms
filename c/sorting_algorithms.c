#include "sorting_algorithms.h"
#include <stdlib.h>

void bubble_sort(int *arr, size_t n) {
    for (size_t i = 0; i < n; ++i) {
        for (size_t j = 0; j + 1 < n - i; ++j) {
            if (arr[j] > arr[j + 1]) {
                int tmp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = tmp;
            }
        }
    }
}

void selection_sort(int *arr, size_t n) {
    for (size_t i = 0; i < n; ++i) {
        size_t min_idx = i;
        for (size_t j = i + 1; j < n; ++j) {
            if (arr[j] < arr[min_idx]) {
                min_idx = j;
            }
        }
        int tmp = arr[i];
        arr[i] = arr[min_idx];
        arr[min_idx] = tmp;
    }
}

void insertion_sort(int *arr, size_t n) {
    for (size_t i = 1; i < n; ++i) {
        int key = arr[i];
        size_t j = i;
        while (j > 0 && arr[j - 1] > key) {
            arr[j] = arr[j - 1];
            --j;
        }
        arr[j] = key;
    }
}

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

static void heapify(int *arr, size_t n, size_t i) {
    size_t largest = i;
    size_t l = 2 * i + 1;
    size_t r = 2 * i + 2;
    if (l < n && arr[l] > arr[largest]) largest = l;
    if (r < n && arr[r] > arr[largest]) largest = r;
    if (largest != i) {
        int tmp = arr[i]; arr[i] = arr[largest]; arr[largest] = tmp;
        heapify(arr, n, largest);
    }
}

void heap_sort(int *arr, size_t n) {
    for (size_t i = n / 2; i-- > 0;) {
        heapify(arr, n, i);
    }
    for (size_t i = n; i-- > 1;) {
        int tmp = arr[0]; arr[0] = arr[i - 1]; arr[i - 1] = tmp;
        heapify(arr, i - 1, 0);
    }
}
