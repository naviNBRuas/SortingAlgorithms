from runtime import Arr, swap


def qs(a: Arr, lo: int, hi: int):
    while lo < hi:
        pivot = a[hi]
        i = lo
        j = lo
        while j < hi:
            if a[j] <= pivot:
                swap(a, i, j)
                i += 1
            j += 1
        swap(a, i, hi)
        if i - lo < hi - i:
            qs(a, lo, i - 1)
            lo = i + 1
        else:
            qs(a, i + 1, hi)
            hi = i - 1


def quick_sort(a: Arr, n: int):
    qs(a, 0, n - 1)
