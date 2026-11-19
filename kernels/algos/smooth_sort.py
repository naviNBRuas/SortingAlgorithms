from runtime import Arr, new_array


def tz(x: int) -> int:
    """Number of trailing zero bits of x (x > 0)."""
    c = 0
    while x % 2 == 0:
        x = x // 2
        c += 1
    return c


def pow2(k: int) -> int:
    r = 1
    for i in range(0, k):
        r *= 2
    return r


def sift(a: Arr, lp: Arr, head: int, pshift: int):
    val = a[head]
    going = 1
    while pshift > 1 and going == 1:
        rt = head - 1
        lf = head - 1 - lp[pshift - 2]
        if val >= a[lf] and val >= a[rt]:
            going = 0
        elif a[lf] >= a[rt]:
            a[head] = a[lf]
            head = lf
            pshift -= 1
        else:
            a[head] = a[rt]
            head = rt
            pshift -= 2
    a[head] = val


def trinkle(a: Arr, lp: Arr, head: int, p: int, pshift: int, trusty: int):
    val = a[head]
    going = 1
    while p != 1 and going == 1:
        stepson = head - lp[pshift]
        if a[stepson] <= val:
            going = 0
        else:
            stop = 0
            if trusty == 0 and pshift > 1:
                rt = head - 1
                lf = head - 1 - lp[pshift - 2]
                if a[rt] >= a[stepson] or a[lf] >= a[stepson]:
                    stop = 1
            if stop == 1:
                going = 0
            else:
                a[head] = a[stepson]
                head = stepson
                trail = tz(p - p % 2)
                p = p // pow2(trail)
                pshift += trail
                trusty = 0
    if trusty == 0:
        a[head] = val
        sift(a, lp, head, pshift)


def smooth_sort(a: Arr, n: int):
    if n < 2:
        return
    lp = new_array(64)
    lp[0] = 1
    lp[1] = 1
    for i in range(2, 64):
        lp[i] = lp[i - 1] + lp[i - 2] + 1
    hi = n - 1
    head = 0
    p = 1
    pshift = 1
    while head < hi:
        if p % 4 == 3:
            sift(a, lp, head, pshift)
            p = p // 4
            pshift += 2
        else:
            if lp[pshift - 1] >= hi - head:
                trinkle(a, lp, head, p, pshift, 0)
            else:
                sift(a, lp, head, pshift)
            if pshift == 1:
                p = p * 2
                pshift = 0
            else:
                p = p * pow2(pshift - 1)
                pshift = 1
        p = p + 1 - p % 2
        head += 1
    trinkle(a, lp, head, p, pshift, 0)
    while pshift != 1 or p != 1:
        if pshift <= 1:
            trail = tz(p - p % 2)
            p = p // pow2(trail)
            pshift += trail
        else:
            p = p * 4
            if (p // 4) % 2 == 0:
                p += 7
            else:
                p -= 1
            pshift -= 2
            trinkle(a, lp, head - lp[pshift] - 1, p // 2, pshift + 1, 1)
            trinkle(a, lp, head - 1, p, pshift, 1)
        head -= 1
