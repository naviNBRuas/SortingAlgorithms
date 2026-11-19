from runtime import Arr, swap


def selection_sort(a: Arr, n: int):
    for i in range(0, n - 1):
        m = i
        for j in range(i + 1, n):
            if a[j] < a[m]:
                m = j
        if m != i:
            swap(a, i, m)
