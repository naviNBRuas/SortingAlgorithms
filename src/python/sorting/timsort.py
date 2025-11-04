
"""
TimSort is a hybrid stable sorting algorithm, derived from merge sort and insertion sort,
designed to perform well on many kinds of real-world data. It is the default sorting
algorithm in Python and Java.

Time Complexity:
    - Worst-case: O(n log n)
    - Average-case: O(n log n)
    - Best-case: O(n) (when the list is already sorted)

Space Complexity:
    - Worst-case: O(n) (for temporary arrays during merging)

How it works:
1.  **Divide and Conquer (Runs):** It divides the array into "runs" (non-decreasing or strictly decreasing sequences).
    Strictly decreasing runs are reversed to become non-decreasing.
2.  **Minimum Run Length:** It ensures that each run has a minimum length (MIN_MERGE, typically 32 or 64). If a run is shorter,
    it uses insertion sort to extend it to the minimum run length. Insertion sort is efficient for small arrays.
3.  **Merging:** It then merges these runs using a modified merge sort. The key is to perform merges in a way that preserves
    stability and minimizes comparisons. It uses a stack to keep track of runs and merges adjacent runs when certain
    conditions are met to maintain efficiency.
4.  **Galloping Mode:** During merging, if one run consistently "wins" comparisons against the other, TimSort enters
    "galloping mode," where it quickly skips over large blocks of elements from the winning run, further optimizing merges.
"""

def insertion_sort(arr, left, right):
    for i in range(left + 1, right + 1):
        j = i
        while j > left and arr[j] < arr[j - 1]:
            arr[j], arr[j - 1] = arr[j - 1], arr[j]
            j -= 1

def merge(arr, l, m, r):
    len1, len2 = m - l + 1, r - m
    left = arr[l : l + len1]
    right = arr[m + 1 : m + 1 + len2]

    i, j, k = 0, 0, l

    while i < len1 and j < len2:
        if left[i] <= right[j]:
            arr[k] = left[i]
            i += 1
        else:
            arr[k] = right[j]
            j += 1
        k += 1

    while i < len1:
        arr[k] = left[i]
        k += 1
        i += 1

    while j < len2:
        arr[k] = right[j]
        k += 1
        j += 1

def timsort(arr):
    n = len(arr)
    MIN_MERGE = 32

    for i in range(0, n, MIN_MERGE):
        insertion_sort(arr, i, min((i + MIN_MERGE - 1), n - 1))

    size = MIN_MERGE
    while size < n:
        for start in range(0, n, size * 2):
            mid = min((start + size - 1), n - 1)
            end = min((start + size * 2 - 1), (n - 1))

            if mid < end:
                merge(arr, start, mid, end)
        size *= 2
    return arr
