#include "flash_sort.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

void flash_sort(int arr[], int n, FILE* trace_file) {
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

    int m = (int)(0.45 * n);
    if (m == 0) m = 1;

    int* l = (int*)calloc(m, sizeof(int));
    if (l == NULL) {
        perror("Memory allocation failed");
        return;
    }

    int min_val = arr[0];
    int max_val = arr[0];
    for (int i = 1; i < n; i++) {
        if (arr[i] < min_val) {
            min_val = arr[i];
        }
        if (arr[i] > max_val) {
            max_val = arr[i];
        }
    }

    if (min_val == max_val) {
        free(l);
        return;
    }

    double c = (double)(m - 1) / (max_val - min_val);

    for (int i = 0; i < n; i++) {
        int k = (int)(c * (arr[i] - min_val));
        l[k]++;
    }

    for (int i = 1; i < m; i++) {
        l[i] += l[i - 1];
    }

    // Permutation phase
    int flash = arr[l[m - 1] - 1];
    arr[l[m - 1] - 1] = arr[0];
    arr[0] = flash;

    if (trace_file != NULL) {
        fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", 0, l[m-1]-1);
    }

    int j = 0;
    int k = 0;
    int t = 0;
    flash = 0;
    while (t < n - 1) {
        while (j >= l[k]) {
            j++;
            k = (int)(c * (arr[j] - min_val));
        }
        flash = arr[j];
        while (j != l[k]) {
            k = (int)(c * (flash - min_val));
            l[k]--;
            int temp = arr[l[k]];
            arr[l[k]] = flash;
            flash = temp;
            t++;
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", j, l[k]);
            }
        }
    }

    // Insertion sort phase
    for (int i = 1; i < n; i++) {
        int key = arr[i];
        int p = i - 1;
        while (p >= 0 && arr[p] > key) {
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", p, i);
            }
            arr[p + 1] = arr[p];
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"shift\", \"indices\": [%d, %d]}", p + 1, p);
            }
            p--;
        }
        arr[p + 1] = key;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"insert\", \"indices\": [%d]}", p + 1);
        }
    }

    free(l);

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

    flash_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
