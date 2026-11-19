from runtime import Arr, swap


def st(a: Arr, i: int, j: int):
    if a[i] > a[j]:
        swap(a, i, j)
    if j - i + 1 > 2:
        t = (j - i + 1) // 3
        st(a, i, j - t)
        st(a, i + t, j)
        st(a, i, j - t)


def stooge_sort(a: Arr, n: int):
    if n > 1:
        st(a, 0, n - 1)
