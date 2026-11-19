from runtime import Arr, new_array


def better(vals: Arr, x: int, y: int) -> int:
    if x < 0:
        return y
    if y < 0:
        return x
    if vals[x] <= vals[y]:
        return x
    return y


def tournament_sort(a: Arr, n: int):
    if n < 2:
        return
    size = 1
    while size < n:
        size *= 2
    vals = new_array(n)
    out = new_array(n)
    tree = new_array(2 * size)
    for i in range(0, 2 * size):
        tree[i] = -1
    for i in range(0, n):
        vals[i] = a[i]
        tree[size + i] = i
    i = size - 1
    while i >= 1:
        tree[i] = better(vals, tree[2 * i], tree[2 * i + 1])
        i -= 1
    for k in range(0, n):
        w = tree[1]
        out[k] = vals[w]
        node = size + w
        tree[node] = -1
        node = node // 2
        while node >= 1:
            tree[node] = better(vals, tree[2 * node], tree[2 * node + 1])
            node = node // 2
    for i in range(0, n):
        a[i] = out[i]
