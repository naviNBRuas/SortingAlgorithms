def bucket_sort(arr):
    """
    Performs bucket sort on a list of numbers.

    Args:
        arr (list): The list of numbers to sort.

    Returns:
        list: The sorted list.
    """
    if not arr:
        return []

    # Determine number of buckets
    num_buckets = 10 # A common choice, can be optimized
    max_val = max(arr)
    min_val = min(arr)
    range_val = max_val - min_val

    if range_val == 0: # All elements are the same
        return arr

    # Create empty buckets
    buckets = [[] for _ in range(num_buckets)]

    # Distribute elements into buckets
    for num in arr:
        # Calculate bucket index
        # Ensure index is within bounds for max_val
        index = int((num - min_val) * (num_buckets - 1) / range_val)
        buckets[index].append(num)

    # Sort each bucket and concatenate
    sorted_arr = []
    for bucket in buckets:
        bucket.sort()  # Use an internal sort (e.g., Timsort in Python)
        sorted_arr.extend(bucket)

    return sorted_arr
