from runtime import Arr, swap


def qs(a: Arr, lo: int, hi: int):
    while lo < hi:
        pivot = a[(lo + hi) // 2]
        lt = lo
        i = lo
        gt = hi
        while i <= gt:
            if a[i] < pivot:
                swap(a, lt, i)
                lt += 1
                i += 1
            elif a[i] > pivot:
                swap(a, i, gt)
                gt -= 1
            else:
                i += 1
        if lt - lo < hi - gt:
            qs(a, lo, lt - 1)
            lo = gt + 1
        else:
            qs(a, gt + 1, hi)
            hi = lt - 1


def quick_sort_3way(a: Arr, n: int):
    qs(a, 0, n - 1)
