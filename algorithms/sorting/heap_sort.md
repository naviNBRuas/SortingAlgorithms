# Heap Sort

## Description
Heap sort is a comparison-based sorting technique based on the Binary Heap data structure. It is similar to selection sort where we first find the maximum element and place it at the end. We repeat the same process for the remaining elements.

## Time Complexity
*   **Worst-case:** O(n log n)
*   **Average-case:** O(n log n)
*   **Best-case:** O(n log n)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  **Build a max-heap:** Treat the input array as a complete binary tree. Convert it into a max-heap, where the value of each parent node is greater than or equal to the value of its children.
2.  **Sort the array:** Repeatedly extract the maximum element from the heap (which is always the root), and place it at the end of the array. After extracting, reconstruct the max-heap from the remaining elements.
