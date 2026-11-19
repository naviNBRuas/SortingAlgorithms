from runtime import Arr, new_array


def enumeration_sort(a: Arr, n: int):
    out = new_array(n)
    for i in range(0, n):
        rank = 0
        for j in range(0, n):
            if a[j] < a[i] or (a[j] == a[i] and j < i):
                rank += 1
        out[rank] = a[i]
    for i in range(0, n):
        a[i] = out[i]
