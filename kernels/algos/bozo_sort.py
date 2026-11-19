from runtime import Arr, swap


def is_sorted(a: Arr, n: int) -> int:
    i = 0
    while i + 1 < n:
        if a[i] > a[i + 1]:
            return 0
        i += 1
    return 1


def bozo_sort(a: Arr, n: int, max_swaps: int):
    state = 987654321
    count = 0
    while is_sorted(a, n) == 0 and count < max_swaps:
        state = (state * 1103515245 + 12345) % 2147483648
        i = (state // 16) % n
        state = (state * 1103515245 + 12345) % 2147483648
        swap(a, i, (state // 16) % n)
        count += 1
