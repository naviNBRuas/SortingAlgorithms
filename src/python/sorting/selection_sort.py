def selection_sort(arr, trace=None):
    """Sorts a list in ascending order using the Selection Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    for i in range(n):
        min_idx = i
        for j in range(i + 1, n):
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [min_idx, j]})
            if arr[j] < arr[min_idx]:
                min_idx = j

        if min_idx != i:
            arr[i], arr[min_idx] = arr[min_idx], arr[i]
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [i, min_idx]})
    return arr
