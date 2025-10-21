import random

def is_sorted(arr, trace=None):
    for i in range(len(arr) - 1):
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [i, i + 1]})
        if arr[i] > arr[i + 1]:
            return False
    return True

def bogo_sort(arr, trace=None):
    """Sorts a list in ascending order using the Bogo Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    while not is_sorted(arr, trace):
        random.shuffle(arr)
        if trace is not None:
            trace['steps'].append({"type": "shuffle", "array_state": list(arr)})
    return arr
