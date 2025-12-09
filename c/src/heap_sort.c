#include "../sorting_algorithms.h"

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
