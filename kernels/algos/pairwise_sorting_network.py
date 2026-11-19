from runtime import Arr, swap


def cmp_swap(a: Arr, i: int, j: int, n: int):
    if j < n:
        if a[i] > a[j]:
            swap(a, i, j)


def pairwise_sorting_network(a: Arr, n: int):
    size = 1
    while size < n:
        size *= 2
    step = 1
    while step < size:
        b = step
        c = 0
        while b < size:
            cmp_swap(a, b - step, b, n)
            b += 1
            c += 1
            if c >= step:
                c = 0
                b += step
        step *= 2
    step = step // 4
    e = 1
    while step > 0:
        d = e
        while d > 0:
            b = (d + 1) * step
            c = 0
            while b < size:
                cmp_swap(a, b - d * step, b, n)
                b += 1
                c += 1
                if c >= step:
                    c = 0
                    b += step
            d = d // 2
        step = step // 2
        e = e * 2 + 1
