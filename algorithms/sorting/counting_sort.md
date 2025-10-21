# Counting Sort

## Description
Counting sort is a non-comparison based sorting algorithm. It is effective for sorting a collection of objects according to keys that are small positive integers. It works by counting the number of occurrences of each distinct key value and using arithmetic to determine the positions of each key value in the output sequence.

## Time Complexity
*   **Worst-case:** O(n + k) (where n is the number of elements and k is the range of input)
*   **Average-case:** O(n + k)
*   **Best-case:** O(n + k)

## Space Complexity
*   **Worst-case:** O(k)

## How it works
1.  Find the maximum element in the input array.
2.  Create a `count` array of size `max_val + 1` and initialize all elements to 0. This array will store the count of each element.
3.  Iterate through the input array and increment the count of each element in the `count` array.
4.  Modify the `count` array such that each element at an index `i` stores the sum of previous counts (i.e., `count[i]` stores the number of elements less than or equal to `i`). This cumulative count helps in determining the position of each element in the sorted output.
5.  Create an `output` array of the same size as the input array.
6.  Iterate through the input array from right to left. For each element, place it at the index specified by `count[element] - 1` in the `output` array, and then decrement `count[element]`.
7.  Copy the sorted elements from the `output` array back to the original array (or return the `output` array).
