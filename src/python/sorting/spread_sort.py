
def spread_sort(arr, trace=None):
    """Sorts a list in ascending order using the SpreadSort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if not arr:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    _spread_sort_recursive(arr, 0, len(arr) - 1, trace)
    return arr

def _spread_sort_recursive(arr, low, high, trace):
    if low >= high:
        return

    # Find min and max values in the current range
    min_val = arr[low]
    max_val = arr[low]
    for i in range(low + 1, high + 1):
        if arr[i] < min_val:
            min_val = arr[i]
        if arr[i] > max_val:
            max_val = arr[i]

    if min_val == max_val:
        return

    # Calculate histogram
    bins = [0] * (max_val - min_val + 1)
    for i in range(low, high + 1):
        bins[arr[i] - min_val] += 1

    # Place elements into their sorted positions
    current_pos = low
    for i in range(len(bins)):
        for _ in range(bins[i]):
            if trace is not None:
                # This is a simplified trace for placement, not a swap
                trace['steps'].append({"type": "insert", "indices": [current_pos], "value": min_val + i})
            arr[current_pos] = min_val + i
            current_pos += 1
