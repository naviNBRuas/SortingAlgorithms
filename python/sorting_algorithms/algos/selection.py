"""Selection-based sorts: selection, heap family, cycle, tournament."""
from ..base import algorithm


@algorithm("selection_sort", "Selection Sort", "Selection", "O(n²)", "O(n²)", "O(n²)", "O(1)", False, True,
           "Repeatedly select the minimum of the unsorted suffix and swap it into place: exactly n−1 swaps.",
           "Folklore; analysed in Knuth TAOCP vol. 3 §5.2.3.")
def selection_sort(a):
    n = len(a)
    for i in range(n - 1):
        m = i
        for j in range(i + 1, n):
            if a[j] < a[m]:
                m = j
        if m != i:
            a.swap(i, m)


@algorithm("double_selection_sort", "Double Selection Sort", "Selection", "O(n²)", "O(n²)", "O(n²)", "O(1)", False, True,
           "Each pass picks both the minimum and the maximum, halving the number of passes.",
           "Common optimisation of selection sort (also 'bidirectional selection').")
def double_selection_sort(a):
    lo, hi = 0, len(a) - 1
    while lo < hi:
        mn = mx = lo
        for j in range(lo + 1, hi + 1):
            if a[j] < a[mn]:
                mn = j
            elif a[j] > a[mx]:
                mx = j
        a.swap(lo, mn)
        if mx == lo:
            mx = mn
        a.swap(hi, mx)
        lo += 1
        hi -= 1


@algorithm("bingo_sort", "Bingo Sort", "Selection", "O(n + k·n)", "O(n·k)", "O(n²)", "O(1)", False, True,
           "Selection sort variant that moves every copy of the current maximum at once; fast with many duplicates.",
           "Described in the NIST Dictionary of Algorithms and Data Structures.", adaptive=True)
def bingo_sort(a):
    n = len(a)
    if n < 2:
        return
    mx = n - 1
    nxt = a[mx]
    for i in range(mx - 1, -1, -1):
        if a[i] > nxt:
            nxt = a[i]
    while mx > 0 and a[mx] == nxt:
        mx -= 1
    while mx > 0:
        bingo = nxt
        nxt = a[mx]
        for i in range(mx - 1, -1, -1):
            if a[i] == bingo:
                a.swap(i, mx)
                mx -= 1
            elif a[i] > nxt:
                nxt = a[i]
        while mx > 0 and a[mx] == nxt:
            mx -= 1


@algorithm("cycle_sort", "Cycle Sort", "Selection", "O(n²)", "O(n²)", "O(n²)", "O(1)", False, True,
           "Rotates each permutation cycle into place; performs the theoretical minimum number of writes.",
           "B. K. Haddon, 1990.")
def cycle_sort(a):
    n = len(a)
    for start in range(n - 1):
        item = a[start]
        pos = start
        for i in range(start + 1, n):
            if a[i] < item:
                pos += 1
        if pos == start:
            continue
        while item == a[pos]:
            pos += 1
        tmp = a[pos]
        a[pos] = item
        item = tmp
        while pos != start:
            pos = start
            for i in range(start + 1, n):
                if a[i] < item:
                    pos += 1
            while item == a[pos]:
                pos += 1
            tmp = a[pos]
            a[pos] = item
            item = tmp


def _sift_down(a, root, end, base=0):
    while True:
        child = 2 * root + 1
        if child > end:
            return
        if child + 1 <= end and a[base + child] < a[base + child + 1]:
            child += 1
        if a[base + root] < a[base + child]:
            a.swap(base + root, base + child)
            root = child
        else:
            return


@algorithm("heap_sort", "Heap Sort", "Selection", "O(n log n)", "O(n log n)", "O(n log n)", "O(1)", False, True,
           "Build a max-heap, then repeatedly swap the root to the end and restore the heap.",
           "J. W. J. Williams 1964; Floyd's linear-time heap construction the same year.")
