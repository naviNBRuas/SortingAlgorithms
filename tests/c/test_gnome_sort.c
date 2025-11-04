#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "../../src/c/gnome_sort.h"

void test_gnome_sort() {
    // Test case 1: Unsorted list
    int arr1[] = {64, 34, 25, 12, 22, 11, 90};
    int n1 = sizeof(arr1) / sizeof(arr1[0]);
    int sorted_arr1[] = {11, 12, 22, 25, 34, 64, 90};
    cJSON* trace1 = cJSON_CreateObject();
    gnome_sort(arr1, n1, trace1);
    for (int i = 0; i < n1; i++) {
        assert(arr1[i] == sorted_arr1[i]);
    }
    cJSON_Delete(trace1);

    // Test case 2: Already sorted list
    int arr2[] = {11, 12, 22, 25, 34, 64, 90};
    int n2 = sizeof(arr2) / sizeof(arr2[0]);
    int sorted_arr2[] = {11, 12, 22, 25, 34, 64, 90};
    cJSON* trace2 = cJSON_CreateObject();
    gnome_sort(arr2, n2, trace2);
    for (int i = 0; i < n2; i++) {
        assert(arr2[i] == sorted_arr2[i]);
    }
    cJSON_Delete(trace2);

    // Test case 3: Reverse sorted list
    int arr3[] = {90, 64, 34, 25, 22, 12, 11};
    int n3 = sizeof(arr3) / sizeof(arr3[0]);
    int sorted_arr3[] = {11, 12, 22, 25, 34, 64, 90};
    cJSON* trace3 = cJSON_CreateObject();
    gnome_sort(arr3, n3, trace3);
    for (int i = 0; i < n3; i++) {
        assert(arr3[i] == sorted_arr3[i]);
    }
    cJSON_Delete(trace3);

    // Test case 4: List with duplicate elements
    int arr4[] = {64, 34, 25, 12, 22, 11, 90, 34};
    int n4 = sizeof(arr4) / sizeof(arr4[0]);
    int sorted_arr4[] = {11, 12, 22, 25, 34, 34, 64, 90};
    cJSON* trace4 = cJSON_CreateObject();
    gnome_sort(arr4, n4, trace4);
    for (int i = 0; i < n4; i++) {
        assert(arr4[i] == sorted_arr4[i]);
    }
    cJSON_Delete(trace4);

    // Test case 5: Empty list
    int arr5[] = {};
    int n5 = sizeof(arr5) / sizeof(arr5[0]);
    cJSON* trace5 = cJSON_CreateObject();
    gnome_sort(arr5, n5, trace5);
    assert(n5 == 0);
    cJSON_Delete(trace5);

    // Test case 6: List with one element
    int arr6[] = {42};
    int n6 = sizeof(arr6) / sizeof(arr6[0]);
    int sorted_arr6[] = {42};
    cJSON* trace6 = cJSON_CreateObject();
    gnome_sort(arr6, n6, trace6);
    for (int i = 0; i < n6; i++) {
        assert(arr6[i] == sorted_arr6[i]);
    }
    cJSON_Delete(trace6);
}

int main() {
    test_gnome_sort();
    printf("All Gnome Sort tests passed!\n");
    return 0;
}
