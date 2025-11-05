
def american_flag_sort(arr, trace=None):
    """Sorts a list in ascending order using the American Flag Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if not arr:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    _american_flag_sort_recursive(arr, 0, len(arr), 0, trace)
    return arr

def _american_flag_sort_recursive(arr, low, high, byte_index, trace):
    if high - low <= 1 or byte_index >= 4:  # Assuming integers up to 4 bytes
        return

    counts = [0] * 256
    for i in range(low, high):
        byte_val = (arr[i] >> (byte_index * 8)) & 0xFF
        counts[byte_val] += 1

    starts = [0] * 256
    starts[0] = low
    for i in range(1, 256):
        starts[i] = starts[i - 1] + counts[i - 1]

    for i in range(256):
        if counts[i] == 0:  # Skip empty buckets
            continue

        current_bucket_start = starts[i]
        current_bucket_end = starts[i] + counts[i]

        # Partition elements into their correct buckets
        j = current_bucket_start
        while j < current_bucket_end:
            byte_val = (arr[j] >> (byte_index * 8)) & 0xFF
            if byte_val == i:
                j += 1
            else:
                target_index = starts[byte_val]
                arr[j], arr[target_index] = arr[target_index], arr[j]
                if trace is not None:
                    trace['steps'].append({"type": "swap", "indices": [j, target_index]})
                starts[byte_val] += 1

    # Recursively sort each bucket
    current_pos = low
    for i in range(256):
        if counts[i] > 0:
            _american_flag_sort_recursive(arr, current_pos, current_pos + counts[i], byte_index + 1, trace)
            current_pos += counts[i]
