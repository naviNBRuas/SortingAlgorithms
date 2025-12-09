#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <stdbool.h>
#include <time.h>

static bool is_sorted(const int *arr, size_t n) {
    for (size_t i = 1; i < n; ++i) if (arr[i] < arr[i - 1]) return false;
    return true;
}

void bogo_sort(int *arr, size_t n, size_t max_shuffles) {
    if (n <= 1) return;
    srand((unsigned int)time(NULL));
    size_t count = 0;
    while (!is_sorted(arr, n) && count < max_shuffles) {
        for (size_t i = 0; i < n; ++i) {
            size_t j = (size_t)(rand() % n);
            int tmp = arr[i]; arr[i] = arr[j]; arr[j] = tmp;
        }
        count++;
    }
}
