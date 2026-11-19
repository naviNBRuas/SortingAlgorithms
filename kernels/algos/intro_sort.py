from runtime import Arr, swap


def insertion(a: Arr, lo: int, hi: int):
    for i in range(lo + 1, hi + 1):
        key = a[i]
        j = i - 1
        while j >= lo and a[j] > key:
            a[j + 1] = a[j]
            j -= 1
        a[j + 1] = key


def sift(a: Arr, base: int, root: int, size: int):
    going = 1
    while going == 1:
        child = 2 * root + 1
        if child >= size:
            going = 0
        else:
            if child + 1 < size and a[base + child] < a[base + child + 1]:
                child += 1
            if a[base + root] < a[base + child]:
                swap(a, base + root, base + child)
                root = child
            else:
                going = 0


def heap(a: Arr, lo: int, hi: int):
    size = hi - lo + 1
    s = size // 2
    while s > 0:
        s -= 1
        sift(a, lo, s, size)
    end = size - 1
    while end > 0:
        swap(a, lo, lo + end)
        sift(a, lo, 0, end)
        end -= 1


def sort(a: Arr, lo: int, hi: int, depth: int):
    while hi - lo + 1 > 16:
        if depth == 0:
            heap(a, lo, hi)
            return
        depth -= 1
        mid = (lo + hi) // 2
        if a[mid] < a[lo]:
            swap(a, mid, lo)
        if a[hi] < a[lo]:
            swap(a, hi, lo)
        if a[hi] < a[mid]:
            swap(a, hi, mid)
        pivot = a[mid]
        i = lo
        j = hi
        while i <= j:
            while a[i] < pivot:
                i += 1
            while a[j] > pivot:
                j -= 1
            if i <= j:
                swap(a, i, j)
                i += 1
                j -= 1
        sort(a, lo, j, depth)
        lo = i
    insertion(a, lo, hi)


def intro_sort(a: Arr, n: int):
    depth = 0
    t = n
    while t > 1:
        t = t // 2
        depth += 2
    sort(a, 0, n - 1, depth)
