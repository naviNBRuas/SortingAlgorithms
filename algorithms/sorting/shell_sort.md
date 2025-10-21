# Shell Sort

## Description
Shell sort is an in-place comparison sort. It can be seen as either a generalization of insertion sort or a diminishing increment sort. The method starts by sorting pairs of elements far apart from each other, then gradually reducing the gap between elements to be compared. This process continues until the last sort is a simple insertion sort (gap of 1), but by then, the array is already mostly sorted, making the final pass very efficient.

## Time Complexity
*   **Worst-case:** Depends on gap sequence, O(n (log n)²) for some sequences, O(n^(4/3)) for others.
*   **Average-case:** Depends on gap sequence, typically better than O(n²).
*   **Best-case:** O(n log n) (for already sorted data with optimal gap sequence).

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  **Choose a gap sequence:** Select a sequence of integers (gaps) that decreases to 1. Common sequences include Knuth's (1, 4, 13, 40, ...), Sedgewick's, or simply `n/2, n/4, ..., 1`.
2.  **H-sort the array:** For each gap `h` in the sequence (from largest to smallest):
    *   Perform an insertion sort on all sub-arrays formed by elements `h` distance apart. That is, for `i = h, h+1, ..., n-1`, insert `arr[i]` into its correct position among `arr[i-h], arr[i-2h], ...`.
3.  The final pass with `h=1` is a standard insertion sort, but on a nearly sorted array, which is very fast.
