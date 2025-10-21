# Cocktail Shaker Sort

## Description
Cocktail Shaker Sort (also known as Bidirectional Bubble Sort, Cocktail Sort, Shaker Sort, or Ripple Sort) is a variation of bubble sort. The algorithm differs from bubble sort in that it sorts in both directions on each pass through the list. This sorting algorithm is slightly more efficient than bubble sort because it moves items in both directions, but it still has a worst-case time complexity of O(n²).

## Time Complexity
*   **Worst-case:** O(n²)
*   **Average-case:** O(n²)
*   **Best-case:** O(n) (when the list is already sorted)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  The algorithm proceeds by repeatedly traversing the list in both directions.
2.  **Forward Pass:** It starts by moving from left to right, comparing adjacent elements and swapping them if they are in the wrong order. After this pass, the largest element will be at its correct position at the end of the unsorted portion of the list.
3.  **Backward Pass:** Then, it traverses from right to left, comparing adjacent elements and swapping them if they are in the wrong order. After this pass, the smallest element will be at its correct position at the beginning of the unsorted portion of the list.
4.  The algorithm keeps track of whether any swaps were made in a pass. If no swaps are made in a complete forward and backward pass, the list is sorted, and the algorithm terminates.
5.  The range of elements to be sorted shrinks with each pass, as the smallest and largest elements are placed in their correct positions.
