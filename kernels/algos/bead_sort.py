from runtime import Arr, new_array


def fallback(a: Arr, n: int):
    gap = n // 2
    while gap > 0:
        for i in range(gap, n):
            key = a[i]
            j = i
            while j >= gap and a[j - gap] > key:
                a[j] = a[j - gap]
                j -= gap
            a[j] = key
        gap = gap // 2


def bead_sort(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    maxv = mx - mn
    if maxv > 20000:
        fallback(a, n)
        return
    ge = new_array(maxv + 2)
    rods = new_array(n)
    for i in range(0, n):
        ge[a[i] - mn] += 1
    r = maxv
    while r > 0:
        r -= 1
        ge[r] += ge[r + 1]
    for level in range(1, maxv + 1):
        for k in range(0, ge[level]):
            rods[n - 1 - k] += 1
    for i in range(0, n):
        a[i] = rods[i] + mn
