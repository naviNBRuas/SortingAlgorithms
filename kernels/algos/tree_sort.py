from runtime import Arr, new_array


def tree_sort(a: Arr, n: int):
    if n < 2:
        return
    vals = new_array(n)
    left = new_array(n)
    right = new_array(n)
    stack = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
    for i in range(1, n):
        cur = 0
        placed = 0
        while placed == 0:
            if vals[i] < vals[cur]:
                if left[cur] == 0:
                    left[cur] = i + 1
                    placed = 1
                else:
                    cur = left[cur] - 1
            else:
                if right[cur] == 0:
                    right[cur] = i + 1
                    placed = 1
                else:
                    cur = right[cur] - 1
    node = 1
    sp = 0
    out = 0
    while node != 0 or sp > 0:
        if node != 0:
            stack[sp] = node
            sp += 1
            node = left[node - 1]
        else:
            sp -= 1
            node = stack[sp]
            a[out] = vals[node - 1]
            out += 1
            node = right[node - 1]
