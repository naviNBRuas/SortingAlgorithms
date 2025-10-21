def binary_search(arr, target, left=0, right=None):
    """
    Performs binary search on a sorted list within specified bounds.

    Args:
        arr (list): The sorted list to search within.
        target: The value to search for.
        left (int): The starting index of the search range (inclusive).
        right (int): The ending index of the search range (inclusive).

    Returns:
        int: The index of the target if found, otherwise -1.
    """
    if right is None:
        right = len(arr) - 1

    ans = -1
    while left <= right:
        mid = left + (right - left) // 2
        if arr[mid] == target:
            ans = mid  # Store this as a potential answer
            right = mid - 1 # Try to find an even earlier occurrence in the left half
        elif arr[mid] < target:
            left = mid + 1
        else:
            right = mid - 1
    return ans
