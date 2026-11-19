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


def sleep_sort(a: Arr, n: int):
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
    head = new_array(rng)
    nxt = new_array(n)
    i = n - 1
    while i >= 0:
        t = a[i] - mn
        nxt[i] = head[t]
        head[t] = i + 1
        i -= 1
    vals = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
    out = 0
    for t in range(0, rng):
        node = head[t]
        while node != 0:
            a[out] = vals[node - 1]
            out += 1
            node = nxt[node - 1]
