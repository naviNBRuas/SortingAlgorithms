# Radix Sort

## Description
Radix sort is a non-comparative integer sorting algorithm that sorts data with integer keys by grouping keys by the individual digits which share the same significant position and value. It extends the idea of Counting Sort to work with multi-digit numbers.

## Time Complexity
*   **Worst-case:** O(nk) (where n is the number of elements and k is the number of digits in the maximum number)
*   **Average-case:** O(nk)
*   **Best-case:** O(nk)

## Space Complexity
*   **Worst-case:** O(n + k) (for the counting sort subroutine)

## How it works
1.  **Find the maximum number:** Determine the maximum number in the input array to know the number of digits.
2.  **Perform Counting Sort for each digit:** Iterate from the least significant digit to the most significant digit. For each digit position, use a stable sorting algorithm (like Counting Sort) to sort the elements based on that digit.
    *   **Counting Sort for Radix:**
        *   Create a `count` array of size 10 (for digits 0-9) and initialize to 0.
        *   Count the occurrences of each digit at the current significant position.
        *   Modify the `count` array to store the cumulative count.
        *   Build the `output` array by placing elements in their sorted order based on the current digit, iterating from right to left to maintain stability.
        *   Copy the `output` array back to the original array.
3.  After iterating through all digit positions, the array will be sorted.
