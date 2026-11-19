from runtime import Arr, swap


def sift(a: Arr, root: int, size: int):
    j = root
    while 2 * j + 2 < size:
        if a[2 * j + 1] < a[2 * j + 2]:
            j = 2 * j + 2
        else:
            j = 2 * j + 1
    if 2 * j + 1 < size:
        j = 2 * j + 1
    x = a[root]
    while a[j] < x:
        j = (j - 1) // 2
    cur = root
    while cur != j:
        c = j
        while (c - 1) // 2 != cur:
            c = (c - 1) // 2
        a[cur] = a[c]
        cur = c
    a[j] = x


def bottom_up_heap_sort(a: Arr, n: int):
    s = n // 2
    while s > 0:
        s -= 1
        sift(a, s, n)
    end = n - 1
    while end > 0:
        swap(a, 0, end)
        sift(a, 0, end)
        end -= 1
