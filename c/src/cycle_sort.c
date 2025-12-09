#include "../sorting_algorithms.h"

void cycle_sort(int *arr, size_t n) {
    for (size_t cycle_start = 0; cycle_start + 1 < n; ++cycle_start) {
        int item = arr[cycle_start];
        size_t pos = cycle_start;
        for (size_t i = cycle_start + 1; i < n; ++i) if (arr[i] < item) pos++;
        if (pos == cycle_start) continue;
        while (pos < n && item == arr[pos]) pos++;
        int tmp = arr[pos]; arr[pos] = item; item = tmp;
        while (pos != cycle_start) {
            pos = cycle_start;
            for (size_t i = cycle_start + 1; i < n; ++i) if (arr[i] < item) pos++;
            while (pos < n && item == arr[pos]) pos++;
            tmp = arr[pos]; arr[pos] = item; item = tmp;
        }
    }
}
