from runtime import Arr, swap


def comb_sort(a: Arr, n: int):
    gap = n
    swapped = 1
    while gap > 1 or swapped == 1:
        gap = gap * 10 // 13
        if gap < 1:
            gap = 1
        swapped = 0
        i = 0
        while i + gap < n:
            if a[i] > a[i + gap]:
                swap(a, i, i + gap)
                swapped = 1
            i += 1
