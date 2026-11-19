from runtime import Arr


def binary_insertion_sort(a: Arr, n: int):
    for i in range(1, n):
        key = a[i]
        lo = 0
        hi = i
        while lo < hi:
            mid = (lo + hi) // 2
            if key < a[mid]:
                hi = mid
            else:
                lo = mid + 1
        j = i
        while j > lo:
            a[j] = a[j - 1]
            j -= 1
        a[lo] = key
