#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "merge_sort.h"

// Global flag to manage comma placement in trace file
static int trace_first_step;

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

void merge(int arr[], int l, int m, int r, FILE* trace_file) {
    int i, j, k;
    int n1 = m - l + 1;
    int n2 = r - m;

    // Create temp arrays
    int* L = (int*)malloc(sizeof(int) * n1);
    int* R = (int*)malloc(sizeof(int) * n2);

    // Copy data to temp arrays L[] and R[]
    for (i = 0; i < n1; i++)
        L[i] = arr[l + i];
    for (j = 0; j < n2; j++)
        R[j] = arr[m + 1 + j];

    // Merge the temp arrays back into arr[l..r]
    i = 0; // Initial index of first subarray
    j = 0; // Initial index of second subarray
    k = l; // Initial index of merged subarray
    while (i < n1 && j < n2) {
        if (!trace_first_step) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", l + i, m + 1 + j);
        trace_first_step = 0;

        if (L[i] <= R[j]) {
            arr[k] = L[i];
            i++;
        } else {
            arr[k] = R[j];
            j++;
        }
        if (!trace_first_step) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"merge_write\", \"indices\": [%d], \"value\": %d}", k, arr[k]);
        trace_first_step = 0;
        k++;
    }

    // Copy the remaining elements of L[], if there are any
    while (i < n1) {
        arr[k] = L[i];
        if (!trace_first_step) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"merge_write\", \"indices\": [%d], \"value\": %d}", k, arr[k]);
        trace_first_step = 0;
        i++;
        k++;
    }

    // Copy the remaining elements of R[], if there are any
    while (j < n2) {
        arr[k] = R[j];
        if (!trace_first_step) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"merge_write\", \"indices\": [%d], \"value\": %d}", k, arr[k]);
        trace_first_step = 0;
        j++;
        k++;
    }

    free(L);
    free(R);
}

void merge_sort_recursive(int arr[], int l, int r, FILE* trace_file) {
    if (l < r) {
        int m = l + (r - l) / 2;

        merge_sort_recursive(arr, l, m, trace_file);
        merge_sort_recursive(arr, m + 1, r, trace_file);

        merge(arr, l, m, r, trace_file);
    }
}

void merge_sort(int arr[], int n, FILE* trace_file) {
    fprintf(trace_file, "{\"initial_array\": [");
    for (int i = 0; i < n; i++) {
        fprintf(trace_file, "%d", arr[i]);
        if (i < n - 1) {
            fprintf(trace_file, ",");
        }
    }
    fprintf(trace_file, "], \"steps\": [");

    trace_first_step = 1; // Initialize global flag
    merge_sort_recursive(arr, 0, n - 1, trace_file);

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

    merge_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
