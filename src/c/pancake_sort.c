#include "pancake_sort.h"
#include <stdio.h>
#include <stdlib.h>

void flip(int arr[], int i, FILE* trace_file) {
    int start = 0;
    while (start < i) {
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", start, i);
        }
        int temp = arr[start];
        arr[start] = arr[i];
        arr[i] = temp;
        start++;
        i--;
    }
}

int findMax(int arr[], int n) {
    int mi = 0;
    for (int i = 0; i < n; ++i) {
        if (arr[i] > arr[mi]) {
            mi = i;
        }
    }
    return mi;
}

void pancake_sort(int arr[], int n, FILE* trace_file) {
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

    for (int curr_size = n; curr_size > 1; --curr_size) {
        int mi = findMax(arr, curr_size);

        if (mi != curr_size - 1) {
            flip(arr, mi, trace_file);
            flip(arr, curr_size - 1, trace_file);
        }
    }

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

    pancake_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
