
def smooth_sort(arr, trace=None):
    """Sorts a list in ascending order using the SmoothSort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    n = len(arr)
    if n == 0:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    # Leonardo numbers
    L = [1, 1]
    while L[-1] < n:
        L.append(L[-1] + L[-2] + 1)

    p = 1  # current Leonardo number index
    b = 1  # current block size

    for i in range(n):
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [i, i]})
        if b & 1:  # if b is odd
            _sift(arr, i, p, L, trace)
        else:
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [i, i-1]})
            if i > 0 and arr[i] < arr[i-1]:
                arr[i], arr[i-1] = arr[i-1], arr[i]
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [i, i-1]})
            _sift(arr, i, p, L, trace)

        if p > 1 and L[p-1] == b:
            p -= 1
            b = L[p]
        else:
            p += 1
            b = L[p]

    for i in range(n - 1, -1, -1):
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [i, i]})
        if p == 1:
            break
        if L[p-1] == b:
            p -= 1
            b = L[p]
        else:
            p -= 1
            b = L[p]
            _sift(arr, i, p, L, trace)

    return arr

def _sift(arr, i, p, L, trace):
    while p > 1:
        lc = i - L[p-1]
        rc = i - L[p-1] + L[p-2]
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [i, lc]})
        if arr[i] < arr[lc]:
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [i, rc]})
            if arr[i] < arr[rc]:
                break
            else:
                arr[i], arr[rc] = arr[rc], arr[i]
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [i, rc]})
                i = rc
                p -= 2
        else:
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [i, rc]})
            if arr[i] < arr[rc]:
                break
            else:
                arr[i], arr[lc] = arr[lc], arr[i]
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [i, lc]})
                i = lc
                p -= 1
