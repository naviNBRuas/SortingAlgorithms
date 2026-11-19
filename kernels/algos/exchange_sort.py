from runtime import Arr, swap


def exchange_sort(a: Arr, n: int):
    for i in range(0, n - 1):
        for j in range(i + 1, n):
            if a[j] < a[i]:
                swap(a, i, j)
