def linear_search(arr, target):
    """
    Performs linear search on a list.

    Args:
        arr (list): The list to search within.
        target: The value to search for.

    Returns:
        int: The index of the target if found, otherwise -1.
    """
    for i in range(len(arr)):
        if arr[i] == target:
            return i
    return -1
