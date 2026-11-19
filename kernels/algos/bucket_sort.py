from runtime import Arr, new_array


def bucket_sort(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    rng = mx - mn
    if rng == 0:
        return
    count = new_array(n + 1)
    out = new_array(n)
    for i in range(0, n):
        count[(a[i] - mn) * (n - 1) // rng + 1] += 1
    for b in range(1, n + 1):
        count[b] += count[b - 1]
    start = new_array(n + 1)
    for b in range(0, n + 1):
        start[b] = count[b]
    for i in range(0, n):
        b = (a[i] - mn) * (n - 1) // rng
        out[count[b]] = a[i]
        count[b] += 1
    for b in range(0, n):
        lo = start[b]
        hi = start[b + 1]
        for i in range(lo + 1, hi):
            key = out[i]
            j = i - 1
            while j >= lo and out[j] > key:
                out[j + 1] = out[j]
                j -= 1
            out[j + 1] = key
    for i in range(0, n):
        a[i] = out[i]
