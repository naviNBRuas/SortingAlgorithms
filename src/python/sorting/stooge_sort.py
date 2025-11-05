
def stooge_sort(arr, trace=None):
    """Sorts a list in ascending order using the Stooge Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if not arr:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    _stooge_sort_recursive(arr, 0, len(arr) - 1, trace)
    return arr

def _stooge_sort_recursive(arr, i, j, trace):
    if trace is not None:
        trace['steps'].append({"type": "compare", "indices": [i, j]})
    if arr[i] > arr[j]:
        arr[i], arr[j] = arr[j], arr[i]
        if trace is not None:
            trace['steps'].append({"type": "swap", "indices": [i, j]})

    if i + 1 >= j:
        return

    t = (j - i + 1) // 3

    _stooge_sort_recursive(arr, i, j - t, trace)
    _stooge_sort_recursive(arr, i + t, j, trace)
    _stooge_sort_recursive(arr, i, j - t, trace)
