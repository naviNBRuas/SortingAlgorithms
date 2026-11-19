from runtime import Arr, swap


def circle_pass(a: Arr, lo: int, hi: int) -> int:
    m = hi - lo
    if m < 2:
        return 0
    swaps = 0
    half = m // 2
    i = 0
    while i < half:
        if a[hi - 1 - i] < a[lo + i]:
            swap(a, hi - 1 - i, lo + i)
            swaps += 1
        i += 1
    if m % 2 == 1:
        if a[lo + half] < a[lo + half - 1]:
            swap(a, lo + half - 1, lo + half)
            swaps += 1
    swaps += circle_pass(a, lo, lo + half)
    swaps += circle_pass(a, lo + half, hi)
    return swaps


def circle_sort(a: Arr, n: int):
    s = 1
    while s > 0:
        s = circle_pass(a, 0, n)
