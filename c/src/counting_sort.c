#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <string.h>

void counting_sort(int *arr, size_t n) {
    if (n == 0) return;
    int min = arr[0], max = arr[0];
    for (size_t i = 1; i < n; ++i) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }
    size_t range = (size_t)(max - min + 1);
    int *count = (int *)calloc(range, sizeof(int));
    int *output = (int *)malloc(n * sizeof(int));
    if (!count || !output) {
        free(count);
        free(output);
        return;
    }
    for (size_t i = 0; i < n; ++i) count[arr[i] - min]++;
    for (size_t i = 1; i < range; ++i) count[i] += count[i - 1];
    for (size_t i = n; i-- > 0;) output[--count[arr[i] - min]] = arr[i];
    memcpy(arr, output, n * sizeof(int));
    free(count);
    free(output);
}
