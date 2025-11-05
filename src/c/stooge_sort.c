#include "stooge_sort.h"
#include <stdio.h>
#include <stdlib.h>

void stooge_sort_recursive(int arr[], int i, int j, FILE* trace_file) {
    if (trace_file != NULL) {
        fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, j);
    }
    if (arr[i] > arr[j]) {
        int temp = arr[i];
        arr[i] = arr[j];
        arr[j] = temp;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i, j);
        }
    }

    if (i + 1 >= j) {
        return;
    }

    int t = (j - i + 1) / 3;

    stooge_sort_recursive(arr, i, j - t, trace_file);
    stooge_sort_recursive(arr, i + t, j, trace_file);
    stooge_sort_recursive(arr, i, j - t, trace_file);
}

void stooge_sort(int arr[], int n, FILE* trace_file) {
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
        fprintf(trace_file, "]", "steps": [");
    }

    stooge_sort_recursive(arr, 0, n - 1, trace_file);

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

    stooge_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
