from runtime import Arr, new_array, swap


def rec(a: Arr, mn: int, lo: int, hi: int, exp: int):
    if hi - lo < 2 or exp == 0:
        return
    count = new_array(10)
    starts = new_array(11)
    nxt = new_array(10)
    for i in range(lo, hi):
        count[((a[i] - mn) // exp) % 10] += 1
    s = lo
    for d in range(0, 10):
        starts[d] = s
        nxt[d] = s
        s += count[d]
    starts[10] = s
    for b in range(0, 10):
        while nxt[b] < starts[b + 1]:
            d = ((a[nxt[b]] - mn) // exp) % 10
            if d == b:
                nxt[b] += 1
            else:
                swap(a, nxt[b], nxt[d])
                nxt[d] += 1
    for b in range(0, 10):
        rec(a, mn, starts[b], starts[b + 1], exp // 10)


def american_flag_sort(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    top = 1
    while (mx - mn) // top >= 10:
        top *= 10
    rec(a, mn, 0, n, top)
