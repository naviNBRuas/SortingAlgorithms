#include "american_flag_sort.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// Helper function for recursive American Flag Sort
void american_flag_sort_recursive(int arr[], int low, int high, int byte_index, FILE* trace_file) {
    if (high - low <= 1 || byte_index >= sizeof(int)) { // Assuming integers up to 4 bytes
        return;
    }

    int counts[256] = {0};
    for (int i = low; i < high; i++) {
        int byte_val = (arr[i] >> (byte_index * 8)) & 0xFF;
        counts[byte_val]++;
    }

    int starts[256];
    starts[0] = low;
    for (int i = 1; i < 256; i++) {
        starts[i] = starts[i - 1] + counts[i - 1];
    }

    // Create a copy of starts for partitioning
    int* current_starts = (int*)malloc(sizeof(int) * 256);
    if (current_starts == NULL) {
        perror("Memory allocation failed");
        return;
    }
    memcpy(current_starts, starts, sizeof(int) * 256);

    for (int i = 0; i < 256; i++) {
        if (counts[i] == 0) { // Skip empty buckets
            continue;
        }

        int j = current_starts[i];
        while (j < starts[i] + counts[i]) {
            int byte_val = (arr[j] >> (byte_index * 8)) & 0xFF;
            if (byte_val == i) {
                j++;
            } else {
                int target_index = current_starts[byte_val];
                int temp = arr[j];
                arr[j] = arr[target_index];
                arr[target_index] = temp;
                if (trace_file != NULL) {
                    fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", j, target_index);
                }
                current_starts[byte_val]++;
            }
        }
    }
    free(current_starts);

    // Recursively sort each bucket
    int current_pos = low;
    for (int i = 0; i < 256; i++) {
        if (counts[i] > 0) {
            american_flag_sort_recursive(arr, current_pos, current_pos + counts[i], byte_index + 1, trace_file);
            current_pos += counts[i];
        }
    }
}

void american_flag_sort(int arr[], int n, FILE* trace_file) {
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

    american_flag_sort_recursive(arr, 0, n, 0, trace_file);

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

    american_flag_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
