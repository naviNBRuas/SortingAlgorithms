# Selection Sort

Selection Sort is a simple, in-place comparison sorting algorithm. It divides the input list into two parts: a sorted sublist of items built up from left to right at the front (left) of the list and an unsorted sublist of items remaining to be sorted. Initially, the sorted sublist is empty and the unsorted sublist is the entire input list.

The algorithm proceeds by finding the smallest (or largest, depending on sorting order) element in the unsorted sublist, exchanging it with the leftmost unsorted element (putting it in sorted order), and moving the sublist boundaries one element to the right.

## Pseudocode

```
procedure selectionSort(A : list of sortable items)
    n = length(A)
    for i = 0 to n - 2 inclusive do
        min_idx = i
        for j = i + 1 to n - 1 inclusive do
            if A[j] < A[min_idx] then
                min_idx = j
            end if
        end for
        // Swap the found minimum element with the first element
        // of the unsorted part
        swap(A[min_idx], A[i])
    end for
end procedure
```

## Complexity

- **Worst-case time complexity:** O(n^2)
- **Average-case time complexity:** O(n^2)
- **Best-case time complexity:** O(n^2)
- **Space complexity:** O(1)

## Stability

Selection Sort is generally not a stable sorting algorithm. The swap operation can change the relative order of equal elements. For example, if you have `[5a, 8, 5b]` and `5a` is at index 0 and `5b` is at index 2, and the minimum element found is `5b`, swapping it with `5a` would change their relative order.

## References

- Cormen, T. H., Leiserson, C. E., Rivest, R. L., & Stein, C. (2009). *Introduction to algorithms*. MIT press.
