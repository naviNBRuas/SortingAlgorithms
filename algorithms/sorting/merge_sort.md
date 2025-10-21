# Merge Sort

Merge Sort is an efficient, general-purpose, comparison-based sorting algorithm. Most implementations produce a stable sort, meaning that the order of equal elements is preserved. It is a divide and conquer algorithm.

## Pseudocode

```
procedure mergeSort(A : list of sortable items)
    if length(A) <= 1 then
        return A
    end if

    mid = length(A) / 2
    left = mergeSort(A[0...mid-1])
    right = mergeSort(A[mid...length(A)-1])

    return merge(left, right)
end procedure

procedure merge(left, right)
    result = empty list
    while left is not empty and right is not empty do
        if first(left) <= first(right) then
            add first(left) to result
            remove first(left) from left
        else
            add first(right) to result
            remove first(right) from right
        end if
    end while

    while left is not empty do
        add first(left) to result
        remove first(left) from left
    end while

    while right is not empty do
        add first(right) to result
        remove first(right) from right
    end while

    return result
end procedure
```

## Complexity

- **Worst-case time complexity:** O(n log n)
- **Average-case time complexity:** O(n log n)
- **Best-case time complexity:** O(n log n)
- **Space complexity:** O(n)

## Stability

Merge Sort is a stable sorting algorithm, provided that the merge operation is implemented carefully to preserve the relative order of equal elements.

## References

- Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to algorithms*. MIT press.
