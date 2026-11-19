from runtime import Arr, swap


def qs(a: Arr, lo: int, hi: int):
    while lo < hi:
        pivot = a[(lo + hi) // 2]
        i = lo - 1
        j = hi + 1
        going = 1
        while going == 1:
            i += 1
            while a[i] < pivot:
                i += 1
            j -= 1
            while a[j] > pivot:
                j -= 1
            if i >= j:
                going = 0
            else:
                swap(a, i, j)
        if j - lo < hi - j - 1:
            qs(a, lo, j)
            lo = j + 1
        else:
            qs(a, j + 1, hi)
            hi = j


def quick_sort_hoare(a: Arr, n: int):
    qs(a, 0, n - 1)
