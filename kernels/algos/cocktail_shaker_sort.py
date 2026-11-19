from runtime import Arr, swap


def cocktail_shaker_sort(a: Arr, n: int):
    lo = 0
    hi = n - 1
    swapped = 1
    while lo < hi and swapped == 1:
        swapped = 0
        i = lo
        while i < hi:
            if a[i] > a[i + 1]:
                swap(a, i, i + 1)
                swapped = 1
            i += 1
        hi -= 1
        i = hi
        while i > lo:
            if a[i - 1] > a[i]:
                swap(a, i - 1, i)
                swapped = 1
            i -= 1
        lo += 1
