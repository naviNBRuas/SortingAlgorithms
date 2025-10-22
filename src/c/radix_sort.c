#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "radix_sort.h"

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

// A function to do counting sort of arr[] according to
// the digit represented by exp.
void counting_sort_for_radix(int arr[], int n, int exp, FILE* trace_file, int* first_step_ptr) {
    int* output = (int*)malloc(n * sizeof(int)); // output array
    int count[10] = {0}; // initialize count array with all zeros

    if (output == NULL) {
        perror("Memory allocation failed for output array");
        return;
    }

    // Store count of occurrences in count[]
    for (int i = 0; i < n; i++) {
        count[(arr[i] / exp) % 10]++;
    }

    // Change count[i] so that count[i] now contains actual position of this digit in output[]
    for (int i = 1; i < 10; i++) {
        count[i] += count[i - 1];
    }

    // Build the output array
    for (int i = n - 1; i >= 0; i--) {
        int digit = (arr[i] / exp) % 10;
        output[count[digit] - 1] = arr[i];
        count[digit]--;

        // Log the move/placement for visualization
        if (!(*first_step_ptr)) {
            fprintf(trace_file, ",");
        }
        // For radix sort, logging individual element moves is complex.
        // We can log the state of the array after each pass of counting sort.
        // For now, let's just log a generic 'pass' event or skip detailed tracing here.
        // To fit the 'swap' model, we'd need to identify source and destination indices.
        // This is a simplification for now.
        // fprintf(trace_file, "{\"type\": \"set\", \"index\": %d, \"value\": %d}", count[digit], arr[i]);
        *first_step_ptr = 0;
    }

    // Copy the output array to arr[], so that arr[] now contains sorted numbers according to current digit
    for (int i = 0; i < n; i++) {
        arr[i] = output[i];
    }

    free(output);
}

// The main function to that sorts arr[] of size n using Radix Sort
void radix_sort(int arr[], int n, FILE* trace_file) {
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

    // Find the maximum number to know number of digits
    int max = get_max(arr, n);

    int first_step = 1;

    // Do counting sort for every digit. Note that instead of passing digit number,
    // exp is passed. exp is 10^i where i is current digit number
    for (int exp = 1; max / exp > 0; exp *= 10) {
        counting_sort_for_radix(arr, n, exp, trace_file, &first_step);
        // After each pass, we can log the current state of the array
        if (!first_step) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"pass\", \"array\": [");
        for (int i = 0; i < n; i++) {
            fprintf(trace_file, "%d", arr[i]);
            if (i < n - 1) {
                fprintf(trace_file, ",");
            }
        }
        fprintf(trace_file, "]}");
        first_step = 0;
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

    radix_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
