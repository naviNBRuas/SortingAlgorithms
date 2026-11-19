from runtime import Arr, swap


def cmp_swap(a: Arr, i: int, j: int):
    if a[i] > a[j]:
        swap(a, i, j)


def bitonic_sort(a: Arr, n: int):
    size = 1
    while size < n:
        size *= 2
    k = 2
    while k <= size:
        blk = 0
        while blk < size:
            for t in range(0, k // 2):
                j = blk + k - 1 - t
                if j < n:
                    cmp_swap(a, blk + t, j)
            blk += k
        j = k // 4
        while j >= 1:
            for i in range(0, size):
                if (i // j) % 2 == 0 and i + j < n:
                    cmp_swap(a, i, i + j)
            j = j // 2
        k *= 2
