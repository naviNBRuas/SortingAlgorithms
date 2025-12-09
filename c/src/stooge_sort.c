#include "../sorting_algorithms.h"

static void stooge_sort_rec(int *arr, size_t l, size_t h) {
    if (l >= h) return;
    if (arr[l] > arr[h]) {
        int tmp = arr[l];
        arr[l] = arr[h];
        arr[h] = tmp;
    }
    size_t len = h - l + 1;
    if (len <= 2) return;
    size_t t = len / 3;
    stooge_sort_rec(arr, l, h - t);
    stooge_sort_rec(arr, l + t, h);
    stooge_sort_rec(arr, l, h - t);
}

void stooge_sort(int *arr, size_t n) {
    if (n == 0) return;
    stooge_sort_rec(arr, 0, n - 1);
}
