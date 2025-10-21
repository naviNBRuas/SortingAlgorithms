def cocktail_shaker_sort(arr):
    """
    Performs Cocktail Shaker Sort on a list.

    Args:
        arr (list): The list to sort.

    Returns:
        list: The sorted list.
    """
    n = len(arr)
    swapped = True
    start = 0
    end = n - 1

    while swapped:
        swapped = False

        # Traverse from left to right (like bubble sort)
        for i in range(start, end):
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True

        if not swapped:
            break

        swapped = False

        end -= 1

        # Traverse from right to left
        for i in range(end - 1, start - 1, -1):
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True

        start += 1

    return arr
