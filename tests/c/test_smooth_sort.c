#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "../../src/c/smooth_sort.h"

void smooth_sort_test_wrapper(int arr[], int n) {
    FILE* dummy_trace_file = fopen("dummy_trace.json", "w");
    if (dummy_trace_file == NULL) {
        perror("Error opening dummy trace file");
        exit(1);
    }
    smooth_sort(arr, n, dummy_trace_file);
    fclose(dummy_trace_file);
    remove("dummy_trace.json");
}

int compare_arrays(int arr1[], int arr2[], int n) {
    for (int i = 0; i < n; i++) {
        if (arr1[i] != arr2[i]) {
            return 0;
        }
    }
    return 1;
}

void test_empty_array() {
    int arr[] = {};
    int expected[] = {};
    int n = 0;
    smooth_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test empty array passed.\n");
}

void test_single_element_array() {
    int arr[] = {42};
    int expected[] = {42};
    int n = 1;
    smooth_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test single element array passed.\n");
}

void test_sorted_array() {
    int arr[] = {1, 2, 3, 4, 5};
    int expected[] = {1, 2, 3, 4, 5};
    int n = 5;
    smooth_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test sorted array passed.\n");
}

void test_reverse_sorted_array() {
    int arr[] = {5, 4, 3, 2, 1};
    int expected[] = {1, 2, 3, 4, 5};
    int n = 5;
    smooth_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test reverse sorted array passed.\n");
}

void test_array_with_duplicates() {
    int arr[] = {5, 4, 3, 5, 1};
    int expected[] = {1, 3, 4, 5, 5};
    int n = 5;
    smooth_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test array with duplicates passed.\n");
}

void test_random_array() {
    int arr[] = {64, 34, 25, 12, 22, 11, 90};
    int expected[] = {11, 12, 22, 25, 34, 64, 90};
    int n = 7;
    smooth_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test random array passed.\n");
}

int main() {
    test_empty_array();
    test_single_element_array();
    test_sorted_array();
    test_reverse_sorted_array();
    test_array_with_duplicates();
    test_random_array();
    return 0;
}
