from runtime import Arr


def rank_of(a: Arr, n: int, start: int, item: int) -> int:
    pos = start
    for i in range(start + 1, n):
        if a[i] < item:
            pos += 1
    return pos


def cycle_sort(a: Arr, n: int):
    for start in range(0, n - 1):
        item = a[start]
        pos = rank_of(a, n, start, item)
        if pos != start:
            while item == a[pos]:
                pos += 1
            tmp = a[pos]
            a[pos] = item
            item = tmp
            while pos != start:
                pos = rank_of(a, n, start, item)
                while item == a[pos]:
                    pos += 1
                tmp = a[pos]
                a[pos] = item
                item = tmp
