from runtime import Arr, new_array


def shell_sort_ciura(a: Arr, n: int):
    g = new_array(10)
    g[0] = 1
    g[1] = 4
    g[2] = 10
    g[3] = 23
    g[4] = 57
    g[5] = 132
    g[6] = 301
    g[7] = 701
    g[8] = 1750
    g[9] = 4377
    k = 9
    while k >= 0:
        gap = g[k]
        if gap < n:
            for i in range(gap, n):
                key = a[i]
                j = i
                while j >= gap and a[j - gap] > key:
                    a[j] = a[j - gap]
                    j -= gap
                a[j] = key
        k -= 1
