
def pancake_sort(arr, trace=None):
    """Sorts a list in ascending order using the Pancake Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    for curr_size in range(n, 1, -1):
        mi = _find_max(arr, curr_size)

        if mi != curr_size - 1:
            _flip(arr, mi, trace)
            _flip(arr, curr_size - 1, trace)

    return arr

def _find_max(arr, n):
    mi = 0
    for i in range(n):
        if arr[i] > arr[mi]:
            mi = i
    return mi

def _flip(arr, i, trace):
    start = 0
    while start < i:
        arr[start], arr[i] = arr[i], arr[start]
        if trace is not None:
            trace['steps'].append({"type": "swap", "indices": [start, i]})
        start += 1
        i -= 1
