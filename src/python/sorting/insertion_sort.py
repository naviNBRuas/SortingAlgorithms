def insertion_sort(arr, trace=None):
    """Sorts a list in ascending order using the Insertion Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    for i in range(1, n):
        key = arr[i]
        j = i - 1

        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [j, i]})

        while j >= 0 and key < arr[j]:
            if trace is not None:
                trace['steps'].append({"type": "shift", "indices": [j + 1, j]})
            arr[j + 1] = arr[j]
            j -= 1
            if j >= 0 and trace is not None:
                trace['steps'].append({"type": "compare", "indices": [j, i]})

        arr[j + 1] = key
        if trace is not None and j + 1 != i:
            trace['steps'].append({"type": "insert", "indices": [j + 1, i]})

    return arr
