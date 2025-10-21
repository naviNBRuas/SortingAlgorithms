# Binary Search

## Description
Binary search is an efficient algorithm for finding an item from a sorted list of items. It works by repeatedly dividing in half the portion of the list that could contain the item, until you've narrowed down the possible locations to just one.

## Time Complexity
*   **Worst-case:** O(log n)
*   **Average-case:** O(log n)
*   **Best-case:** O(1)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  Start with the middle element of the sorted array.
2.  If the target value is equal to the middle element, its position is returned.
3.  If the target value is less than the middle element, the search continues in the lower half of the array.
4.  If the target value is greater than the middle element, the search continues in the upper half of the array.
5.  This process is repeated until the target value is found or the search interval is empty.
