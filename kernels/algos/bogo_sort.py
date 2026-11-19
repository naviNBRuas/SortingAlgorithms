from runtime import Arr, swap


def is_sorted(a: Arr, n: int) -> int:
    i = 0
    while i + 1 < n:
        if a[i] > a[i + 1]:
            return 0
        i += 1
    return 1


def bogo_sort(a: Arr, n: int, max_shuffles: int):
    state = 123456789
    count = 0
    while is_sorted(a, n) == 0 and count < max_shuffles:
        i = n - 1
        while i > 0:
            state = (state * 1103515245 + 12345) % 2147483648
            swap(a, i, (state // 16) % (i + 1))
            i -= 1
        count += 1
