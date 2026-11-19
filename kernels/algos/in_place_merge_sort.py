from runtime import Arr, swap


def reverse(a: Arr, i: int, j: int):
    j -= 1
    while i < j:
        swap(a, i, j)
        i += 1
        j -= 1


def rotate(a: Arr, i: int, m: int, j: int):
    reverse(a, i, m)
    reverse(a, m, j)
    reverse(a, i, j)


def merge(a: Arr, lo: int, mid: int, hi: int):
    if lo >= mid or mid >= hi:
        return
    if hi - lo == 2:
        if a[mid] < a[lo]:
            swap(a, lo, mid)
        return
    if mid - lo >= hi - mid:
        i = (lo + mid) // 2
        pivot = a[i]
        l = mid
        h = hi
        while l < h:
            m = (l + h) // 2
            if a[m] < pivot:
                l = m + 1
            else:
                h = m
        j = l
        rotate(a, i, mid, j)
        nm = i + (j - mid)
        merge(a, lo, i, nm)
        merge(a, nm + 1, j, hi)
    else:
        j = (mid + hi) // 2
        pivot = a[j]
        l = lo
        h = mid
        while l < h:
            m = (l + h) // 2
            if pivot < a[m]:
                h = m
            else:
                l = m + 1
        i = l
        rotate(a, i, mid, j + 1)
        nm = i + (j + 1 - mid)
        merge(a, lo, i, nm - 1)
        merge(a, nm, j + 1, hi)


def rec(a: Arr, lo: int, hi: int):
    if hi - lo < 2:
        return
    mid = (lo + hi) // 2
    rec(a, lo, mid)
    rec(a, mid, hi)
    merge(a, lo, mid, hi)


def in_place_merge_sort(a: Arr, n: int):
    rec(a, 0, n)
