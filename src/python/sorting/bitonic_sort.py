
def bitonic_sort(arr, trace=None):
    """Sorts a list in ascending order using the Bitonic Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if not arr:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    up = 1

    # Pad the array to the nearest power of 2
    next_power_of_2 = 1
    while next_power_of_2 < n:
        next_power_of_2 *= 2
    
    if n != next_power_of_2:
        padding = [float('inf')] * (next_power_of_2 - n)
        arr.extend(padding)

    _bitonic_sort_recursive(arr, 0, len(arr), up, trace)

    # Remove padding
    arr[:] = [x for x in arr if x != float('inf')]

    return arr

def _bitonic_sort_recursive(arr, low, cnt, di, trace):
    if cnt > 1:
        k = cnt // 2
        _bitonic_sort_recursive(arr, low, k, 1, trace) # sort in ascending order
        _bitonic_sort_recursive(arr, low + k, k, 0, trace) # sort in descending order
        _bitonic_merge(arr, low, cnt, di, trace)

def _bitonic_merge(arr, low, cnt, di, trace):
    if cnt > 1:
        k = cnt // 2
        for i in range(low, low + k):
            _compare_and_swap(arr, i, i + k, di, trace)
        _bitonic_merge(arr, low, k, di, trace)
        _bitonic_merge(arr, low + k, k, di, trace)

def _compare_and_swap(arr, i, j, di, trace):
    if trace is not None:
        trace['steps'].append({"type": "compare", "indices": [i, j]})
    if (arr[i] > arr[j] and di == 1) or (arr[i] < arr[j] and di == 0):
        arr[i], arr[j] = arr[j], arr[i]
        if trace is not None:
            trace['steps'].append({"type": "swap", "indices": [i, j]})
