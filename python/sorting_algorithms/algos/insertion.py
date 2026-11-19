"""Insertion-based sorts: insertion, binary insertion, Shell, tree sorts, patience."""
from ..base import algorithm


@algorithm("insertion_sort", "Insertion Sort", "Insertion", "O(n)", "O(n²)", "O(n²)", "O(1)", True, True,
           "Grow a sorted prefix by shifting larger elements right and dropping each new key into the gap.",
           "Ancient (card-sorting by hand); analysed in Knuth TAOCP vol. 3.", adaptive=True)
def insertion_sort(a):
    for i in range(1, len(a)):
        key = a[i]
        j = i - 1
        while j >= 0 and a[j] > key:
            a[j + 1] = a[j]
            j -= 1
        if j + 1 != i:
            a[j + 1] = key


@algorithm("binary_insertion_sort", "Binary Insertion Sort", "Insertion", "O(n log n)", "O(n²)", "O(n²)", "O(1)", True, True,
           "Insertion sort that binary-searches the sorted prefix: O(n log n) comparisons, same O(n²) moves.",
           "Mauchly 1946 described binary insertion; used inside TimSort for short runs.")
def binary_insertion_sort(a):
    for i in range(1, len(a)):
        key = a[i]
        lo, hi = 0, i
        while lo < hi:
            mid = (lo + hi) // 2
            if key < a[mid]:
                hi = mid
            else:
                lo = mid + 1
        if lo != i:
            for j in range(i, lo, -1):
                a[j] = a[j - 1]
            a[lo] = key


def _gapped_insertion(a, gap):
    n = len(a)
    for i in range(gap, n):
        key = a[i]
        j = i
        while j >= gap and a[j - gap] > key:
            a[j] = a[j - gap]
            j -= gap
        if j != i:
            a[j] = key


@algorithm("shell_sort", "Shell Sort", "Insertion", "O(n log n)", "~O(n^1.5)", "O(n²)", "O(1)", False, True,
           "Gapped insertion sorts with gaps n/2, n/4, …, 1 (Shell's original sequence).",
           "Donald Shell, 1959 — the first algorithm to break the quadratic barrier.", adaptive=True)
def shell_sort(a):
    gap = len(a) // 2
    while gap > 0:
        _gapped_insertion(a, gap)
        gap //= 2


@algorithm("shell_sort_ciura", "Shell Sort (Ciura gaps)", "Insertion", "O(n log n)", "unknown (≈O(n^1.25))", "O(n²)", "O(1)", False, True,
           "Shell sort with Marcin Ciura's empirically optimal gap sequence 1, 4, 10, 23, 57, 132, 301, 701.",
           "Ciura 2001, 'Best Increments for the Average Case of Shell Sort'.", adaptive=True)
def shell_sort_ciura(a):
    n = len(a)
    gaps = [701, 301, 132, 57, 23, 10, 4, 1]
    g = 701
    while g * 2.25 < n:
        g = int(g * 2.25)
        gaps.insert(0, g)
    for gap in gaps:
        if gap < n:
            _gapped_insertion(a, gap)


class _Node:
    __slots__ = ("v", "left", "right", "h")

    def __init__(self, v):
        self.v = v
        self.left = self.right = None
        self.h = 1


def _inorder(root):
    out, stack, node = [], [], root
    while stack or node:
        while node:
            stack.append(node)
            node = node.left
        node = stack.pop()
        out.append(node.v)
        node = node.right
    return out


@algorithm("tree_sort", "Tree Sort (BST)", "Insertion", "O(n log n)", "O(n log n)", "O(n²)", "O(n)", True, False,
           "Insert every key into an unbalanced binary search tree, then read it back in order.",
           "Floyd 1962 and others; degenerates to a linked list on sorted input.")
