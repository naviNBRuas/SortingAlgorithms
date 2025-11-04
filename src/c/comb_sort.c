#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "comb_sort.h"

void comb_sort(int* arr, int n, cJSON* trace) {
    int gap = n;
    float shrink = 1.3;
    int swapped = 1;

    cJSON* initial_array = cJSON_CreateIntArray(arr, n);
    cJSON_AddItemToObject(trace, "initial_array", initial_array);
    cJSON* steps = cJSON_CreateArray();
    cJSON_AddItemToObject(trace, "steps", steps);

    while (gap > 1 || swapped) {
        gap = (int)(gap / shrink);
        if (gap < 1) {
            gap = 1;
        }

        swapped = 0;
        for (int i = 0; i < n - gap; i++) {
            cJSON* step = cJSON_CreateObject();
            cJSON_AddStringToObject(step, "type", "compare");
            cJSON* indices = cJSON_CreateIntArray((int[]){i, i + gap}, 2);
            cJSON_AddItemToObject(step, "indices", indices);
            cJSON_AddItemToArray(steps, step);

            if (arr[i] > arr[i + gap]) {
                int temp = arr[i];
                arr[i] = arr[i + gap];
                arr[i + gap] = temp;
                swapped = 1;

                cJSON* swap_step = cJSON_CreateObject();
                cJSON_AddStringToObject(swap_step, "type", "swap");
                cJSON* swap_indices = cJSON_CreateIntArray((int[]){i, i + gap}, 2);
                cJSON_AddItemToObject(swap_step, "indices", swap_indices);
                cJSON_AddItemToArray(steps, swap_step);
            }
        }
    }
}
