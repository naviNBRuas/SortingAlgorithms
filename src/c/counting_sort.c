#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "counting_sort.h"

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

// Helper function to get the maximum value in arr[]
int get_max(int arr[], int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    return max;
}

void counting_sort(int arr[], int n, FILE* trace_file) {
    fprintf(trace_file, "{\"initial_array\": [");
    for (int i = 0; i < n; i++) {
        fprintf(trace_file, "%d", arr[i]);
        if (i < n - 1) {
            fprintf(trace_file, ",");
        }
    }
    fprintf(trace_file, "], \"steps\": [");

    if (n <= 1) {
        fprintf(trace_file, "]}");
        return;
    }

    int max_val = get_max(arr, n);
    int* output = (int*)malloc(n * sizeof(int));
    int* count = (int*)calloc(max_val + 1, sizeof(int));

    if (output == NULL || count == NULL) {
        perror("Memory allocation failed");
        if (output) free(output);
        if (count) free(count);
        fprintf(trace_file, "]}");
        return;
    }

    // Store count of each character
    for (int i = 0; i < n; i++) {
        count[arr[i]]++;
    }

    // Change count[i] so that count[i] now contains actual position of this character in output array
    for (int i = 1; i <= max_val; i++) {
        count[i] += count[i - 1];
    }

    // Build the output array
    int first_step = 1;
    for (int i = n - 1; i >= 0; i--) {
        output[count[arr[i]] - 1] = arr[i];
        count[arr[i]]--;

        // Log the placement for visualization
        if (!first_step) {
            fprintf(trace_file, ",");
        }
        // For counting sort, logging individual element moves is complex.
        // We can log the state of the array after the distribution phase.
        // For now, let's log a 'set' operation if the value changes position.
        fprintf(trace_file, "{\"type\": \"set\", \"index\": %d, \"value\": %d}", count[arr[i]], arr[i]);
        first_step = 0;
    }

    // Copy the output array to arr[], so that arr[] now contains sorted numbers
    for (int i = 0; i < n; i++) {
        arr[i] = output[i];
    }

    fprintf(trace_file, "]}");

    free(output);
    free(count);
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

    counting_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
