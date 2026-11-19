from runtime import Arr, swap


def double_selection_sort(a: Arr, n: int):
    lo = 0
    hi = n - 1
    while lo < hi:
        mn = lo
        mx = lo
        j = lo + 1
        while j <= hi:
            if a[j] < a[mn]:
                mn = j
            elif a[j] > a[mx]:
                mx = j
            j += 1
        swap(a, lo, mn)
        if mx == lo:
            mx = mn
        swap(a, hi, mx)
        lo += 1
        hi -= 1
