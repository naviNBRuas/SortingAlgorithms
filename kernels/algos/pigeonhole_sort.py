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


def pigeonhole_sort(a: Arr, n: int):
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
    holes = new_array(rng)
    for i in range(0, n):
        holes[a[i] - mn] += 1
    k = 0
    for h in range(0, rng):
        c = holes[h]
        while c > 0:
            a[k] = mn + h
            k += 1
            c -= 1
