#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "gnome_sort.h"

void gnome_sort(int* arr, int n, cJSON* trace) {
    cJSON* initial_array = cJSON_CreateIntArray(arr, n);
    cJSON_AddItemToObject(trace, "initial_array", initial_array);
    cJSON* steps = cJSON_CreateArray();
    cJSON_AddItemToObject(trace, "steps", steps);

    int index = 0;
    while (index < n) {
        if (index == 0) {
            index++;
        }
        if (index < n && arr[index] >= arr[index - 1]) {
            cJSON* step = cJSON_CreateObject();
            cJSON_AddStringToObject(step, "type", "compare");
            cJSON* indices = cJSON_CreateIntArray((int[]){index, index - 1}, 2);
            cJSON_AddItemToObject(step, "indices", indices);
            cJSON_AddItemToArray(steps, step);
            index++;
        } else {
            cJSON* step = cJSON_CreateObject();
            cJSON_AddStringToObject(step, "type", "compare");
            cJSON* indices = cJSON_CreateIntArray((int[]){index, index - 1}, 2);
            cJSON_AddItemToObject(step, "indices", indices);
            cJSON_AddItemToArray(steps, step);

            int temp = arr[index];
            arr[index] = arr[index - 1];
            arr[index - 1] = temp;

            cJSON* swap_step = cJSON_CreateObject();
            cJSON_AddStringToObject(swap_step, "type", "swap");
            cJSON* swap_indices = cJSON_CreateIntArray((int[]){index, index - 1}, 2);
            cJSON_AddItemToObject(swap_step, "indices", swap_indices);
            cJSON_AddItemToArray(steps, swap_step);

            index--;
        }
    }
}
