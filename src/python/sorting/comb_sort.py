def comb_sort(arr, trace=None):
    """Sorts a list in ascending order using the Comb Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    n = len(arr)
    gap = n
    shrink = 1.3
    swapped = True

    while gap > 1 or swapped:
        gap = int(gap / shrink)
        if gap < 1:
            gap = 1

        swapped = False
        for i in range(n - gap):
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [i, i + gap]})
            if arr[i] > arr[i + gap]:
                arr[i], arr[i + gap] = arr[i + gap], arr[i]
                swapped = True
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [i, i + gap]})
    return arr
