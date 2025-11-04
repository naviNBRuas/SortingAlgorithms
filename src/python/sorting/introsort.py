
def introsort(arr, trace=None):
    """Sorts a list in ascending order using the IntroSort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    max_depth = 2 * (len(arr).bit_length() - 1)
    _introsort_helper(arr, 0, len(arr) - 1, max_depth, trace)
    return arr

def _introsort_helper(arr, start, end, max_depth, trace):
    if end - start <= 16:
        _insertion_sort(arr, start, end, trace)
        return

    if max_depth == 0:
        _heapsort(arr, start, end, trace)
        return

    pivot = _partition(arr, start, end, trace)
    _introsort_helper(arr, start, pivot - 1, max_depth - 1, trace)
    _introsort_helper(arr, pivot + 1, end, max_depth - 1, trace)

def _partition(arr, start, end, trace):
    pivot = arr[end]
    i = start - 1
    for j in range(start, end):
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [j, end]})
        if arr[j] <= pivot:
            i += 1
            arr[i], arr[j] = arr[j], arr[i]
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [i, j]})
    arr[i + 1], arr[end] = arr[end], arr[i + 1]
    if trace is not None:
        trace['steps'].append({"type": "swap", "indices": [i + 1, end]})
    return i + 1

def _insertion_sort(arr, start, end, trace):
    for i in range(start + 1, end + 1):
        key = arr[i]
        j = i - 1
        while j >= start and arr[j] > key:
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [j, i]})
            arr[j + 1] = arr[j]
            if trace is not None:
                trace['steps'].append({"type": "shift", "indices": [j + 1, j]})
            j -= 1
        arr[j + 1] = key
        if trace is not None:
            trace['steps'].append({"type": "insert", "indices": [j + 1]})

def _heapsort(arr, start, end, trace):
    n = end - start + 1
    for i in range(n // 2 - 1, -1, -1):
        _heapify(arr, n, i, start, trace)

    for i in range(n - 1, 0, -1):
        arr[start], arr[start + i] = arr[start + i], arr[start]
        if trace is not None:
            trace['steps'].append({"type": "swap", "indices": [start, start + i]})
        _heapify(arr, i, 0, start, trace)

def _heapify(arr, n, i, start, trace):
    largest = i
    l = 2 * i + 1
    r = 2 * i + 2

    if l < n and arr[start + l] > arr[start + largest]:
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [start + l, start + largest]})
        largest = l

    if r < n and arr[start + r] > arr[start + largest]:
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [start + r, start + largest]})
        largest = r

    if largest != i:
        arr[start + i], arr[start + largest] = arr[start + largest], arr[start + i]
        if trace is not None:
            trace['steps'].append({"type": "swap", "indices": [start + i, start + largest]})
        _heapify(arr, n, largest, start, trace)
