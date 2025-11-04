#include "bitonic_sort.h"
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

void compare_and_swap(int arr[], int i, int j, int dir, FILE* trace_file) {
    if (trace_file != NULL) {
        fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, j);
    }
    if (dir == (arr[i] > arr[j])) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i, j);
        }
    }
}

void bitonic_merge(int arr[], int low, int cnt, int dir, FILE* trace_file) {
    if (cnt > 1) {
        int k = cnt / 2;
        for (int i = low; i < low + k; i++) {
            compare_and_swap(arr, i, i + k, dir, trace_file);
        }
        bitonic_merge(arr, low, k, dir, trace_file);
        bitonic_merge(arr, low + k, k, dir, trace_file);
    }
}

void bitonic_sort_recursive(int arr[], int low, int cnt, int dir, FILE* trace_file) {
    if (cnt > 1) {
        int k = cnt / 2;
        bitonic_sort_recursive(arr, low, k, 1, trace_file);
        bitonic_sort_recursive(arr, low + k, k, 0, trace_file);
        bitonic_merge(arr, low, cnt, dir, trace_file);
    }
}

void bitonic_sort(int arr[], int n, FILE* trace_file) {
    if (n == 0) {
        return;
    }

    if (trace_file != NULL) {
        fprintf(trace_file, "{\"initial_array\": [");
        for (int i = 0; i < n; i++) {
            fprintf(trace_file, "%d", arr[i]);
            if (i < n - 1) {
                fprintf(trace_file, ",");
            }
        }
        fprintf(trace_file, "], \"steps\": [");
    }

    int next_power_of_2 = 1;
    while (next_power_of_2 < n) {
        next_power_of_2 *= 2;
    }

    int* padded_arr = (int*)malloc(sizeof(int) * next_power_of_2);
    for (int i = 0; i < n; i++) {
        padded_arr[i] = arr[i];
    }
    for (int i = n; i < next_power_of_2; i++) {
        padded_arr[i] = INT_MAX;
    }

    bitonic_sort_recursive(padded_arr, 0, next_power_of_2, 1, trace_file);

    for (int i = 0; i < n; i++) {
        arr[i] = padded_arr[i];
    }

    free(padded_arr);

    if (trace_file != NULL) {
        fprintf(trace_file, "]}");
    }
}

#ifdef STANDALONE_APP
int* read_array_from_file(const char* filename, int* size) {
    FILE* file = fopen(filename, "r");
    if (file == NULL) {
        perror("Error opening input file");
        return NULL;
    }

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

    bitonic_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
