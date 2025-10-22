def fibonacci_search(arr, target):
    """
    Performs Fibonacci Search on a sorted list.

    Args:
        arr (list): The sorted list to search within.
        target: The value to search for.

    Returns:
        int: The index of the target if found, otherwise -1.
    """
    n = len(arr)
    if n == 0:
        return -1

    # Initialize Fibonacci numbers
    fib_m_minus_2 = 0  # (m-2)'th Fibonacci No.
    fib_m_minus_1 = 1  # (m-1)'th Fibonacci No.
    fib_m = fib_m_minus_1 + fib_m_minus_2  # m'th Fibonacci

    # fib_m must be >= n
    while fib_m < n:
        fib_m_minus_2 = fib_m_minus_1
        fib_m_minus_1 = fib_m
        fib_m = fib_m_minus_1 + fib_m_minus_2

    # Marks the eliminated range from front
    offset = -1

    # while there are elements to be inspected. Note that
    # we compare arr[fib_m_minus_2] with target
    while fib_m > 1:
        # Check if fib_m_minus_2 is a valid index
        i = min(offset + fib_m_minus_2, n - 1)

        # If target is greater than the value at index fib_m_minus_2,
        # cut the array from offset + fib_m_minus_2 + 1 to end
        if arr[i] < target:
            fib_m = fib_m_minus_1
            fib_m_minus_1 = fib_m_minus_2
            fib_m_minus_2 = fib_m - fib_m_minus_1
            offset = i

        # If target is smaller than the value at index fib_m_minus_2,
        # cut the array from start to offset + fib_m_minus_2
        elif arr[i] > target:
            fib_m = fib_m_minus_2
            fib_m_minus_1 = fib_m_minus_1 - fib_m_minus_2
            fib_m_minus_2 = fib_m - fib_m_minus_1

        # Element found
        else:
            return i

    # Compare the last element with target
    if fib_m_minus_1 == 1 and (offset + 1) < n and arr[offset + 1] == target:
        return offset + 1

    return -1
