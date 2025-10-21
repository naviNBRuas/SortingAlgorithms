# Bubble Sort

Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent elements and swaps them if they are in the wrong order. The pass through the list is repeated until the list is sorted.

## Pseudocode

```
procedure bubbleSort(A : list of sortable items)
    n = length(A)
    repeat
        swapped = false
        for i = 1 to n-1 inclusive do
            if A[i-1] > A[i] then
                swap(A[i-1], A[i])
                swapped = true
            end if
        end for
        n = n - 1
    until not swapped
end procedure
```

## Complexity

- **Worst-case time complexity:** O(n^2)
- **Average-case time complexity:** O(n^2)
- **Best-case time complexity:** O(n)
- **Space complexity:** O(1)

## Stability

Bubble Sort is a stable sorting algorithm. When comparing two equal elements, no swap is made, so their relative order is preserved.

## References

- Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to algorithms*. MIT press.
