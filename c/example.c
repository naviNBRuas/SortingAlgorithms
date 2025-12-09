#include "sorting_algorithms.h"
#include <stdio.h>

int main(void) {
    int arr[] = {5, 1, 4, 2, 8, -1};
    size_t n = sizeof(arr) / sizeof(arr[0]);
    bubble_sort(arr, n);
    for (size_t i = 0; i < n; ++i) {
        printf("%d ", arr[i]);
    }
    printf("\n");
    return 0;
}
