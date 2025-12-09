#include "../sorting_algorithms.h"

void odd_even_sort(int *arr, size_t n) {
    int sorted = 0;
    while (!sorted) {
        sorted = 1;
        for (size_t i = 1; i + 1 < n; i += 2) {
            if (arr[i] > arr[i + 1]) {
                int tmp = arr[i]; arr[i] = arr[i + 1]; arr[i + 1] = tmp;
                sorted = 0;
            }
        }
        for (size_t i = 0; i + 1 < n; i += 2) {
            if (arr[i] > arr[i + 1]) {
                int tmp = arr[i]; arr[i] = arr[i + 1]; arr[i + 1] = tmp;
                sorted = 0;
            }
        }
    }
}
