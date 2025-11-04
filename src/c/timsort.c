#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "timsort.h"

#define MIN_MERGE 32

// Function to perform insertion sort on a subarray
void insertion_sort(int arr[], int left, int right, FILE* trace_file, int* first_step) {
    for (int i = left + 1; i <= right; i++) {
        int temp = arr[i];
        int j = i - 1;
        while (j >= left && arr[j] > temp) {
            if (!(*first_step)) {
                fprintf(trace_file, ",");
            }
            fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", j, j + 1);
            *first_step = 0;

            arr[j + 1] = arr[j];
            if (!(*first_step)) {
                fprintf(trace_file, ",");
            }
            fprintf(trace_file, "{\"type\": \"swap\", \"indices\": [%d, %d]}", j, j + 1);
            *first_step = 0;
            j--;
        }
        arr[j + 1] = temp;
    }
}

// Function to merge two sorted runs
void merge(int arr[], int l, int m, int r, FILE* trace_file, int* first_step) {
    int len1 = m - l + 1, len2 = r - m;
    int *left = (int*)malloc(len1 * sizeof(int));
    int *right = (int*)malloc(len2 * sizeof(int));

    for (int i = 0; i < len1; i++) {
        left[i] = arr[l + i];
    }
    for (int i = 0; i < len2; i++) {
        right[i] = arr[m + 1 + i];
    }

    int i = 0, j = 0, k = l;

    while (i < len1 && j < len2) {
        if (!(*first_step)) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", l + i, m + 1 + j);
        *first_step = 0;

        if (left[i] <= right[j]) {
            arr[k] = left[i];
            i++;
        } else {
            arr[k] = right[j];
            j++;
        }
        k++;
    }

    while (i < len1) {
        arr[k] = left[i];
        k++;
        i++;
    }

    while (j < len2) {
        arr[k] = right[j];
        k++;
        j++;
    }

    free(left);
    free(right);
}

// Main TimSort function
void timsort(int arr[], int n, FILE* trace_file) {
    fprintf(trace_file, "{\"initial_array\": [");
    for (int i = 0; i < n; i++) {
        fprintf(trace_file, "%d", arr[i]);
        if (i < n - 1) {
            fprintf(trace_file, ",");
        }
    }
    fprintf(trace_file, "], \"steps\": [");

    int first_step = 1;

    // Sort individual subarrays of size MIN_MERGE using insertion sort
    for (int i = 0; i < n; i += MIN_MERGE) {
        insertion_sort(arr, i, ((i + MIN_MERGE - 1) < (n - 1)) ? (i + MIN_MERGE - 1) : (n - 1), trace_file, &first_step);
    }

    // Merge runs of size MIN_MERGE, then 2*MIN_MERGE, then 4*MIN_MERGE, and so on
    for (int size = MIN_MERGE; size < n; size = 2 * size) {
        for (int left = 0; left < n; left += 2 * size) {
            int mid = left + size - 1;
            int right = ((left + 2 * size - 1) < (n - 1)) ? (left + 2 * size - 1) : (n - 1);

            if (mid < right) {
                merge(arr, left, mid, right, trace_file, &first_step);
            }
        }
    }
    fprintf(trace_file, "]}");
}

#ifdef STANDALONE_APP
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

void print_array(int arr[], int size) {
    for (int i = 0; i < size; i++) {
        printf("%d ", arr[i]);
    }
    printf("\n");
}

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

    timsort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
