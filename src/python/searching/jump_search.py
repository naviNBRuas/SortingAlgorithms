import math

def jump_search(arr, target):
    """
    Performs jump search on a sorted list.

    Args:
        arr (list): The sorted list to search within.
        target: The value to search for.

    Returns:
        int: The index of the target if found, otherwise -1.
    """
    n = len(arr)
    if n == 0:
        return -1

    # Finding block size to be jumped
    step = int(math.sqrt(n))

    # Finding the block where element is present (if it is present)
    prev = 0
    while arr[min(step, n) - 1] < target:
        prev = step
        step += int(math.sqrt(n))
        if prev >= n:
            return -1

    # Doing a linear search for x in block beginning with prev.
    while arr[prev] < target:
        prev += 1

        # If we reached next block or end of array, element is not present.
        if prev == min(step, n):
            return -1

    # If element is found
    if arr[prev] == target:
        return prev

    return -1
