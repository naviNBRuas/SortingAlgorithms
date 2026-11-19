from runtime import Arr, swap


def bubble_sort(a: Arr, n: int):
    end = n - 1
    swapped = 1
    while end > 0 and swapped == 1:
        swapped = 0
        j = 0
        while j < end:
            if a[j] > a[j + 1]:
                swap(a, j, j + 1)
                swapped = 1
            j += 1
        end -= 1
