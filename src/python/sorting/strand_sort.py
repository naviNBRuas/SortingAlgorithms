
def strand_sort(arr, trace=None):
    """Sorts a list in ascending order using the Strand Sort algorithm.

    Args:
        arr: The list of numbers to sort.
        trace: A dictionary to store the execution trace for visualization.
    """
    if trace is not None:
        trace['initial_array'] = list(arr)
        trace['steps'] = []

    output = []
    while len(arr) > 0:
        sublist = []
        sublist.append(arr.pop(0))
        i = 0
        while i < len(arr):
            if trace is not None:
                trace['steps'].append({"type": "compare", "indices": [len(sublist) - 1, i]})
            if arr[i] > sublist[-1]:
                sublist.append(arr.pop(i))
            else:
                i += 1
        
        # Merge sublist into output
        output_len = len(output)
        sublist_len = len(sublist)
        merged = []
        i = 0
        j = 0
        while i < output_len and j < sublist_len:
            if output[i] < sublist[j]:
                merged.append(output[i])
                i += 1
            else:
                merged.append(sublist[j])
                j += 1
        
        while i < output_len:
            merged.append(output[i])
            i += 1
        
        while j < sublist_len:
            merged.append(sublist[j])
            j += 1
        output = merged
        if trace is not None:
            trace['steps'].append({"type": "merge_write", "value": sublist, "indices": list(range(len(output)))})

    return output
