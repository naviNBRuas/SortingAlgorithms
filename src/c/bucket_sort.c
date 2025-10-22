#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "bucket_sort.h"

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

// Helper function to find the maximum element in an array
int get_max(int arr[], int n) {
    int max = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    return max;
}

// Function to perform insertion sort on a bucket
void insertion_sort_bucket(int arr[], int n, FILE* trace_file, int offset) {
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= 0 && arr[j] > key) {
            if (trace_file) {
                // Log comparison within the bucket
                // Adjust indices by offset for global array context
                fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", offset + j, offset + j + 1);
            }
            arr[j + 1] = arr[j];
            if (trace_file) {
                // Log swap/move within the bucket
                fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", offset + j + 1, offset + j);
            }
            j = j - 1;
        }
        arr[j + 1] = key;
    }
}

void bucket_sort(int arr[], int n, FILE* trace_file) {
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
    int num_buckets = 10; // A fixed number of buckets, can be adjusted

    // Create buckets (array of pointers to arrays, or linked lists)
    // For simplicity, let's use a dynamic array for each bucket and reallocate as needed
    // This is a simplified approach and might not be efficient for very large data or many buckets
    int** buckets = (int**)malloc(sizeof(int*) * num_buckets);
    int* bucket_sizes = (int*)calloc(num_buckets, sizeof(int));
    int* bucket_capacities = (int*)malloc(sizeof(int) * num_buckets);

    if (buckets == NULL || bucket_sizes == NULL || bucket_capacities == NULL) {
        perror("Memory allocation failed for buckets");
        if (buckets) free(buckets);
        if (bucket_sizes) free(bucket_sizes);
        if (bucket_capacities) free(bucket_capacities);
        fprintf(trace_file, "]}");
        return;
    }

    for (int i = 0; i < num_buckets; i++) {
        bucket_capacities[i] = n; // Initial capacity for each bucket
        buckets[i] = (int*)malloc(sizeof(int) * bucket_capacities[i]);
        if (buckets[i] == NULL) {
            perror("Memory allocation failed for bucket");
            // Free previously allocated memory
            for (int k = 0; k < i; k++) free(buckets[k]);
            free(buckets);
            free(bucket_sizes);
            free(bucket_capacities);
            fprintf(trace_file, "]}");
            return;
        }
    }

    // Distribute elements into buckets
    int first_step = 1;
    for (int i = 0; i < n; i++) {
        int bucket_idx = (int)((double)arr[i] / (max_val + 1) * num_buckets);
        if (bucket_idx >= num_buckets) bucket_idx = num_buckets - 1; // Handle max_val case

        if (bucket_sizes[bucket_idx] == bucket_capacities[bucket_idx]) {
            bucket_capacities[bucket_idx] *= 2;
            buckets[bucket_idx] = (int*)realloc(buckets[bucket_idx], sizeof(int) * bucket_capacities[bucket_idx]);
            if (buckets[bucket_idx] == NULL) {
                perror("Memory re-allocation failed for bucket");
                // Free all allocated memory
                for (int k = 0; k < num_buckets; k++) free(buckets[k]);
                free(buckets);
                free(bucket_sizes);
                free(bucket_capacities);
                fprintf(trace_file, "]}");
                return;
            }
        }
        buckets[bucket_idx][bucket_sizes[bucket_idx]++] = arr[i];
        // For tracing, we can log a 'move' or 'set' operation here if needed, but it's not a direct swap.
        // Sticking to compare/swap for now, so no log for distribution.
    }

    // Sort each bucket and concatenate
    int index = 0;
    for (int i = 0; i < num_buckets; i++) {
        // Sort the current bucket using insertion sort
        insertion_sort_bucket(buckets[i], bucket_sizes[i], trace_file, index);

        // Concatenate the sorted bucket back into the original array
        for (int j = 0; j < bucket_sizes[i]; j++) {
            arr[index++] = buckets[i][j];
        }
    }

    fprintf(trace_file, "]}");

    // Free allocated memory
    for (int i = 0; i < num_buckets; i++) {
        free(buckets[i]);
    }
    free(buckets);
    free(bucket_sizes);
    free(bucket_capacities);
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

    bucket_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
