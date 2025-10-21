#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "../../src/c/bogo_sort.h"

// We need to redefine the function signature to remove the FILE* trace_file argument for testing
// This is a temporary workaround for testing, a proper testing framework would handle this better.
void bogo_sort_test_wrapper(int arr[], int n) {
    // Create a dummy file for tracing, as the test wrapper doesn't need to trace
    FILE* dummy_trace_file = fopen("dummy_trace.json", "w");
    if (dummy_trace_file == NULL) {
        perror("Error opening dummy trace file");
        exit(1);
    }
    bogo_sort(arr, n, dummy_trace_file);
    fclose(dummy_trace_file);
    remove("dummy_trace.json"); // Clean up the dummy file
}

// Helper function to compare two arrays
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
    bogo_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test empty array passed.\n");
}

void test_single_element_array() {
    int arr[] = {42};
    int expected[] = {42};
    int n = 1;
    bogo_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test single element array passed.\n");
}

void test_two_elements_sorted() {
    int arr[] = {1, 2};
    int expected[] = {1, 2};
    int n = 2;
    bogo_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test two elements sorted passed.\n");
}

void test_two_elements_reverse_sorted() {
    int arr[] = {2, 1};
    int expected[] = {1, 2};
    int n = 2;
    bogo_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test two elements reverse sorted passed.\n");
}

void test_small_random_array() {
    int arr[] = {3, 1, 2};
    int expected[] = {1, 2, 3};
    int n = 3;
    bogo_sort_test_wrapper(arr, n);
    assert(compare_arrays(arr, expected, n));
    printf("Test small random array passed.\n");
}

int main() {
    test_empty_array();
    test_single_element_array();
    test_two_elements_sorted();
    test_two_elements_reverse_sorted();
    test_small_random_array();
    return 0;
}
