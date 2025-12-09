#include "../sorting_algorithms.h"
#include <stdlib.h>
#include <string.h>

void strand_sort(int *arr, size_t n) {
    if (n == 0) return;
    int *input = (int *)malloc(n * sizeof(int));
    int *output = (int *)malloc(n * sizeof(int));
    if (!input || !output) { free(input); free(output); return; }
    memcpy(input, arr, n * sizeof(int));
    size_t in_size = n, out_size = 0;

    while (in_size > 0) {
        int *sub = (int *)malloc(in_size * sizeof(int));
        if (!sub) break;
        size_t sub_size = 0;
        int last = input[0];
        sub[sub_size++] = last;
        size_t new_in_size = 0;
        for (size_t i = 1; i < in_size; ++i) {
            if (input[i] >= last) {
                sub[sub_size++] = input[i];
                last = input[i];
            } else {
                input[new_in_size++] = input[i];
            }
        }
        // merge sub into output
        size_t i = 0, j = 0, k = 0;
        int *merged = (int *)malloc((out_size + sub_size) * sizeof(int));
        if (!merged) { free(sub); break; }
        while (i < out_size && j < sub_size) {
            if (output[i] <= sub[j]) merged[k++] = output[i++];
            else merged[k++] = sub[j++];
        }
        while (i < out_size) merged[k++] = output[i++];
        while (j < sub_size) merged[k++] = sub[j++];
        free(output);
        output = merged;
        out_size = k;
        in_size = new_in_size;
        free(sub);
    }
    memcpy(arr, output, out_size * sizeof(int));
    free(input);
    free(output);
}
