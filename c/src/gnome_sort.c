#include "../sorting_algorithms.h"

void gnome_sort(int *arr, size_t n) {
    size_t idx = 0;
    while (idx < n) {
        if (idx == 0 || arr[idx] >= arr[idx - 1]) {
            idx++;
        } else {
            int tmp = arr[idx]; arr[idx] = arr[idx - 1]; arr[idx - 1] = tmp;
            idx--;
        }
    }
}
