#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <string.h>

static void counting_sort_exp(int *arr, size_t n, int exp) {
    int output_n = (int)n; // for index math
    int *output = (int *)malloc(n * sizeof(int));
    int count[10] = {0};
    if (!output) return;
    for (size_t i = 0; i < n; ++i) count[(arr[i] / exp) % 10]++;
    for (int i = 1; i < 10; ++i) count[i] += count[i - 1];
    for (int i = output_n - 1; i >= 0; --i) output[--count[(arr[i] / exp) % 10]] = arr[i];
    memcpy(arr, output, n * sizeof(int));
    free(output);
}

void radix_sort_lsd(int *arr, size_t n) {
    if (n == 0) return;
    int min = arr[0], max = arr[0];
    for (size_t i = 1; i < n; ++i) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }
    if (min < 0) {
        for (size_t i = 0; i < n; ++i) arr[i] -= min;
        max -= min;
    }
    for (int exp = 1; max / exp > 0; exp *= 10) counting_sort_exp(arr, n, exp);
    if (min < 0) {
        for (size_t i = 0; i < n; ++i) arr[i] += min;
    }
}
