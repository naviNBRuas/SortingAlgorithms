from runtime import Arr, new_array, swap


def gparent(r: Arr, j: int) -> int:
    while j % 2 == r[j // 2]:
        j = j // 2
    return j // 2


def join(a: Arr, r: Arr, i: int, j: int):
    if a[i] < a[j]:
        swap(a, i, j)
        r[j] = 1 - r[j]


def weak_heap_sort(a: Arr, n: int):
    if n < 2:
        return
    r = new_array(n)
    j = n - 1
    while j > 0:
        g = gparent(r, j)
        join(a, r, g, j)
        j -= 1
    m = n - 1
    while m > 1:
        swap(a, 0, m)
        x = 1
        while 2 * x + r[x] < m:
            x = 2 * x + r[x]
        while x > 0:
            join(a, r, 0, x)
            x = x // 2
        m -= 1
    swap(a, 0, 1)
