#include "../sorting_algorithms.h"

void comb_sort(int *arr, size_t n) {
    double shrink = 1.3;
    size_t gap = n;
    int swapped = 1;
    while (gap > 1 || swapped) {
        gap = (size_t)(gap / shrink);
        if (gap < 1) gap = 1;
        swapped = 0;
        for (size_t i = 0; i + gap < n; ++i) {
            size_t j = i + gap;
            if (arr[i] > arr[j]) {
                int tmp = arr[i]; arr[i] = arr[j]; arr[j] = tmp;
                swapped = 1;
            }
        }
    }
}
