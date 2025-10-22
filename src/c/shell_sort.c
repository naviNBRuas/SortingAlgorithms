#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "shell_sort.h"

// Function to read array from a file
int* read_array_from_file(const char* filename, int* size) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening input file");
        return NULL;
    }

    // Read numbers into a temporary buffer
    int capacity = 10;
    int* arr = (int*)malloc(sizeof(int) * capacity);
    if (arr == NULL) {
        perror("Memory allocation failed");
        fclose(file);
        return NULL;
    }

    *size = 0;
    int num;
    while (fscanf(file, "%d", &num) == 1) {
        if (*size == capacity) {
            capacity *= 2;
            int* new_arr = (int*)realloc(arr, sizeof(int) * capacity);
            if (new_arr == NULL) {
                perror("Memory re-allocation failed");
                free(arr);
                fclose(file);
                return NULL;
            }
            arr = new_arr;
        }
        arr[*size] = num;
        (*size)++;
    }

    fclose(file);
    return arr;
}

void shell_sort(int arr[], int n, FILE* trace_file) {
    fprintf(trace_file, "{\"initial_array\": [");
    for (int i = 0; i < n; i++) {
        fprintf(trace_file, "%d", arr[i]);
        if (i < n - 1) {
            fprintf(trace_file, ",");
        }
    }
    fprintf(trace_file, "], \"steps\": [");

    int first_step = 1;

    // Start with a large gap, then reduce the gap
    for (int gap = n / 2; gap > 0; gap /= 2) {
        // Do a gapped insertion sort for this gap size.
        // The first gap elements arr[0..gap-1] are already in gapped order
        // keep adding one more element until the entire array is gap sorted
        for (int i = gap; i < n; i += 1) {
            // add arr[i] to the elements that have been gap sorted
            // save arr[i] in temp and make a hole at position i
            int temp = arr[i];

            // shift earlier gap-sorted elements up until the correct location for arr[i] is found
            int j;
            for (j = i; j >= gap && arr[j - gap] > temp; j -= gap) {
                if (!first_step) {
                    fprintf(trace_file, ",");
                }
                fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", j - gap, j);
                first_step = 0;

                arr[j] = arr[j - gap];
                fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", j, j - gap);
            }

            // put temp (the original arr[i]) in its correct location
            if (j != i) { // Only log swap if an actual shift happened
                arr[j] = temp;
                // This is not a direct swap, but an insertion. For visualization, we can consider it a move.
                // For simplicity, we'll log a 'set' operation if the value changes position.
                // Or, if we want to strictly follow 'compare' and 'swap', we might need to rethink.
                // For now, let's assume the 'swap' above covers the movement.
            }
        }
    }
    fprintf(trace_file, "]}");
}

void print_array(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

#ifdef STANDALONE_APP
int main(int argc, char *argv[]) {
    if (argc < 3) {
        fprintf(stderr, "Usage: %s <input_data_file> <output_trace_file>\n", argv[0]);
        return 1;
    }

    char* input_filename = argv[1];
    char* trace_filename = argv[2];

    int n = 0;
    int* arr = read_array_from_file(input_filename, &n);
    if (arr == NULL) {
        return 1;
    }

    FILE* trace_file = fopen(trace_filename, "w");
    if (trace_file == NULL) {
        perror("Error opening trace file");
        free(arr);
        return 1;
    }

    printf("Original array: \n");
    print_array(arr, n);

    shell_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
