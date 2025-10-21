from src.python.searching.binary_search import binary_search

def exponential_search(arr, target):
    """
    Performs exponential search on a sorted list.

    Args:
        arr (list): The sorted list to search within.
        target: The value to search for.

    Returns:
        int: The index of the target if found, otherwise -1.
    """
    n = len(arr)
    if n == 0:
        return -1

    # If target is at the first position
    if arr[0] == target:
        return 0

    # Find range for binary search by repeated doubling
    i = 1
    while i < n and arr[i] <= target:
        i *= 2

    # Call binary search for the found range
    # The range is from i/2 to min(i, n-1)
    return binary_search(arr, target, i // 2, min(i, n) - 1)
