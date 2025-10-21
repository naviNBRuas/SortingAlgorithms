# Quick Sort

Quick Sort is an efficient, in-place, comparison-based sorting algorithm. It is a divide-and-conquer algorithm. It works by selecting a 'pivot' element from the array and partitioning the other elements into two sub-arrays, according to whether they are less than or greater than the pivot. The sub-arrays are then sorted recursively. This can be done in-place, requiring small additional amounts of memory during the sort.

## Pseudocode

```
procedure quickSort(A : list of sortable items, low, high)
    if low < high then
        pi = partition(A, low, high)
        quickSort(A, low, pi - 1)
        quickSort(A, pi + 1, high)
    end if
end procedure

procedure partition(A : list of sortable items, low, high)
    pivot = A[high]
    i = (low - 1)

    for j = low to high - 1 do
        if A[j] <= pivot then
            i = i + 1
            swap(A[i], A[j])
        end if
    end for
    swap(A[i + 1], A[high])
    return (i + 1)
end procedure
```

## Complexity

- **Worst-case time complexity:** O(n^2)
- **Average-case time complexity:** O(n log n)
- **Best-case time complexity:** O(n log n)
- **Space complexity:** O(log n) (due to recursion stack)

## Stability

Quick Sort is generally not a stable sorting algorithm. The partitioning process can change the relative order of equal elements.

## References

- Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to algorithms*. MIT press.
