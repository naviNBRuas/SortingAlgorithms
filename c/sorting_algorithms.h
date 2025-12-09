#ifndef SORTING_ALGORITHMS_H
#define SORTING_ALGORITHMS_H

#include <stddef.h>

void bubble_sort(int *arr, size_t n);
void selection_sort(int *arr, size_t n);
void insertion_sort(int *arr, size_t n);
void binary_insertion_sort(int *arr, size_t n);
void merge_sort(int *arr, size_t n);
void quick_sort(int *arr, size_t n);
void heap_sort(int *arr, size_t n);
void shell_sort(int *arr, size_t n);
void comb_sort(int *arr, size_t n);
void cocktail_shaker_sort(int *arr, size_t n);
void odd_even_sort(int *arr, size_t n);
void gnome_sort(int *arr, size_t n);
void cycle_sort(int *arr, size_t n);
void pancake_sort(int *arr, size_t n);
void stooge_sort(int *arr, size_t n);
void bitonic_sort(int *arr, size_t n);
void counting_sort(int *arr, size_t n);
void radix_sort_lsd(int *arr, size_t n);
void bucket_sort(int *arr, size_t n);
void pigeonhole_sort(int *arr, size_t n);
void bead_sort(int *arr, size_t n);
void tree_sort(int *arr, size_t n);
void patience_sort(int *arr, size_t n);
void strand_sort(int *arr, size_t n);
void bogo_sort(int *arr, size_t n, size_t max_shuffles);
void tim_sort(int *arr, size_t n);
void intro_sort(int *arr, size_t n);
void smooth_sort(int *arr, size_t n);

#endif // SORTING_ALGORITHMS_H
