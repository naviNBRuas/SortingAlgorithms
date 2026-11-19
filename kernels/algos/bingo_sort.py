from runtime import Arr, swap


def bingo_sort(a: Arr, n: int):
    if n < 2:
        return
    mx = n - 1
    nxt = a[mx]
    i = mx - 1
    while i >= 0:
        if a[i] > nxt:
            nxt = a[i]
        i -= 1
    while mx > 0 and a[mx] == nxt:
        mx -= 1
    while mx > 0:
        bingo = nxt
        nxt = a[mx]
        i = mx - 1
        while i >= 0:
            if a[i] == bingo:
                swap(a, i, mx)
                mx -= 1
            elif a[i] > nxt:
                nxt = a[i]
            i -= 1
        while mx > 0 and a[mx] == nxt:
            mx -= 1
