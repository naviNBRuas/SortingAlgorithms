#include "../sorting_algorithms.h"
#include <stdlib.h>

typedef struct BucketNode {
    int value;
    struct BucketNode *next;
} BucketNode;

static void bucket_insert(BucketNode **bucket, int value) {
    BucketNode *node = (BucketNode *)malloc(sizeof(BucketNode));
    if (!node) return;
    node->value = value;
    node->next = NULL;
    if (!*bucket || (*bucket)->value >= value) {
        node->next = *bucket;
        *bucket = node;
        return;
    }
    BucketNode *curr = *bucket;
    while (curr->next && curr->next->value < value) curr = curr->next;
    node->next = curr->next;
    curr->next = node;
}

void bucket_sort(int *arr, size_t n) {
    if (n == 0) return;
    int min = arr[0], max = arr[0];
    for (size_t i = 1; i < n; ++i) {
        if (arr[i] < min) min = arr[i];
        if (arr[i] > max) max = arr[i];
    }
    size_t bucket_count = n;
    BucketNode **buckets = (BucketNode **)calloc(bucket_count, sizeof(BucketNode *));
    if (!buckets) return;
    double range = (double)(max - min + 1);
    for (size_t i = 0; i < n; ++i) {
        size_t idx = (size_t)(((arr[i] - min) / range) * bucket_count);
        if (idx >= bucket_count) idx = bucket_count - 1;
        bucket_insert(&buckets[idx], arr[i]);
    }
    size_t k = 0;
    for (size_t i = 0; i < bucket_count; ++i) {
        BucketNode *curr = buckets[i];
        while (curr) {
            arr[k++] = curr->value;
            BucketNode *tmp = curr;
            curr = curr->next;
            free(tmp);
        }
    }
    free(buckets);
}
