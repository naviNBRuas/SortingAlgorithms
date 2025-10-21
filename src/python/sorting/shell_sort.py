def shell_sort(arr):
    """
    Performs Shell Sort on a list.

    Args:
        arr (list): The list to sort.

    Returns:
        list: The sorted list.
    """
    n = len(arr)
    # Start with a large gap, then reduce the gap
    gap = n // 2

    while gap > 0:
        for i in range(gap, n):
            temp = arr[i]
            j = i
            # Sort sub-list for this gap
            while j >= gap and arr[j - gap] > temp:
                arr[j] = arr[j - gap]
                j -= gap
            arr[j] = temp
        gap //= 2
    return arr
