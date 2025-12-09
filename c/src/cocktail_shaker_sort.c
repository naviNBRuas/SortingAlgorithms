#include "../sorting_algorithms.h"

void cocktail_shaker_sort(int *arr, size_t n) {
    if (n == 0) return;
    size_t start = 0;
    size_t end = n - 1;
    int swapped = 1;
    while (swapped) {
        swapped = 0;
        for (size_t i = start; i < end; ++i) {
            if (arr[i] > arr[i + 1]) {
                int tmp = arr[i]; arr[i] = arr[i + 1]; arr[i + 1] = tmp;
                swapped = 1;
            }
        }
        if (!swapped) break;
        swapped = 0;
        if (end > 0) end--;
        for (size_t i = end; i > start; --i) {
            if (arr[i - 1] > arr[i]) {
                int tmp = arr[i - 1]; arr[i - 1] = arr[i]; arr[i] = tmp;
                swapped = 1;
            }
        }
        start++;
    }
}
