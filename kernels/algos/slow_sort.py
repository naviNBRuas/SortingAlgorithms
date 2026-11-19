from runtime import Arr, swap


def slow(a: Arr, i: int, j: int):
    if i >= j:
        return
    m = (i + j) // 2
    slow(a, i, m)
    slow(a, m + 1, j)
    if a[m] > a[j]:
        swap(a, m, j)
    slow(a, i, j - 1)


def slow_sort(a: Arr, n: int):
    slow(a, 0, n - 1)
