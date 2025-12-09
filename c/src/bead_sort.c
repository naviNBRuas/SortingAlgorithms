#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <string.h>

void bead_sort(int *arr, size_t n) {
    if (n == 0) return;
    int min = arr[0], max = arr[0];
    for (size_t i = 1; i < n; ++i) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }
    if (min < 0) { counting_sort(arr, n); return; }
    unsigned char *grid = (unsigned char *)calloc(n * max, sizeof(unsigned char));
    if (!grid) return;
    for (size_t i = 0; i < n; ++i) {
        for (int j = 0; j < arr[i]; ++j) grid[i * max + j] = 1;
    }
    for (int j = 0; j < max; ++j) {
        size_t sum = 0;
        for (size_t i = 0; i < n; ++i) sum += grid[i * max + j];
        for (size_t i = n; i-- > 0;) {
            grid[i * max + j] = (sum > 0);
            if (sum > 0) sum--;
        }
    }
    for (size_t i = 0; i < n; ++i) {
        int j;
        for (j = 0; j < max && grid[i * max + j]; ++j);
        arr[i] = j;
    }
    free(grid);
}