def tree_sort(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    root = _Node(vals[0])
    for k, v in enumerate(vals[1:], 1):
        node = root
        while True:
            if v < node.v:
                if node.left is None:
                    node.left = _Node(v)
                    break
                node = node.left
            else:
                if node.right is None:
                    node.right = _Node(v)
                    break
                node = node.right
        a.show(_inorder(root) + vals[k + 1:], (), "insert")
    a.commit(_inorder(root))


def _h(n):
    return n.h if n else 0


def _fix(n):
    n.h = 1 + max(_h(n.left), _h(n.right))


def _rot_right(y):
    x = y.left
    y.left, x.right = x.right, y
    _fix(y)
    _fix(x)
    return x


def _rot_left(x):
    y = x.right
    x.right, y.left = y.left, x
    _fix(x)
    _fix(y)
    return y


def _avl_insert(node, v):
    if node is None:
        return _Node(v)
    if v < node.v:
        node.left = _avl_insert(node.left, v)
    else:
        node.right = _avl_insert(node.right, v)
    _fix(node)
    bal = _h(node.left) - _h(node.right)
    if bal > 1:
        if _h(node.left.left) < _h(node.left.right):
            node.left = _rot_left(node.left)
        return _rot_right(node)
    if bal < -1:
        if _h(node.right.right) < _h(node.right.left):
            node.right = _rot_right(node.right)
        return _rot_left(node)
    return node


@algorithm("avl_tree_sort", "AVL Tree Sort", "Insertion", "O(n log n)", "O(n log n)", "O(n log n)", "O(n)", True, False,
           "Tree sort on a self-balancing AVL tree, so sorted input no longer degrades it.",
           "Adelson-Velsky & Landis, 1962.")
def avl_tree_sort(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    root = None
    for k, v in enumerate(vals):
        root = _avl_insert(root, v)
        a.show(_inorder(root) + vals[k + 1:], (), "insert")
    a.commit(_inorder(root))


@algorithm("patience_sort", "Patience Sort", "Insertion", "O(n log n)", "O(n log n)", "O(n log n)", "O(n)", False, False,
           "Deal cards onto piles (binary-searching the leftmost legal pile), then merge the piles.",
           "Named by Mallows 1960s after the card game; yields the longest increasing subsequence length for free.")
def patience_sort(a):
    import heapq
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    piles = []
    for k, x in enumerate(vals):
        lo, hi = 0, len(piles)
        while lo < hi:
            mid = (lo + hi) // 2
            if piles[mid][-1] < x:
                lo = mid + 1
            else:
                hi = mid
        if lo == len(piles):
            piles.append([x])
        else:
            piles[lo].append(x)
        a.show([v for p in piles for v in p] + vals[k + 1:], (), "deal")

    class _Top:
        __slots__ = ("p", "i")

        def __init__(self, p, i):
            self.p, self.i = p, i

        def __lt__(self, o):
            return piles[self.p][self.i] < piles[o.p][o.i]

    heap = [_Top(p, len(pile) - 1) for p, pile in enumerate(piles)]
    heapq.heapify(heap)
    out = []
    while heap:
        t = heapq.heappop(heap)
        out.append(piles[t.p][t.i])
        if t.i:
            heapq.heappush(heap, _Top(t.p, t.i - 1))
        a.show(out + [v for p in piles for v in p][: n - len(out)], (len(out) - 1,), "collect")
    a.commit(out)


def _ford_johnson(items, a=None):
    n = len(items)
    if n < 2:
        return items
    pairs = []
    for i in range(0, n - 1, 2):
        x, y = items[i], items[i + 1]
        if y < x:
            x, y = y, x
        pairs.append((x, y))
    straggler = items[-1] if n % 2 else None
    partner = {id(big): small for small, big in pairs}
    sorted_big = _ford_johnson([big for _, big in pairs])
    b = [None] + [partner[id(big)] for big in sorted_big]      # b[i] is the partner of sorted_big[i-1]
    m = len(sorted_big)
    chain = [b[1]] + sorted_big
    total = m
    if straggler is not None:
        b.append(straggler)
        total += 1
    prev, k = 1, 2
    while prev < total:
        top = min((2 ** (k + 1) + (-1) ** k) // 3, total)      # Jacobsthal-number group boundary
        for i in range(top, prev, -1):
            bound = len(chain)
            if i <= m:
                big = sorted_big[i - 1]
                bound = next(j for j, x in enumerate(chain) if x is big)
            lo, hi = 0, bound
            while lo < hi:
                mid = (lo + hi) // 2
                if b[i] < chain[mid]:
                    hi = mid
                else:
                    lo = mid + 1
            chain.insert(lo, b[i])
            if a is not None:
                pending = [b[j] for j in range(2, total + 1) if j < i or (j > top)]
                a.show(chain + pending, (lo,), "insert")
        prev, k = top, k + 1
    return chain


@algorithm("ford_johnson_sort", "Merge-Insertion Sort (Ford–Johnson)", "Insertion", "O(n log n)", "O(n log n)", "O(n log n)", "O(n)", False, False,
           "Pair up elements, recursively sort the winners, then binary-insert the losers in Jacobsthal order. "
           "Uses the fewest comparisons of any known algorithm for small n.",
           "Lester Ford Jr. & Selmer Johnson, 1959; optimal for n ≤ 22 (Peczarski 2004).", viz_n=40)
def ford_johnson_sort(a):
    n = len(a)
    if n < 2:
        return
    a.commit(_ford_johnson([a[i] for i in range(n)], a))


@algorithm("library_sort", "Library Sort (Gapped Insertion)", "Insertion", "O(n log n)", "O(n log n) expected", "O(n²)", "O(n)", True, False,
           "Insertion sort into an array that keeps gaps, like a librarian leaving shelf space; rebalanced as it doubles.",
           "Bender, Farach-Colton & Mosteiro 2004, 'Insertion Sort is O(n log n)'.", viz_n=48)
def library_sort(a):
    n = len(a)
    if n < 2:
        return
    vals = [a[i] for i in range(n)]
    size = 2 * n + 2
    S = [None] * size

    def spread(count):
        items = [x for x in S if x is not None]
        for i in range(size):
            S[i] = None
        for j, x in enumerate(items):
            S[(j * size) // max(count, 1)] = x

    def locate(x):
        lo, hi = 0, size - 1
        while lo <= hi:
            mid = (lo + hi) // 2
            m = mid
            while m <= hi and S[m] is None:
                m += 1
            if m > hi:
                hi = mid - 1
            elif x < S[m]:
                hi = mid - 1
            else:
                lo = m + 1
        return lo

    for k, x in enumerate(vals):
        if k and (k & (k - 1)) == 0:
            spread(k)                                   # rebalance whenever the count doubles
        lo = locate(x)
        p = lo - 1
        while p >= 0 and S[p] is None:
            p -= 1
        q = lo
        while q < size and S[q] is None:
            q += 1
        if q - p > 1:
            S[(p + q) // 2] = x
        else:                                           # no gap between neighbours: shift to the nearest gap
            g = q
            while g < size and S[g] is not None:
                g += 1
            if g < size:
                for j in range(g, q, -1):
                    S[j] = S[j - 1]
                S[q] = x
            else:
                g = p
                while S[g] is not None:
                    g -= 1
                for j in range(g, p):
                    S[j] = S[j + 1]
                S[p] = x
        a.show([y for y in S if y is not None] + vals[k + 1:], (), "insert")
    a.commit([y for y in S if y is not None])


@algorithm("cartesian_tree_sort", "Cartesian Tree Sort", "Insertion", "O(n)", "O(n log n)", "O(n log n)", "O(n)", False, False,
           "Build a Cartesian tree in O(n), then emit minima with a priority queue holding only the tree frontier; adaptive to presortedness.",
           "Levcopoulos & Petersson, 1989 ('Heapsort — adapted for presorted files').", adaptive=True)
def cartesian_tree_sort(a):
    import heapq
    n = len(a)
    if n < 2:
        return
    vals = [a[i] for i in range(n)]
    left, right, stack = [-1] * n, [-1] * n, []
    for i, v in enumerate(vals):
        last = -1
        while stack and v < vals[stack[-1]]:
            last = stack.pop()
        left[i] = last
        if stack:
            right[stack[-1]] = i
        stack.append(i)

    class _Node:
        __slots__ = ("i",)

        def __init__(self, i):
            self.i = i

        def __lt__(self, o):
            return vals[self.i] < vals[o.i]

    heap = [_Node(stack[0])]
    out, done = [], [False] * n
    while heap:
        node = heapq.heappop(heap)
        out.append(vals[node.i])
        done[node.i] = True
        for c in (left[node.i], right[node.i]):
            if c >= 0:
                heapq.heappush(heap, _Node(c))
        a.show(out + [vals[j] for j in range(n) if not done[j]], (len(out) - 1,), "extract")
    a.commit(out)
