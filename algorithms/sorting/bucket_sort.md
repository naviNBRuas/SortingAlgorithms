# Bucket Sort

## Description
Bucket sort, or bin sort, is a sorting algorithm that works by distributing elements of an array into a number of buckets. Each bucket is then sorted individually, either using a different sorting algorithm, or by recursively applying the bucket sort algorithm. It is a distribution sort, and is a generalization of pigeonhole sort.

## Time Complexity
*   **Worst-case:** O(n²)
*   **Average-case:** O(n + k) (where n is the number of elements and k is the number of buckets)
*   **Best-case:** O(n + k)

## Space Complexity
*   **Worst-case:** O(n + k)

## How it works
1.  **Create Buckets:** Set up an array of initially empty 'buckets' (e.g., linked lists or dynamic arrays).
2.  **Distribution:** Iterate through the input array and place each element into its appropriate bucket. The bucket for an element is determined by a mapping function that distributes elements evenly across the buckets.
3.  **Sort Buckets:** Sort each non-empty bucket. This can be done using a simpler sorting algorithm (like insertion sort) or by recursively applying bucket sort.
4.  **Concatenation:** Concatenate all the sorted buckets in order to get the final sorted array.

## Limitations
*   Bucket sort works best when the input data is uniformly distributed over a range. If the data is clustered, some buckets may contain many elements while others are empty, leading to a worst-case performance similar to the sorting algorithm used within the buckets.
*   It typically requires knowing the range of the input values to effectively distribute them into buckets.
