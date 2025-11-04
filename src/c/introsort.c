#include "introsort.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

// Function prototypes for helpers
void introsort_helper(int arr[], int start, int end, int max_depth, FILE* trace_file);
void heapsort(int arr[], int start, int end, FILE* trace_file);
void heapify(int arr[], int n, int i, int start, FILE* trace_file);
void insertion_sort(int arr[], int start, int end, FILE* trace_file);
int partition(int arr[], int start, int end, FILE* trace_file);

void introsort(int arr[], int n, FILE* trace_file) {
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

    int max_depth = 2 * floor(log2(n));
    introsort_helper(arr, 0, n - 1, max_depth, trace_file);

    if (trace_file != NULL) {
        fprintf(trace_file, "]}");
    }
}

void introsort_helper(int arr[], int start, int end, int max_depth, FILE* trace_file) {
    if (end - start <= 16) {
        insertion_sort(arr, start, end, trace_file);
        return;
    }

    if (max_depth == 0) {
        heapsort(arr, start, end, trace_file);
        return;
    }

    int pivot = partition(arr, start, end, trace_file);
    introsort_helper(arr, start, pivot - 1, max_depth - 1, trace_file);
    introsort_helper(arr, pivot + 1, end, max_depth - 1, trace_file);
}

int partition(int arr[], int start, int end, FILE* trace_file) {
    int pivot = arr[end];
    int i = start - 1;
    for (int j = start; j < end; j++) {
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", j, end);
        }
        if (arr[j] <= pivot) {
            i++;
            int temp = arr[i];
            arr[i] = arr[j];
            arr[j] = temp;
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i, j);
            }
        }
    }
    int temp = arr[i + 1];
    arr[i + 1] = arr[end];
    arr[end] = temp;
    if (trace_file != NULL) {
        fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i + 1, end);
    }
    return i + 1;
}

void insertion_sort(int arr[], int start, int end, FILE* trace_file) {
    for (int i = start + 1; i <= end; i++) {
        int key = arr[i];
        int j = i - 1;
        while (j >= start && arr[j] > key) {
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", j, i);
            }
            arr[j + 1] = arr[j];
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"shift\", \"indices\": [%d, %d]}", j + 1, j);
            }
            j--;
        }
        arr[j + 1] = key;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"insert\", \"indices\": [%d]}", j + 1);
        }
    }
}

void heapsort(int arr[], int start, int end, FILE* trace_file) {
    int n = end - start + 1;
    for (int i = n / 2 - 1; i >= 0; i--) {
        heapify(arr, n, i, start, trace_file);
    }

    for (int i = n - 1; i > 0; i--) {
        int temp = arr[start];
        arr[start] = arr[start + i];
        arr[start + i] = temp;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", start, start + i);
        }
        heapify(arr, i, 0, start, trace_file);
    }
}

void heapify(int arr[], int n, int i, int start, FILE* trace_file) {
    int largest = i;
    int l = 2 * i + 1;
    int r = 2 * i + 2;

    if (l < n && arr[start + l] > arr[start + largest]) {
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", start + l, start + largest);
        }
        largest = l;
    }

    if (r < n && arr[start + r] > arr[start + largest]) {
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", start + r, start + largest);
        }
        largest = r;
    }

    if (largest != i) {
        int temp = arr[start + i];
        arr[start + i] = arr[start + largest];
        arr[start + largest] = temp;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", start + i, start + largest);
        }
        heapify(arr, n, largest, start, trace_file);
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

    introsort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
