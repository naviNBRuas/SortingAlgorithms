#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <string.h>

void pigeonhole_sort(int *arr, size_t n) {
    if (n == 0) return;
    int min = arr[0], max = arr[0];
    for (size_t i = 1; i < n; ++i) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }
    size_t range = (size_t)(max - min + 1);
    int *holes = (int *)calloc(range, sizeof(int));
    if (!holes) return;
    for (size_t i = 0; i < n; ++i) holes[arr[i] - min]++;
    size_t idx = 0;
    for (size_t i = 0; i < range; ++i) {
        while (holes[i]-- > 0) arr[idx++] = (int)(i + min);
    }
    free(holes);
}
