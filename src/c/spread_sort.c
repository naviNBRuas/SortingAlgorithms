#include "spread_sort.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void spread_sort_recursive(int arr[], int low, int high, FILE* trace_file) {
    if (low >= high) {
        return;
    }

    int min_val = arr[low];
    int max_val = arr[low];
    for (int i = low + 1; i <= high; i++) {
        if (arr[i] < min_val) {
            min_val = arr[i];
        }
        if (arr[i] > max_val) {
            max_val = arr[i];
        }
    }

    if (min_val == max_val) {
        return;
    }

    int range = max_val - min_val + 1;
    int* bins = (int*)calloc(range, sizeof(int));
    if (bins == NULL) {
        perror("Memory allocation failed");
        return;
    }

    for (int i = low; i <= high; i++) {
        bins[arr[i] - min_val]++;
    }

    int current_pos = low;
    for (int i = 0; i < range; i++) {
        for (int j = 0; j < bins[i]; j++) {
            arr[current_pos] = min_val + i;
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"insert\", \"indices\": [%d], \"value\": %d}", current_pos, min_val + i);
            }
            current_pos++;
        }
    }

    free(bins);
}

void spread_sort(int arr[], int n, FILE* trace_file) {
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

    spread_sort_recursive(arr, 0, n - 1, trace_file);

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

    spread_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
