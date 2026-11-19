from runtime import Arr, swap


def sift(a: Arr, root: int, size: int):
    going = 1
    while going == 1:
        first = 3 * root + 1
        if first >= size:
            going = 0
        else:
            best = first
            c = first + 1
            while c < first + 3 and c < size:
                if a[best] < a[c]:
                    best = c
                c += 1
            if a[root] < a[best]:
                swap(a, root, best)
                root = best
            else:
                going = 0


def ternary_heap_sort(a: Arr, n: int):
    if n < 2:
        return
    s = (n - 2) // 3 + 1
    while s > 0:
        s -= 1
        sift(a, s, n)
    end = n - 1
    while end > 0:
        swap(a, 0, end)
        sift(a, 0, end)
        end -= 1
