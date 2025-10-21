def counting_sort(arr):
    """
    Performs counting sort on a list of non-negative integers.

    Args:
        arr (list): The list of non-negative integers to sort.

    Returns:
        list: The sorted list.
    """
    if not arr:
        return []

    max_val = max(arr)
    count = [0] * (max_val + 1)
    output = [0] * len(arr)

    # Store count of each character
    for num in arr:
        count[num] += 1

    # Store cumulative count
    for i in range(1, max_val + 1):
        count[i] += count[i - 1]

    # Place elements in output array
    for num in reversed(arr):
        output[count[num] - 1] = num
        count[num] -= 1

    return output
