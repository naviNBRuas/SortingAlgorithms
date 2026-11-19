from runtime import Arr, new_array


def radix_sort_lsd(a: Arr, n: int):
    if n < 2:
        return
    mn = a[0]
    mx = a[0]
    for i in range(1, n):
        if a[i] < mn:
            mn = a[i]
        if a[i] > mx:
            mx = a[i]
    out = new_array(n)
    count = new_array(11)
    exp = 1
    while (mx - mn) // exp > 0:
        for d in range(0, 11):
            count[d] = 0
        for i in range(0, n):
            count[((a[i] - mn) // exp) % 10 + 1] += 1
        for d in range(1, 11):
            count[d] += count[d - 1]
        for i in range(0, n):
            d = ((a[i] - mn) // exp) % 10
            out[count[d]] = a[i]
            count[d] += 1
        for i in range(0, n):
            a[i] = out[i]
        exp *= 10
