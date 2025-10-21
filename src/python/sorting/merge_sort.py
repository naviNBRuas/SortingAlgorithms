def merge_sort(arr, trace=None):
    """Sorts a list in ascending order using the Merge Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    _merge_sort_recursive(arr, 0, len(arr) - 1, trace)
    return arr

def _merge_sort_recursive(arr, l, r, trace):
    if l < r:
        m = (l + r) // 2

        _merge_sort_recursive(arr, l, m, trace)
        _merge_sort_recursive(arr, m + 1, r, trace)
        _merge(arr, l, m, r, trace)

def _merge(arr, l, m, r, trace):
    n1 = m - l + 1
    n2 = r - m

    L = [0] * n1
    R = [0] * n2

    for i in range(n1):
        L[i] = arr[l + i]
    for j in range(n2):
        R[j] = arr[m + 1 + j]

    i = 0
    j = 0
    k = l

    while i < n1 and j < n2:
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [l + i, m + 1 + j]})
        if L[i] <= R[j]:
            arr[k] = L[i]
            i += 1
        else:
            arr[k] = R[j]
            j += 1
        if trace is not None:
            trace['steps'].append({"type": "merge_write", "indices": [k], "value": arr[k]})
        k += 1

    while i < n1:
        arr[k] = L[i]
        if trace is not None:
            trace['steps'].append({"type": "merge_write", "indices": [k], "value": arr[k]})
        i += 1
        k += 1

    while j < n2:
        arr[k] = R[j]
        if trace is not None:
            trace['steps'].append({"type": "merge_write", "indices": [k], "value": arr[k]})
        j += 1
        k += 1
