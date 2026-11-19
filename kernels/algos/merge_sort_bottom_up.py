from runtime import Arr, new_array


def merge_sort_bottom_up(a: Arr, n: int):
    tmp = new_array(n)
    width = 1
    while width < n:
        lo = 0
        while lo < n:
            mid = min(lo + width, n)
            hi = min(lo + 2 * width, n)
            for x in range(lo, mid):
                tmp[x] = a[x]
            i = lo
            j = mid
            k = lo
            while i < mid and j < hi:
                if a[j] < tmp[i]:
                    a[k] = a[j]
                    j += 1
                else:
                    a[k] = tmp[i]
                    i += 1
                k += 1
            while i < mid:
                a[k] = tmp[i]
                i += 1
                k += 1
            lo += 2 * width
        width *= 2
