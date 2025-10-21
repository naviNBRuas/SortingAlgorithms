# Jump Search

## Description
Jump Search is a searching algorithm for sorted arrays. The basic idea is to check fewer elements by 'jumping' ahead by fixed steps or skipping some elements in place of searching every element. Once a block is found that might contain the element, a linear search is performed on that block.

## Time Complexity
*   **Worst-case:** O(√n)
*   **Average-case:** O(√n)
*   **Best-case:** O(1)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  **Determine Block Size:** Choose an optimal block size to jump. A common choice is `√n`, where `n` is the length of the array.
2.  **Jump through the array:** Start from the beginning of the array and jump by the chosen block size. Compare the element at the end of each block with the target value.
3.  **Identify the block:** Continue jumping until an element greater than the target is found, or the end of the array is reached. This indicates that the target, if present, must lie in the previous block or the current block.
4.  **Linear Search:** Perform a linear search in the identified block (from the previous jump position up to the current jump position) to find the exact location of the target element.
5.  If the element is found, return its index; otherwise, return -1.
