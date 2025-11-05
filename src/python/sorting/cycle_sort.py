
def cycle_sort(arr, trace=None):
    """Sorts a list in ascending order using the Cycle Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    n = len(arr)
    if n == 0:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    for cycle_start in range(n - 1):
        item = arr[cycle_start]
        if trace is not None:
            trace['steps'].append({"type": "compare", "indices": [cycle_start, cycle_start]})

        # Find position where we put the item.
        pos = cycle_start
        for i in range(cycle_start + 1, n):
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [i, cycle_start]})
            if arr[i] < item:
                pos += 1

        # If the item is already in correct position
        if pos == cycle_start:
            continue

        # Ignore all duplicate elements
        while item == arr[pos]:
            pos += 1

        # Put the item into its right position
        arr[pos], item = item, arr[pos]
        if trace is not None:
            trace['steps'].append({"type": "swap", "indices": [pos, cycle_start]})

        # Rotate rest of the cycle
        while pos != cycle_start:
            pos = cycle_start
            for i in range(cycle_start + 1, n):
                if trace is not None:
                    trace['steps'].append({"type": "compare", "indices": [i, cycle_start]})
                if arr[i] < item:
                    pos += 1

            while item == arr[pos]:
                pos += 1

            arr[pos], item = item, arr[pos]
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [pos, cycle_start]})

    return arr
