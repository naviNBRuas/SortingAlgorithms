from runtime import Arr, swap


def sift(a: Arr, root: int, size: int):
    going = 1
    while going == 1:
        child = 2 * root + 1
        if child >= size:
            going = 0
        else:
            if child + 1 < size and a[child] < a[child + 1]:
                child += 1
            if a[root] < a[child]:
                swap(a, root, child)
                root = child
            else:
                going = 0


def heap_sort(a: Arr, n: int):
    s = n // 2
    while s > 0:
        s -= 1
        sift(a, s, n)
    end = n - 1
    while end > 0:
        swap(a, 0, end)
        sift(a, 0, end)
        end -= 1
