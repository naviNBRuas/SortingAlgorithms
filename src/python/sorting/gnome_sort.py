def gnome_sort(arr, trace=None):
    """Sorts a list in ascending order using the Gnome Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    index = 0
    while index < n:
        if index == 0:
            index = index + 1
        if index < n and arr[index] >= arr[index - 1]:
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [index, index - 1]})
            index = index + 1
        else:
            if index < n:
                if trace is not None:
                    trace['steps'].append({"type": "compare", "indices": [index, index - 1]})
                arr[index], arr[index - 1] = arr[index - 1], arr[index]
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [index, index - 1]})
            index = index - 1
    return arr