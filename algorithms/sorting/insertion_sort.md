# Insertion Sort

Insertion Sort is a simple sorting algorithm that builds the final sorted array (or list) one item at a time. It is much less efficient on large lists than more advanced algorithms such as quicksort, heapsort, or merge sort.

## Pseudocode

```
procedure insertionSort(A : list of sortable items)
    n = length(A)
    for i = 1 to n - 1 inclusive do
        key = A[i]
        j = i - 1
        // Move elements of A[0..i-1], that are greater than key,
        // to one position ahead of their current position
        while j >= 0 and key < A[j] do
            A[j + 1] = A[j]
            j = j - 1
        end while
        A[j + 1] = key
    end for
end procedure
```

## Complexity

- **Worst-case time complexity:** O(n^2)
- **Average-case time complexity:** O(n^2)
- **Best-case time complexity:** O(n)
- **Space complexity:** O(1)

## Stability

Insertion Sort is a stable sorting algorithm. It preserves the relative order of elements with equal values.

## References

- Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to algorithms*. MIT press.
