from runtime import Arr, new_array


def locate(vals: Arr, s: Arr, size: int, x: int) -> int:
    lo = 0
    hi = size - 1
    while lo <= hi:
        mid = (lo + hi) // 2
        m = mid
        while m <= hi and s[m] == 0:
            m += 1
        if m > hi:
            hi = mid - 1
        elif x < vals[s[m] - 1]:
            hi = mid - 1
        else:
            lo = m + 1
    return lo


def library_sort(a: Arr, n: int):
    if n < 2:
        return
    size = 2 * n + 2
    vals = new_array(n)
    s = new_array(size)
    tmp = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
    nextpow = 1
    for k in range(0, n):
        if k == nextpow:
            nextpow *= 2
            cnt = 0
            for i in range(0, size):
                if s[i] != 0:
                    tmp[cnt] = s[i]
                    cnt += 1
                    s[i] = 0
            for j in range(0, cnt):
                s[(j * size) // cnt] = tmp[j]
        lo = locate(vals, s, size, vals[k])
        p = lo - 1
        while p >= 0 and s[p] == 0:
            p -= 1
        q = lo
        while q < size and s[q] == 0:
            q += 1
        if q - p > 1:
            s[(p + q) // 2] = k + 1
        else:
            g = q
            while g < size and s[g] != 0:
                g += 1
            if g < size:
                j = g
                while j > q:
                    s[j] = s[j - 1]
                    j -= 1
                s[q] = k + 1
            else:
                g = p
                while s[g] != 0:
                    g -= 1
                j = g
                while j < p:
                    s[j] = s[j + 1]
                    j += 1
                s[p] = k + 1
    out = 0
    for i in range(0, size):
        if s[i] != 0:
            tmp[out] = vals[s[i] - 1]
            out += 1
    for i in range(0, n):
        a[i] = tmp[i]
