from runtime import Arr, new_array


def rec(a: Arr, tmp: Arr, mn: int, lo: int, hi: int, exp: int):
    if hi - lo < 2 or exp == 0:
        return
    count = new_array(11)
    for i in range(lo, hi):
        count[((a[i] - mn) // exp) % 10 + 1] += 1
    for d in range(1, 11):
        count[d] += count[d - 1]
    start = new_array(11)
    for d in range(0, 11):
        start[d] = count[d]
    for i in range(lo, hi):
        d = ((a[i] - mn) // exp) % 10
        tmp[lo + count[d]] = a[i]
        count[d] += 1
    for i in range(lo, hi):
        a[i] = tmp[i]
    for d in range(0, 10):
        rec(a, tmp, mn, lo + start[d], lo + start[d + 1], exp // 10)


def radix_sort_msd(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    tmp = new_array(n)
    top = 1
    while (mx - mn) // top >= 10:
        top *= 10
    rec(a, tmp, mn, 0, n, top)
