#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "heap_sort.h"

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

// To heapify a subtree rooted with node i which is an index in arr[]
// n is size of heap
void heapify(int arr[], int n, int i, FILE* trace_file, int* first_step_ptr) {
    int largest = i; // Initialize largest as root
    int left = 2 * i + 1; // left child
    int right = 2 * i + 2; // right child

    // If left child is larger than root
    if (left < n) {
        if (!(*first_step_ptr)) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", largest, left);
        *first_step_ptr = 0;
        if (arr[left] > arr[largest]) {
            largest = left;
        }
    }

    // If right child is larger than largest so far
    if (right < n) {
        if (!(*first_step_ptr)) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", largest, right);
        *first_step_ptr = 0;
        if (arr[right] > arr[largest]) {
            largest = right;
        }
    }

    // If largest is not root
    if (largest != i) {
        // Swap arr[i] and arr[largest]
        int temp = arr[i];
        arr[i] = arr[largest];
        arr[largest] = temp;

        if (!(*first_step_ptr)) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"swap\", \"indices\": [%d, %d]}", i, largest);
        *first_step_ptr = 0;

        // Recursively heapify the affected sub-tree
        heapify(arr, n, largest, trace_file, first_step_ptr);
    }
}

// Main function to do heap sort
void heap_sort(int arr[], int n, FILE* trace_file) {
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

    int first_step = 1;

    // Build heap (rearrange array)
    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(arr, n, i, trace_file, &first_step);
    }

    // One by one extract an element from heap
    for (int i = n - 1; i > 0; i--) {
        // Move current root to end
        int temp = arr[0];
        arr[0] = arr[i];
        arr[i] = temp;

        if (!first_step) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"swap\", \"indices\": [%d, %d]}", 0, i);
        first_step = 0;

        // call max heapify on the reduced heap
        heapify(arr, i, 0, trace_file, &first_step);
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

    heap_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
