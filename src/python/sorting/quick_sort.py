def quick_sort(arr, trace=None):
    """Sorts a list in ascending order using the Quick Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    _quick_sort_recursive(arr, 0, len(arr) - 1, trace)
    return arr

def _quick_sort_recursive(arr, low, high, trace):
    if low < high:
        pi = _partition(arr, low, high, trace)
        _quick_sort_recursive(arr, low, pi - 1, trace)
        _quick_sort_recursive(arr, pi + 1, high, trace)

def _partition(arr, low, high, trace):
    pivot = arr[high]
    i = low - 1

    for j in range(low, high):
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [j, high]})
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [i, j]})

    arr[i + 1], arr[high] = arr[high], arr[i + 1]
    if trace is not None:
        trace['steps'].append({"type": "swap", "indices": [i + 1, high]})
    return i + 1
