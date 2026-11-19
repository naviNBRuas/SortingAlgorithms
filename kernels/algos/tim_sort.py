from runtime import Arr, new_array, swap


def insertion(a: Arr, lo: int, hi: int):
    for i in range(lo + 1, hi):
        key = a[i]
        j = i - 1
        while j >= lo and a[j] > key:
            a[j + 1] = a[j]
            j -= 1
        a[j + 1] = key


def merge_at(a: Arr, tmp: Arr, rs: Arr, rl: Arr, cnt: int, i: int) -> int:
    s1 = rs[i]
    l1 = rl[i]
    l2 = rl[i + 1]
    for x in range(0, l1):
        tmp[x] = a[s1 + x]
    x = 0
    j = s1 + l1
    k = s1
    end = j + l2
    while x < l1 and j < end:
        if a[j] < tmp[x]:
            a[k] = a[j]
            j += 1
        else:
            a[k] = tmp[x]
            x += 1
        k += 1
    while x < l1:
        a[k] = tmp[x]
        x += 1
        k += 1
    rl[i] = l1 + l2
    for t in range(i + 1, cnt - 1):
        rs[t] = rs[t + 1]
        rl[t] = rl[t + 1]
    return cnt - 1


def collapse(a: Arr, tmp: Arr, rs: Arr, rl: Arr, cnt: int) -> int:
    going = 1
    while going == 1 and cnt > 1:
        m = cnt - 2
        need = 0
        if m > 0 and rl[m - 1] <= rl[m] + rl[m + 1]:
            need = 1
        if m > 1 and rl[m - 2] <= rl[m - 1] + rl[m]:
            need = 1
        if need == 1:
            if m > 0 and rl[m - 1] < rl[m + 1]:
                m -= 1
            cnt = merge_at(a, tmp, rs, rl, cnt, m)
        elif rl[m] <= rl[m + 1]:
            cnt = merge_at(a, tmp, rs, rl, cnt, m)
        else:
            going = 0
    return cnt


def tim_sort(a: Arr, n: int):
    if n < 2:
        return
    tmp = new_array(n)
    rs = new_array(128)
    rl = new_array(128)
    r = 0
    t = n
    while t >= 64:
        r = r + t % 2
        if r > 1:
            r = 1
        t = t // 2
    minrun = t + r
    cnt = 0
    lo = 0
    while lo < n:
        e = lo + 1
        if e < n:
            if a[e] < a[e - 1]:
                while e < n and a[e] < a[e - 1]:
                    e += 1
                x = lo
                y = e - 1
                while x < y:
                    swap(a, x, y)
                    x += 1
                    y -= 1
            else:
                while e < n and a[e] >= a[e - 1]:
                    e += 1
        force = min(minrun, n - lo)
        if e - lo < force:
            insertion(a, lo, lo + force)
            e = lo + force
        rs[cnt] = lo
        rl[cnt] = e - lo
        cnt += 1
        cnt = collapse(a, tmp, rs, rl, cnt)
        lo = e
    while cnt > 1:
        m = cnt - 2
        if m > 0 and rl[m - 1] < rl[m + 1]:
            m -= 1
        cnt = merge_at(a, tmp, rs, rl, cnt, m)
