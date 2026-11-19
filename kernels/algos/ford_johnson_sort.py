from runtime import Arr, new_array


def fj(key: Arr, ids: Arr, m: int):
    """Merge-insertion: sort ids[0..m) by key[id]."""
    if m < 2:
        return
    h = m // 2
    small = new_array(h)
    big = new_array(h)
    for k in range(0, h):
        x = ids[2 * k]
        y = ids[2 * k + 1]
        if key[y] < key[x]:
            small[k] = y
            big[k] = x
        else:
            small[k] = x
            big[k] = y
    bk = new_array(h)
    order = new_array(h)
    for k in range(0, h):
        bk[k] = key[big[k]]
        order[k] = k
    fj(bk, order, h)
    total = h
    if m % 2 == 1:
        total = h + 1
    chain = new_array(m)
    bs = new_array(total + 1)
    chain[0] = small[order[0]]
    for k in range(0, h):
        chain[k + 1] = big[order[k]]
        bs[k + 1] = small[order[k]]
    size = h + 1
    if m % 2 == 1:
        bs[h + 1] = ids[m - 1]
    prev = 1
    kk = 2
    while prev < total:
        t = 1
        pw = 1
        c = 0
        while c < kk + 1:
            pw *= 2
            c += 1
        if kk % 2 == 0:
            t = (pw + 1) // 3
        else:
            t = (pw - 1) // 3
        top = min(t, total)
        i = top
        while i > prev:
            bound = size
            if i <= h:
                bound = 0
                while chain[bound] != big[order[i - 1]]:
                    bound += 1
            lo = 0
            hi = bound
            while lo < hi:
                mid = (lo + hi) // 2
                if key[bs[i]] < key[chain[mid]]:
                    hi = mid
                else:
                    lo = mid + 1
            j = size
            while j > lo:
                chain[j] = chain[j - 1]
                j -= 1
            chain[lo] = bs[i]
            size += 1
            i -= 1
        prev = top
        kk += 1
    for k in range(0, m):
        ids[k] = chain[k]


def ford_johnson_sort(a: Arr, n: int):
    if n < 2:
        return
    key = new_array(n)
    ids = new_array(n)
    for i in range(0, n):
        key[i] = a[i]
        ids[i] = i
    fj(key, ids, n)
    for i in range(0, n):
        a[i] = key[ids[i]]
