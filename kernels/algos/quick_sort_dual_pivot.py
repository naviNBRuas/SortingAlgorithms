from runtime import Arr, swap


def qs(a: Arr, lo: int, hi: int):
    while lo < hi:
        if a[lo] > a[hi]:
            swap(a, lo, hi)
        p = a[lo]
        q = a[hi]
        lt = lo + 1
        gt = hi - 1
        k = lo + 1
        while k <= gt:
            if a[k] < p:
                swap(a, k, lt)
                lt += 1
            elif a[k] > q:
                while k < gt and a[gt] > q:
                    gt -= 1
                swap(a, k, gt)
                gt -= 1
                if a[k] < p:
                    swap(a, k, lt)
                    lt += 1
            k += 1
        lt -= 1
        gt += 1
        swap(a, lo, lt)
        swap(a, hi, gt)
        qs(a, lo, lt - 1)
        qs(a, gt + 1, hi)
        lo = lt + 1
        hi = gt - 1


def quick_sort_dual_pivot(a: Arr, n: int):
    qs(a, 0, n - 1)
