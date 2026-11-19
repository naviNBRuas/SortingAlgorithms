from runtime import Arr, swap


def cmp_swap(a: Arr, i: int, j: int):
    if a[i] > a[j]:
        swap(a, i, j)


def odd_even_merge_sort(a: Arr, n: int):
    p = 1
    while p < n:
        k = p
        while k >= 1:
            j = k % p
            while j < n - k:
                lim = min(k, n - j - k)
                for i in range(0, lim):
                    if (i + j) // (2 * p) == (i + j + k) // (2 * p):
                        cmp_swap(a, i + j, i + j + k)
                j += 2 * k
            k = k // 2
        p *= 2
