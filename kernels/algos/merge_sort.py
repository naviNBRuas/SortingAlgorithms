from runtime import Arr, new_array


def rec(a: Arr, tmp: Arr, lo: int, hi: int):
    if hi - lo < 2:
        return
    mid = (lo + hi) // 2
    rec(a, tmp, lo, mid)
    rec(a, tmp, mid, hi)
    for x in range(lo, mid):
        tmp[x] = a[x]
    i = lo
    j = mid
    k = lo
    while i < mid and j < hi:
        if a[j] < tmp[i]:
            a[k] = a[j]
            j += 1
        else:
            a[k] = tmp[i]
            i += 1
        k += 1
    while i < mid:
        a[k] = tmp[i]
        i += 1
        k += 1


def merge_sort(a: Arr, n: int):
    tmp = new_array(n)
    rec(a, tmp, 0, n)
