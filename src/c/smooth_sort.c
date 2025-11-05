#include "smooth_sort.h"
#include <stdio.h>
#include <stdlib.h>

// Leonardo numbers
static int L[] = {1, 1, 3, 5, 9, 15, 25, 41, 67, 109, 177, 287, 465, 753, 1219, 1973, 3193, 5167, 8361, 13529, 21891, 35421, 57313, 92735, 150049, 242785, 392835, 635621, 1028457, 1664079, 2692537, 4356617, 7049155, 11405773, 18454929, 29860703, 48315633, 78176337, 126491971, 204668309, 331160281, 535828591, 866988873, 1402817465, 2269806339};

void sift(int arr[], int p, int i, FILE* trace_file) {
    while (p > 1) {
        int lc = i - L[p-1];
        int rc = i - L[p-1] + L[p-2];

        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, lc);
        }
        if (arr[i] < arr[lc]) {
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, rc);
            }
            if (arr[i] < arr[rc]) {
                break;
            } else {
                int temp = arr[i];
                arr[i] = arr[rc];
                arr[rc] = temp;
                if (trace_file != NULL) {
                    fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i, rc);
                }
                i = rc;
                p -= 2;
            }
        } else {
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, rc);
            }
            if (arr[i] < arr[rc]) {
                break;
            } else {
                int temp = arr[i];
                arr[i] = arr[lc];
                arr[lc] = temp;
                if (trace_file != NULL) {
                    fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i, lc);
                }
                i = lc;
                p -= 1;
            }
        }
    }
}

void smooth_sort(int arr[], int n, FILE* trace_file) {
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

    int p = 1; // current Leonardo number index
    int b = 1; // current block size

    for (int i = 0; i < n; i++) {
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, i);
        }
        if (b & 1) { // if b is odd
            sift(arr, p, i, trace_file);
        } else {
            if (trace_file != NULL) {
                fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, i-1);
            }
            if (i > 0 && arr[i] < arr[i-1]) {
                int temp = arr[i];
                arr[i] = arr[i-1];
                arr[i-1] = temp;
                if (trace_file != NULL) {
                    fprintf(trace_file, ",{\"type\": \"swap\", \"indices\": [%d, %d]}", i, i-1);
                }
            }
            sift(arr, p, i, trace_file);
        }

        if (p > 1 && L[p-1] == b) {
            p--;
            b = L[p];
        } else {
            p++;
            b = L[p];
        }
    }

    for (int i = n - 1; i >= 0; i--) {
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"compare\", \"indices\": [%d, %d]}", i, i);
        }
        if (p == 1) {
            break;
        }
        if (L[p-1] == b) {
            p--;
            b = L[p];
        } else {
            p--;
            b = L[p];
            sift(arr, p, i, trace_file);
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

    smooth_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
