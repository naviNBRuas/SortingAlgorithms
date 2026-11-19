from runtime import Arr, new_array


def height(ht: Arr, t: int) -> int:
    if t == 0:
        return 0
    return ht[t - 1]


def fix(lc: Arr, rc: Arr, ht: Arr, t: int):
    ht[t - 1] = 1 + max(height(ht, lc[t - 1]), height(ht, rc[t - 1]))


def rot_right(lc: Arr, rc: Arr, ht: Arr, y: int) -> int:
    x = lc[y - 1]
    lc[y - 1] = rc[x - 1]
    rc[x - 1] = y
    fix(lc, rc, ht, y)
    fix(lc, rc, ht, x)
    return x


def rot_left(lc: Arr, rc: Arr, ht: Arr, x: int) -> int:
    y = rc[x - 1]
    rc[x - 1] = lc[y - 1]
    lc[y - 1] = x
    fix(lc, rc, ht, x)
    fix(lc, rc, ht, y)
    return y


def insert(vals: Arr, lc: Arr, rc: Arr, ht: Arr, t: int, v: int) -> int:
    if t == 0:
        ht[v] = 1
        return v + 1
    if vals[v] < vals[t - 1]:
        lc[t - 1] = insert(vals, lc, rc, ht, lc[t - 1], v)
    else:
        rc[t - 1] = insert(vals, lc, rc, ht, rc[t - 1], v)
    fix(lc, rc, ht, t)
    bal = height(ht, lc[t - 1]) - height(ht, rc[t - 1])
    if bal > 1:
        l = lc[t - 1]
        if height(ht, lc[l - 1]) < height(ht, rc[l - 1]):
            lc[t - 1] = rot_left(lc, rc, ht, l)
        return rot_right(lc, rc, ht, t)
    if bal < -1:
        r = rc[t - 1]
        if height(ht, rc[r - 1]) < height(ht, lc[r - 1]):
            rc[t - 1] = rot_right(lc, rc, ht, r)
        return rot_left(lc, rc, ht, t)
    return t


def avl_tree_sort(a: Arr, n: int):
    if n < 2:
        return
    vals = new_array(n)
    lc = new_array(n)
    rc = new_array(n)
    ht = new_array(n)
    stack = new_array(n)
    for i in range(0, n):
        vals[i] = a[i]
    root = 0
    for i in range(0, n):
        root = insert(vals, lc, rc, ht, root, i)
    node = root
    sp = 0
    out = 0
    while node != 0 or sp > 0:
        if node != 0:
            stack[sp] = node
            sp += 1
            node = lc[node - 1]
        else:
            sp -= 1
            node = stack[sp]
            a[out] = vals[node - 1]
            out += 1
            node = rc[node - 1]
