
def batcher_odd_even_merge_sort(arr, trace=None):
    """Sorts a list in ascending order using the Batcher Odd-Even Merge Sort algorithm.

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

    # Pad the array to the nearest power of 2
    next_power_of_2 = 1
    while next_power_of_2 < n:
        next_power_of_2 *= 2
    
    if n != next_power_of_2:
        padding = [float('inf')] * (next_power_of_2 - n)
        arr.extend(padding)

    _sort(arr, 0, len(arr), trace)

    # Remove padding
    arr[:] = [x for x in arr if x != float('inf')]

    return arr

def _sort(arr, lo, n, trace):
    if n > 1:
        m = n // 2
        _sort(arr, lo, m, trace)
        _sort(arr, lo + m, n - m, trace)
        _oddeven_merge(arr, lo, n, 1, trace)

def _oddeven_merge(arr, lo, n, r, trace):
    m = r * 2
    if m < n:
        _oddeven_merge(arr, lo, n, m, trace)
        _oddeven_merge(arr, lo + r, n, m, trace)
        i = lo + r
        while i < lo + n - r:
            _compare_and_swap(arr, i, i + r, trace)
            i += m
    else:
        _compare_and_swap(arr, lo, lo + r, trace)

def _compare_and_swap(arr, i, j, trace):
    if i < len(arr) and j < len(arr):
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [i, j]})
        if arr[i] > arr[j]:
            arr[i], arr[j] = arr[j], arr[i]
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [i, j]})
