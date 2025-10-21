# Exponential Search

## Description
Exponential search (also known as doubling search or galloping search) is an algorithm for finding the position of a target value within a sorted array. It is particularly useful for unbounded arrays (or lists of unknown size) or when the element to be searched is near the beginning of the array. It combines the idea of finding a range where the element might be present with binary search.

## Time Complexity
*   **Worst-case:** O(log n)
*   **Average-case:** O(log n)
*   **Best-case:** O(1) (if the element is at the first position)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  **Handle first element:** Check if the target element is at the first position of the array. If so, return 0.
2.  **Find the range:** Start with a `bound` of 1. Repeatedly double the `bound` (i.e., `bound = bound * 2`) as long as `bound` is within the array limits and the element at `arr[bound]` is less than or equal to the target. This step finds a range `[bound/2, min(bound, n-1)]` where `n` is the array length, in which the target element might reside.
3.  **Binary Search:** Once the range is found, perform a standard binary search within this smaller, identified range. The binary search will then pinpoint the exact location of the target element if it exists.
