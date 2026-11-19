from runtime import Arr, swap


def odd_even_sort(a: Arr, n: int):
    done = 0
    while done == 0:
        done = 1
        start = 1
        while start >= 0:
            i = start
            while i + 1 < n:
                if a[i] > a[i + 1]:
                    swap(a, i, i + 1)
                    done = 0
                i += 2
            start -= 1
