
def flash_sort(arr, trace=None):
    """Sorts a list in ascending order using the FlashSort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    n = len(arr)
    if n == 0:
        return []

    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    m = int(0.45 * n)  # Number of buckets
    if m == 0: m = 1
    
    l = [0] * m

    min_val = arr[0]
    max_val = arr[0]
    for i in range(1, n):
        if arr[i] < min_val:
            min_val = arr[i]
        if arr[i] > max_val:
            max_val = arr[i]

    if min_val == max_val:
        return arr

    c = (m - 1) / (max_val - min_val)

    for i in range(n):
        k = int(c * (arr[i] - min_val))
        l[k] += 1

    for i in range(1, m):
        l[i] += l[i - 1]

    # Permutation phase
    flash = arr[l[m - 1] - 1]
    arr[l[m - 1] - 1] = arr[0]
    arr[0] = flash

    if trace is not None:
        trace['steps'].append({"type": "swap", "indices": [0, l[m-1]-1]})

    j = 0
    k = 0
    t = 0
    flash = 0
    while t < n - 1:
        while j >= l[k]:
            j += 1
            k = int(c * (arr[j] - min_val))
        flash = arr[j]
        while j != l[k]:
            k = int(c * (flash - min_val))
            l[k] -= 1
            temp = arr[l[k]]
            arr[l[k]] = flash
            flash = temp
            t += 1
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [j, l[k]]})

    # Insertion sort phase
    for i in range(1, n):
        j = i
        while j > 0 and arr[j] < arr[j - 1]:
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [j, j-1]})
            arr[j], arr[j - 1] = arr[j - 1], arr[j]
            if trace is not None:
                trace['steps'].append({"type": "swap", "indices": [j, j-1]})
            j -= 1

    return arr
