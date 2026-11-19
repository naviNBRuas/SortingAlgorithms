from runtime import Arr, new_array


def strand_sort(a: Arr, n: int):
    if n < 2:
        return
    rem = new_array(n)
    strand = new_array(n)
    out = new_array(n)
    tmp = new_array(n)
    for i in range(0, n):
        rem[i] = a[i]
    left = n
    o = 0
    while left > 0:
        strand[0] = rem[0]
        s = 1
        keep = 0
        for i in range(1, left):
            if rem[i] >= strand[s - 1]:
                strand[s] = rem[i]
                s += 1
            else:
                rem[keep] = rem[i]
                keep += 1
        left = keep
        i = 0
        j = 0
        k = 0
        while i < o and j < s:
            if strand[j] < out[i]:
                tmp[k] = strand[j]
                j += 1
            else:
                tmp[k] = out[i]
                i += 1
            k += 1
        while i < o:
            tmp[k] = out[i]
            i += 1
            k += 1
        while j < s:
            tmp[k] = strand[j]
            j += 1
            k += 1
        o = k
        for x in range(0, o):
            out[x] = tmp[x]
    for i in range(0, n):
        a[i] = out[i]
