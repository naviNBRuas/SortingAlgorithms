from runtime import Arr, new_array, swap


def permutation_sort(a: Arr, n: int):
    vals = new_array(n)
    idx = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
        idx[i] = i
    found = 0
    while found == 0:
        ok = 1
        for i in range(0, n - 1):
            if vals[idx[i + 1]] < vals[idx[i]]:
                ok = 0
        if ok == 1:
            found = 1
        else:
            i = n - 2
            while i >= 0 and idx[i] > idx[i + 1]:
                i -= 1
            if i < 0:
                found = 1
            else:
                j = n - 1
                while idx[j] < idx[i]:
                    j -= 1
                swap(idx, i, j)
                lo = i + 1
                hi = n - 1
                while lo < hi:
                    swap(idx, lo, hi)
                    lo += 1
                    hi -= 1
    for i in range(0, n):
        a[i] = vals[idx[i]]
