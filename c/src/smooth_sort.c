#include "../sorting_algorithms.h"
#include <stddef.h>

// Simplified smoothsort (Dijkstra-inspired) with safety fallback to heap_sort for large n
static const size_t leonardo[] = {1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753};
static const size_t LEONARDO_COUNT = sizeof(leonardo) / sizeof(leonardo[0]);

static void swap(int *a, int *b) { int t = *a; *a = *b; *b = t; }

static void sift(int *arr, size_t head, size_t order) {
    while (order > 1) {
        size_t right = head - 1;
        size_t left = head - 1 - leonardo[order - 2];
        size_t largest = head;
        if (arr[left] > arr[largest]) largest = left;
        if (arr[right] > arr[largest]) largest = right;
        if (largest == head) break;
        swap(&arr[head], &arr[largest]);
        head = largest;
        order -= (largest == left) ? 1 : 2;
    }
}

static void trinkle(int *arr, size_t head, size_t order, size_t p) {
    while (p > 0) {
        while ((p & 1) == 0) { p >>= 1; order++; }
        size_t stepson = head - leonardo[order];
        if (arr[stepson] <= arr[head]) break;
        swap(&arr[head], &arr[stepson]);
        head = stepson;
        p >>= 1;
        if (order < 2) order = 0; else order -= 2;
        sift(arr, head, order);
    }
}

void smooth_sort(int *arr, size_t n) {
    if (n <= 1) return;
    if (n > leonardo[LEONARDO_COUNT - 1]) { heap_sort(arr, n); return; }
    size_t head = 0;
    size_t p = 1;
    size_t order = 1;
    for (; head + 1 < n; ++head, ++p) {
        if ((p & 7) == 3) { sift(arr, head, order); p = (p + 1) >> 2; order += 2; }
        else if ((p & 3) == 1) {
            if (head >= leonardo[order - 1]) { trinkle(arr, head, order, p); }
            else { sift(arr, head, order); }
            while (order > 1) { order -= 2; p = (p << 2) + 1; }
        }
    }
    trinkle(arr, head, order, p);
    while (order > 1) {
        head -= leonardo[order];
        p = (p << 1) + 1;
        trinkle(arr, head + leonardo[order - 1], order - 1, p & ~1);
        trinkle(arr, head, order - 2, p >> 1);
        order -= 2;
    }
}
