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


def counting_sort(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    rng = mx - mn + 1
    if rng > 4000000:
        fallback(a, n)
        return
    count = new_array(rng + 1)
    out = new_array(n)
    for i in range(0, n):
        count[a[i] - mn + 1] += 1
    for i in range(1, rng + 1):
        count[i] += count[i - 1]
    for i in range(0, n):
        out[count[a[i] - mn]] = a[i]
        count[a[i] - mn] += 1
    for i in range(0, n):
        a[i] = out[i]
