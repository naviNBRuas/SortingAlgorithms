#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "bogo_sort.h"

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

// Function to check if array is sorted
int is_sorted(int arr[], int n, FILE* trace_file, int* step_counter) {
    for (int i = 0; i < n - 1; i++) {
        if (*step_counter > 0) {
            fprintf(trace_file, ",");
        }
        fprintf(trace_file, "{\"type\": \"compare\", \"indices\": [%d, %d]}", i, i + 1);
        (*step_counter)++;
        if (arr[i] > arr[i + 1]) {
            return 0;
        }
    }
    return 1;
}

// Function to shuffle the array (Fisher-Yates algorithm)
void shuffle(int arr[], int n, FILE* trace_file, int* step_counter) {
    for (int i = n - 1; i > 0; i--) {
        int j = rand() % (i + 1);
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
    }
    if (*step_counter > 0) {
        fprintf(trace_file, ",");
    }
    fprintf(trace_file, "{\"type\": \"shuffle\", \"array_state\": [");
    for (int i = 0; i < n; i++) {
        fprintf(trace_file, "%d", arr[i]);
        if (i < n - 1) {
            fprintf(trace_file, ",");
        }
    }
    fprintf(trace_file, "]}");
    (*step_counter)++;
}

void bogo_sort(int arr[], int n, FILE* trace_file) {
    fprintf(trace_file, "{\"initial_array\": [");
    for (int i = 0; i < n; i++) {
        fprintf(trace_file, "%d", arr[i]);
        if (i < n - 1) {
            fprintf(trace_file, ",");
        }
    }
    fprintf(trace_file, "], \"steps\": [");

    srand(time(NULL)); // Seed the random number generator

    int step_counter = 0;
    while (!is_sorted(arr, n, trace_file, &step_counter)) {
        shuffle(arr, n, trace_file, &step_counter);
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

    bogo_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr); // Free the dynamically allocated array
    return 0;
}
#endif
