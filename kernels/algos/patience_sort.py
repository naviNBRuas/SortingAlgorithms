from runtime import Arr, new_array


def patience_sort(a: Arr, n: int):
    if n < 2:
        return
    vals = new_array(n)
    prev = new_array(n)
    top = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
    piles = 0
    for i in range(0, n):
        lo = 0
        hi = piles
        while lo < hi:
            mid = (lo + hi) // 2
            if vals[top[mid] - 1] < vals[i]:
                lo = mid + 1
            else:
                hi = mid
        prev[i] = top[lo]
        top[lo] = i + 1
        if lo == piles:
            piles += 1
    for out in range(0, n):
        best = -1
        for p in range(0, piles):
            if top[p] != 0:
                if best < 0 or vals[top[p] - 1] < vals[top[best] - 1]:
                    best = p
        a[out] = vals[top[best] - 1]
        top[best] = prev[top[best] - 1]
