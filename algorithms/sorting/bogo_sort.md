# Bogo Sort

Bogo Sort, also known as permutation sort, stupid sort, or shotgun sort, is a highly inefficient sorting algorithm based on the generate and test paradigm. The algorithm repeatedly generates permutations of the list until it finds one that is sorted.

## Pseudocode

```
procedure bogoSort(A : list of sortable items)
    while not isSorted(A) do
        shuffle(A)
    end while
end procedure

procedure isSorted(A : list of sortable items)
    for i = 0 to length(A) - 2 do
        if A[i] > A[i+1] then
            return false
        end if
    end for
    return true
end procedure

procedure shuffle(A : list of sortable items)
    // Fisher-Yates shuffle
    for i = length(A) - 1 down to 1 do
        j = random integer from 0 to i inclusive
        swap(A[i], A[j])
    end for
end procedure
```

## Complexity

- **Worst-case time complexity:** O(infinity) (unbounded)
- **Average-case time complexity:** O(n! * n) (n factorial times n)
- **Best-case time complexity:** O(n) (if the array is already sorted)
- **Space complexity:** O(1) (in-place, excluding recursion stack for shuffle)

## Stability

Bogo Sort is not a stable sorting algorithm due to its random shuffling nature, which does not preserve the relative order of equal elements.

## References

- Wikipedia: [Bogo Sort](https://en.wikipedia.org/wiki/Bogosort)
