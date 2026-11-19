from runtime import Arr, swap


def gnome_sort(a: Arr, n: int):
    i = 0
    while i < n:
        if i == 0 or a[i - 1] <= a[i]:
            i += 1
        else:
            swap(a, i - 1, i)
            i -= 1
