from runtime import Arr, new_array, swap


def flash_sort(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    if mn == mx:
        return
    m = max(2, 43 * n // 100)
    rng = mx - mn
    count = new_array(m)
    starts = new_array(m + 1)
    nxt = new_array(m)
    for i in range(0, n):
        count[(a[i] - mn) * (m - 1) // rng] += 1
    s = 0
    for c in range(0, m):
        starts[c] = s
        nxt[c] = s
        s += count[c]
    starts[m] = s
    for b in range(0, m):
        while nxt[b] < starts[b + 1]:
            d = (a[nxt[b]] - mn) * (m - 1) // rng
            if d == b:
                nxt[b] += 1
            else:
                swap(a, nxt[b], nxt[d])
                nxt[d] += 1
    for i in range(1, n):
        key = a[i]
        j = i - 1
        while j >= 0 and a[j] > key:
            a[j + 1] = a[j]
            j -= 1
        a[j + 1] = key
