from runtime import Arr, swap


def flip(a: Arr, k: int):
    i = 0
    while i < k:
        swap(a, i, k)
        i += 1
        k -= 1


def pancake_sort(a: Arr, n: int):
    size = n
    while size > 1:
        mx = 0
        i = 1
        while i < size:
            if a[i] > a[mx]:
                mx = i
            i += 1
        if mx != size - 1:
            if mx > 0:
                flip(a, mx)
            flip(a, size - 1)
        size -= 1
