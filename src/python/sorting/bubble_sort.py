def bubble_sort(arr, trace=None):
    """Sorts a list in ascending order using the Bubble Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    for i in range(n):
        for j in range(0, n - i - 1):
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [j, j + 1]})
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [j, j + 1]})
    return arr
