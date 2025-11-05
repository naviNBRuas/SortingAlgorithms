#include "patience_sort.h"
#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

// Node for linked list (representing a pile)
typedef struct Node {
    int data;
    struct Node* next;
} Node;

// Pile structure (head of a linked list)
typedef struct Pile {
    Node* head;
    int last_val; // For efficient comparison
} Pile;

// Min-heap for merging piles
typedef struct MinHeapNode {
    int value; // Smallest element from this pile
    int pile_idx; // Index of the pile in the piles array
} MinHeapNode;

typedef struct MinHeap {
    MinHeapNode* arr;
    int size;
    int capacity;
} MinHeap;

// Helper functions for Min-Heap
MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->capacity = capacity;
    heap->size = 0;
    heap->arr = (MinHeapNode*)malloc(sizeof(MinHeapNode) * capacity);
    return heap;
}

void swapMinHeapNode(MinHeapNode* a, MinHeapNode* b) {
    MinHeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->arr[left].value < heap->arr[smallest].value) {
        smallest = left;
    }

    if (right < heap->size && heap->arr[right].value < heap->arr[smallest].value) {
        smallest = right;
    }

    if (smallest != idx) {
        swapMinHeapNode(&heap->arr[smallest], &heap->arr[idx]);
        minHeapify(heap, smallest);
    }
}

int isEmpty(MinHeap* heap) {
    return heap->size == 0;
}

MinHeapNode extractMin(MinHeap* heap) {
    if (isEmpty(heap))
        return (MinHeapNode){INT_MAX, -1};

    MinHeapNode root = heap->arr[0];
    heap->arr[0] = heap->arr[heap->size - 1];
    heap->size--;
    minHeapify(heap, 0);
    return root;
}

void insertMinHeap(MinHeap* heap, int value, int pile_idx) {
    if (heap->size == heap->capacity) {
        // Handle re-allocation if needed, or error
        return;
    }

    heap->size++;
    int i = heap->size - 1;
    heap->arr[i] = (MinHeapNode){value, pile_idx};

    while (i != 0 && heap->arr[(i - 1) / 2].value > heap->arr[i].value) {
        swapMinHeapNode(&heap->arr[i], &heap->arr[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}


void patience_sort(int arr[], int n, FILE* trace_file) {
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

    // Create piles
    Pile* piles = NULL;
    int num_piles = 0;
    int piles_capacity = 1; 
    piles = (Pile*)malloc(sizeof(Pile) * piles_capacity);

    for (int i = 0; i < n; i++) {
        int element = arr[i];
        int placed = 0;

        for (int j = 0; j < num_piles; j++) {
            if (element >= piles[j].last_val) {
                Node* new_node = newNode(element);
                new_node->next = piles[j].head;
                piles[j].head = new_node;
                piles[j].last_val = element;
                placed = 1;
                break;
            }
        }

        if (!placed) {
            if (num_piles == piles_capacity) {
                piles_capacity *= 2;
                piles = (Pile*)realloc(piles, sizeof(Pile) * piles_capacity);
            }
            piles[num_piles].head = newNode(element);
            piles[num_piles].last_val = element;
            num_piles++;
        }
    }

    // Merge piles using a min-heap
    MinHeap* min_heap = createMinHeap(num_piles);
    for (int i = 0; i < num_piles; i++) {
        if (piles[i].head != NULL) {
            insertMinHeap(min_heap, piles[i].head->data, i);
        }
    }

    int current_arr_idx = 0;
    while (!isEmpty(min_heap)) {
        MinHeapNode extracted = extractMin(min_heap);
        arr[current_arr_idx++] = extracted.value;
        if (trace_file != NULL) {
            fprintf(trace_file, ",{\"type\": \"insert\", \"indices\": [%d], \"value\": %d}", current_arr_idx - 1, extracted.value);
        }

        int pile_idx = extracted.pile_idx;
        Node* temp = piles[pile_idx].head;
        piles[pile_idx].head = piles[pile_idx].head->next;
        free(temp);

        if (piles[pile_idx].head != NULL) {
            insertMinHeap(min_heap, piles[pile_idx].head->data, pile_idx);
        }
    }

    // Free memory
    for (int i = 0; i < num_piles; i++) {
        Node* current = piles[i].head;
        while (current != NULL) {
            Node* next = current->next;
            free(current);
            current = next;
        }
    }
    free(piles);
    free(min_heap->arr);
    free(min_heap);

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

    patience_sort(arr, n, trace_file);

    printf("Sorted array: \n");
    print_array(arr, n);

    fclose(trace_file);
    free(arr);
    return 0;
}
#endif