def heap_sort(a):
    n = len(a)
    for s in range((n - 2) // 2, -1, -1):
        _sift_down(a, s, n - 1)
    for end in range(n - 1, 0, -1):
        a.swap(0, end)
        _sift_down(a, 0, end - 1)


_LP = [1, 1]
while len(_LP) < 90:
    _LP.append(_LP[-1] + _LP[-2] + 1)


@algorithm("smooth_sort", "Smooth Sort", "Selection", "O(n)", "O(n log n)", "O(n log n)", "O(1)", False, True,
           "Heap sort over a forest of Leonardo heaps; approaches O(n) on nearly sorted input.",
           "Edsger Dijkstra 1981 (EWD796a); this follows Orson Peters' formulation.", adaptive=True)
def smooth_sort(a):
    def sift(head, pshift):
        val = a[head]
        while pshift > 1:
            rt = head - 1
            lf = head - 1 - _LP[pshift - 2]
            if val >= a[lf] and val >= a[rt]:
                break
            if a[lf] >= a[rt]:
                a[head] = a[lf]
                head = lf
                pshift -= 1
            else:
                a[head] = a[rt]
                head = rt
                pshift -= 2
        a[head] = val

    def trinkle(head, p, pshift, trusty):
        val = a[head]
        while p != 1:
            stepson = head - _LP[pshift]
            if a[stepson] <= val:
                break
            if not trusty and pshift > 1:
                rt = head - 1
                lf = head - 1 - _LP[pshift - 2]
                if a[rt] >= a[stepson] or a[lf] >= a[stepson]:
                    break
            a[head] = a[stepson]
            head = stepson
            trail = ((p & ~1) & -(p & ~1)).bit_length() - 1
            p >>= trail
            pshift += trail
            trusty = False
        if not trusty:
            a[head] = val
            sift(head, pshift)

    n = len(a)
    if n < 2:
        return
    hi = n - 1
    head, p, pshift = 0, 1, 1
    while head < hi:
        if (p & 3) == 3:
            sift(head, pshift)
            p >>= 2
            pshift += 2
        else:
            if _LP[pshift - 1] >= hi - head:
                trinkle(head, p, pshift, False)
            else:
                sift(head, pshift)
            if pshift == 1:
                p <<= 1
                pshift = 0
            else:
                p <<= pshift - 1
                pshift = 1
        p |= 1
        head += 1
    trinkle(head, p, pshift, False)
    while pshift != 1 or p != 1:
        if pshift <= 1:
            trail = ((p & ~1) & -(p & ~1)).bit_length() - 1
            p >>= trail
            pshift += trail
        else:
            p <<= 2
            p ^= 7
            pshift -= 2
            trinkle(head - _LP[pshift] - 1, p >> 1, pshift + 1, True)
            trinkle(head - 1, p, pshift, True)
        head -= 1


@algorithm("tournament_sort", "Tournament Sort", "Selection", "O(n log n)", "O(n log n)", "O(n log n)", "O(n)", True, False,
           "Plays a knockout tournament to find the minimum, then replays only the winner's path per extraction.",
           "Knuth TAOCP vol. 3 §5.2.3 (replacement selection / tree selection).")
def tournament_sort(a):
    n = len(a)
    if n < 2:
        return
    vals = [a[i] for i in range(n)]
    size = 1
    while size < n:
        size *= 2
    tree = [-1] * (2 * size)
    for i in range(n):
        tree[size + i] = i

    def better(x, y):
        if x < 0:
            return y
        if y < 0:
            return x
        return x if vals[x] <= vals[y] else y

    for i in range(size - 1, 0, -1):
        tree[i] = better(tree[2 * i], tree[2 * i + 1])
    out = []
    for _ in range(n):
        w = tree[1]
        out.append(vals[w])
        view = out + [vals[i] for i in range(n) if tree[size + i] >= 0 and i != w]
        a.show(view, (len(out) - 1,), "extract")
        node = size + w
        tree[node] = -1
        node //= 2
        while node:
            tree[node] = better(tree[2 * node], tree[2 * node + 1])
            node //= 2
    a.commit(out)


@algorithm("weak_heap_sort", "Weak Heap Sort", "Selection", "O(n log n)", "O(n log n)", "O(n log n)", "O(n) bits", False, True,
           "Heap sort on a weak heap (a binary tree with a reverse bit per node); near-optimal comparison count.",
           "Dutton 1993; Edelkamp & Wegener 2002.")
def weak_heap_sort(a):
    n = len(a)
    if n < 2:
        return
    r = [0] * n

    def gparent(j):
        while (j & 1) == r[j >> 1]:
            j >>= 1
        return j >> 1

    def join(i, j):
        if a[i] < a[j]:
            a.swap(i, j)
            r[j] ^= 1

    for j in range(n - 1, 0, -1):
        join(gparent(j), j)
    for m in range(n - 1, 1, -1):
        a.swap(0, m)
        x = 1
        while 2 * x + r[x] < m:
            x = 2 * x + r[x]
        while x > 0:
            join(0, x)
            x >>= 1
    a.swap(0, 1)


@algorithm("bottom_up_heap_sort", "Bottom-Up Heap Sort", "Selection", "O(n log n)", "O(n log n)", "O(n log n)", "O(1)", False, True,
           "Heap sort whose sift-down first descends along larger children to a leaf, then climbs back to the key's slot: ~n log n comparisons instead of 2 n log n.",
           "Ingo Wegener, 1993 ('Bottom-up heapsort').")
def bottom_up_heap_sort(a):
    def sift(root, size):
        j = root
        while 2 * j + 2 < size:
            j = 2 * j + 2 if a[2 * j + 1] < a[2 * j + 2] else 2 * j + 1
        if 2 * j + 1 < size:
            j = 2 * j + 1
        x = a[root]
        while a[j] < x:
            j = (j - 1) // 2
        path, k = [], j
        while k > root:
            path.append(k)
            k = (k - 1) // 2
        prev = root
        for k in reversed(path):
            a[prev] = a[k]
            prev = k
        if path:
            a[prev] = x

    n = len(a)
    for s in range(n // 2 - 1, -1, -1):
        sift(s, n)
    for end in range(n - 1, 0, -1):
        a.swap(0, end)
        sift(0, end)


@algorithm("ternary_heap_sort", "Ternary Heap Sort", "Selection", "O(n log n)", "O(n log n)", "O(n log n)", "O(1)", False, True,
           "Heap sort on a 3-ary heap: shallower tree (log₃ n levels), more comparisons per level, better cache locality.",
           "d-ary heaps: Johnson 1975; ternary heaps minimise the comparison cost for d = 3.")
def ternary_heap_sort(a):
    def sift(root, size):
        while True:
            first = 3 * root + 1
            if first >= size:
                return
            best = first
            for c in range(first + 1, min(first + 3, size)):
                if a[best] < a[c]:
                    best = c
            if a[root] < a[best]:
                a.swap(root, best)
                root = best
            else:
                return

    n = len(a)
    for s in range((n - 2) // 3, -1, -1):
        sift(s, n)
    for end in range(n - 1, 0, -1):
        a.swap(0, end)
        sift(0, end)


@algorithm("enumeration_sort", "Enumeration (Rank) Sort", "Selection", "O(n²)", "O(n²)", "O(n²)", "O(n)", True, False,
           "Compute every element's final rank by counting how many elements precede it, then place it directly.",
           "Folklore; the textbook parallel sort (every rank can be computed independently).")
def enumeration_sort(a):
    n = len(a)
    vals = [a[i] for i in range(n)]
    out = list(vals)
    for i in range(n):
        rank = 0
        for j in range(n):
            if vals[j] < vals[i] or (j < i and not vals[i] < vals[j]):
                rank += 1
        out[rank] = vals[i]
        a.show(out, (rank,), "place")
    if n:
        a.commit(out)
