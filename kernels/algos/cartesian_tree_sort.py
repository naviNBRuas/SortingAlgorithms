from runtime import Arr, new_array, swap


def sift_up(vals: Arr, heap: Arr, i: int):
    while i > 0 and vals[heap[i]] < vals[heap[(i - 1) // 2]]:
        swap(heap, i, (i - 1) // 2)
        i = (i - 1) // 2


def sift_down(vals: Arr, heap: Arr, size: int, i: int):
    going = 1
    while going == 1:
        c = 2 * i + 1
        if c >= size:
            going = 0
        else:
            if c + 1 < size and vals[heap[c + 1]] < vals[heap[c]]:
                c += 1
            if vals[heap[c]] < vals[heap[i]]:
                swap(heap, i, c)
                i = c
            else:
                going = 0


def cartesian_tree_sort(a: Arr, n: int):
    if n < 2:
        return
    vals = new_array(n)
    left = new_array(n)
    right = new_array(n)
    stack = new_array(n)
    heap = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
        left[i] = -1
        right[i] = -1
    sp = 0
    for i in range(0, n):
        last = -1
        while sp > 0 and vals[i] < vals[stack[sp - 1]]:
            sp -= 1
            last = stack[sp]
        left[i] = last
        if sp > 0:
            right[stack[sp - 1]] = i
        stack[sp] = i
        sp += 1
    heap[0] = stack[0]
    size = 1
    for out in range(0, n):
        node = heap[0]
        size -= 1
        heap[0] = heap[size]
        sift_down(vals, heap, size, 0)
        a[out] = vals[node]
        if left[node] >= 0:
            heap[size] = left[node]
            size += 1
            sift_up(vals, heap, size - 1)
        if right[node] >= 0:
            heap[size] = right[node]
            size += 1
            sift_up(vals, heap, size - 1)
