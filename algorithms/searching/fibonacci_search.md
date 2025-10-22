# Fibonacci Search

## Description
Fibonacci Search is a search algorithm that applies to a sorted array to find a target element. It uses Fibonacci numbers to determine the probe positions. Unlike binary search, which divides the array into two nearly equal halves, Fibonacci search divides it into two parts whose sizes correspond to consecutive Fibonacci numbers. This can be advantageous in situations where accessing elements in memory is not uniform, or when the division operation is more costly than addition/subtraction.

## Time Complexity
*   **Worst-case:** O(log n)
*   **Average-case:** O(log n)
*   **Best-case:** O(1)

## Space Complexity
*   **Worst-case:** O(1)

## How it works
1.  **Generate Fibonacci Numbers:** Generate Fibonacci numbers `F(m-2)`, `F(m-1)`, and `F(m)` such that `F(m)` is the smallest Fibonacci number greater than or equal to the size of the array `n`.
2.  **Initialize Offset:** Keep track of the eliminated range from the front of the array using an `offset` variable, initially -1.
3.  **Iterative Search:** While `F(m)` is greater than 1:
    *   Calculate an index `i = min(offset + F(m-2), n-1)`. This is the probe position.
    *   **If `arr[i]` is less than the target:** The target is in the right part. Adjust Fibonacci numbers: `F(m) = F(m-1)`, `F(m-1) = F(m-2)`, `F(m-2) = F(m) - F(m-1)`. Update `offset = i`.
    *   **If `arr[i]` is greater than the target:** The target is in the left part. Adjust Fibonacci numbers: `F(m) = F(m-2)`, `F(m-1) = F(m-1) - F(m-2)`, `F(m-2) = F(m) - F(m-1)`.
    *   **If `arr[i]` is equal to the target:** Return `i`.
4.  **Final Check:** After the loop, if `F(m-1)` is 1 and `arr[offset + 1]` is equal to the target, return `offset + 1`. Otherwise, the element is not found, return -1.
