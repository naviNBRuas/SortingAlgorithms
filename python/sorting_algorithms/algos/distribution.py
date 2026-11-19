"""Non-comparison sorts that look at key values (digits, ranges, counts).

Each publishes its auxiliary structure (counters, buckets, ...) through `a.set_aux` so the animation can show it.
"""
from ..base import algorithm


def _place(a, prev, placements, note="place"):
    """Apply (position, value) placements to a copy of ``prev`` with a frame each."""
    cur = list(prev)
    for pos, v in placements:
        cur[pos] = v
        a.show(cur, (pos,), note)
    return cur


@algorithm("counting_sort", "Counting Sort", "Distribution", "O(n + k)", "O(n + k)", "O(n + k)", "O(n + k)", True, False,
           "Count occurrences of each key, prefix-sum the counts into positions, place elements stably.",
           "Harold Seward, MIT 1954.", keys="int")
def counting_sort(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    lo, hi = min(vals), max(vals)
    count = [0] * (hi - lo + 2)
    a.label = "1. count how many times each key occurs"
    for t, v in enumerate(vals):
        count[v - lo + 1] += 1
        a.set_aux(count[1:], "count[key]", hl=(v - lo,))
        a.show(vals, (t,), "count")
    a.label = "2. prefix sums turn counts into start positions"
    for i in range(1, len(count)):
        count[i] += count[i - 1]
    a.set_aux(count[:-1], "start position of each key")
    a.show(vals, (), "prefix")
    a.label = "3. place every element at its key's next free slot"
    cur = list(vals)
    for t, v in enumerate(vals):
        pos = count[v - lo]
        cur[pos] = v
        count[v - lo] += 1
        a.set_aux(count[:-1], "next free slot of each key", hl=(v - lo,))
        a.show(cur, (pos,), "place")
    a.done = ((0, n - 1),)
    a.commit(cur)


@algorithm("pigeonhole_sort", "Pigeonhole Sort", "Distribution", "O(n + k)", "O(n + k)", "O(n + k)", "O(n + k)", True, False,
           "Drop each element into the hole for its key, then read the holes back in order.",
           "Folklore variant of counting sort for keys with few gaps.", keys="int")
def pigeonhole_sort(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    lo, hi = min(vals), max(vals)
    holes = [[] for _ in range(hi - lo + 1)]
    a.label = "drop every element into the hole for its key"
    for t, v in enumerate(vals):
        holes[v - lo].append(v)
        a.set_aux([len(h) for h in holes], "pigeons per hole", hl=(v - lo,))
        a.show(vals, (t,), "drop")
    a.label = "read the holes back, smallest key first"
    cur, pos = list(vals), 0
    for h_idx, h in enumerate(holes):
        for v in h:
            cur[pos] = v
            a.set_aux([len(x) if k >= h_idx else 0 for k, x in enumerate(holes)], "pigeons per hole", hl=(h_idx,))
            a.show(cur, (pos,), "gather")
            pos += 1
    a.done = ((0, n - 1),)
    a.commit(cur)


def _digit(v, exp):
    return (v // exp) % 10


@algorithm("radix_sort_lsd", "Radix Sort (LSD)", "Distribution", "O(d(n + b))", "O(d(n + b))", "O(d(n + b))", "O(n + b)", True, False,
           "Stable counting-sort passes on each decimal digit, least significant first; negatives handled by offset.",
           "Herman Hollerith's tabulating machine, 1887; Seward's computer version 1954.", keys="int")
def radix_sort_lsd(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    off = min(vals)
    cur = [v - off for v in vals]
    exp, p = 1, 0
    while max(cur) // exp > 0:
        a.label = f"pass {p + 1}: stable sort by the 10^{p} digit"
        count = [0] * 11
        for t, v in enumerate(cur):
            count[_digit(v, exp) + 1] += 1
            a.set_aux(count[1:], f"digit-{p} histogram", hl=(_digit(v, exp),))
            a.show([x + off for x in cur], (t,), "count")
        for i in range(1, 11):
            count[i] += count[i - 1]
        nxt = list(cur)
        for t, v in enumerate(cur):
            d = _digit(v, exp)
            nxt[count[d]] = v
            a.set_aux(count[:10], "next free slot per digit", hl=(d,))
            count[d] += 1
            a.show([x + off for x in nxt], (count[d] - 1,), "place")
        cur = nxt
        exp *= 10
        p += 1
    a.set_aux(None)
    a.done = ((0, n - 1),)
    a.commit([x + off for x in cur])


@algorithm("radix_sort_msd", "Radix Sort (MSD)", "Distribution", "O(n)", "O(d·n)", "O(d·n)", "O(n + b)", True, False,
           "Bucket by the most significant decimal digit, then recurse into each bucket on the next digit.",
           "Classic top-down radix sort; basis of burst/trie sorts for strings.", keys="int")
def radix_sort_msd(a):
    n = len(a)
    if n == 0:
        return
    off = min(a[i] for i in range(n))
    cur = [a[i] - off for i in range(n)]
    top = 1
    while max(cur) // top >= 10:
        top *= 10

    def rec(lo, hi, exp):
        if hi - lo < 2 or exp == 0:
            return
        a.focus = (lo, hi - 1)
        a.label = f"bucket [{lo}, {hi}) by the 10^{len(str(exp)) - 1} digit"
        buckets = [[] for _ in range(10)]
        for v in cur[lo:hi]:
            buckets[_digit(v, exp)].append(v)
        a.set_aux([len(b) for b in buckets], "bucket sizes")
        pos = lo
        starts = []
        for b in buckets:
            starts.append((pos, pos + len(b)))
            for v in b:
                cur[pos] = v
                a.show([x + off for x in cur], (pos,), "bucket")
                pos += 1
        for (s, e) in starts:
            rec(s, e, exp // 10)

    rec(0, n, top)
    a.focus = None
    a.set_aux(None)
    a.done = ((0, n - 1),)
    a.commit([x + off for x in cur])


@algorithm("american_flag_sort", "American Flag Sort", "Distribution", "O(n)", "O(d·n)", "O(d·n)", "O(b·log n)", False, True,
           "In-place MSD radix sort: count digits, then permute elements into their buckets by cycle-leader swaps.",
           "McIlroy, Bostic & McIlroy 1993, 'Engineering Radix Sort'.", keys="int")
def american_flag_sort(a):
    n = len(a)
    if n == 0:
        return
    off = min(a[i] for i in range(n))
    for i in range(n):
        a.items[i] -= off
    top = 1
    while max(a.items) // top >= 10:
        top *= 10

    def rec(lo, hi, exp):
        if hi - lo < 2 or exp == 0:
            return
        a.focus = (lo, hi - 1)
        a.label = f"permute [{lo}, {hi}) into digit buckets (in place)"
        count = [0] * 10
        for i in range(lo, hi):
            count[_digit(a.items[i], exp)] += 1
        a.set_aux(count, "bucket sizes")
        starts, s = [], lo
        for c in count:
            starts.append(s)
            s += c
        ends = [starts[d] + count[d] for d in range(10)]
        nxt = list(starts)
        for b in range(10):
            while nxt[b] < ends[b]:
                d = _digit(a[nxt[b]], exp)
                if d == b:
                    nxt[b] += 1
                else:
                    a.swap(nxt[b], nxt[d])
                    nxt[d] += 1
        for b in range(10):
            rec(starts[b], ends[b], exp // 10)

    rec(0, n, top)
    for i in range(n):
        a.items[i] += off
    a.focus = None
    a.set_aux(None)
    a.done = ((0, n - 1),)
    a.mark((), "restore offset")


@algorithm("bucket_sort", "Bucket Sort", "Distribution", "O(n + k)", "O(n + k)", "O(n²)", "O(n + k)", True, False,
           "Scatter keys into n equal-width buckets over [min, max], insertion-sort each bucket, concatenate.",
           "Isaac & Singleton 1956; Knuth TAOCP vol. 3 §5.2.1.", keys="number")
def bucket_sort(a):
    n = len(a)
    if n < 2:
        return
    vals = [a[i] for i in range(n)]
    lo, hi = min(vals), max(vals)
    if lo == hi:
        return
    buckets = [[] for _ in range(n)]
    scale = (n - 1) / (hi - lo)
    a.label = "scatter each key into the bucket for its range"
    for t, v in enumerate(vals):
        b = int((v - lo) * scale)
        buckets[b].append(v)
        a.set_aux([len(x) for x in buckets], "bucket sizes", hl=(b,))
        a.show(vals, (t,), "scatter")
    out = []
    a.label = "insertion-sort each bucket, then concatenate"
    for bi, b in enumerate(buckets):
        for i in range(1, len(b)):
            key, j = b[i], i - 1
            while j >= 0 and b[j] > key:
                b[j + 1] = b[j]
                j -= 1
            b[j + 1] = key
        out.extend(b)
        a.done = ((0, len(out) - 1),) if out else ()
        a.set_aux([len(x) if k > bi else 0 for k, x in enumerate(buckets)], "buckets left", hl=(bi,))
        a.show(out + vals[len(out):], (len(out) - 1,) if out else (), "gather")
    a.commit(out)


@algorithm("bead_sort", "Bead (Gravity) Sort", "Distribution", "O(n)–O(S)", "O(S)", "O(S)", "O(n·max)", True, False,
           "Beads on rods fall under gravity; each row of beads is a number. S = sum of the inputs.",
           "Joshua Arulanandham, Cristian Calude & Michael Dinneen, 2002.", keys="int", viz_n=48)
def bead_sort(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    off = min(vals)
    h = [v - off for v in vals]
    mx = max(h)
    a.label = "each number is a row of beads on the rods"
    a.show(vals, (), "load beads")
    view = [off] * n
    ge = [0] * (mx + 2)
    for v in h:
        ge[v] += 1
    for r in range(mx - 1, -1, -1):
        ge[r] += ge[r + 1]
    a.label = "gravity: beads fall onto beads or the floor"
    for level in range(1, mx + 1):
        c = ge[level]
        for k in range(c):
            view[n - 1 - k] = off + level
        a.set_aux(ge[1:mx + 1], "beads at each level", hl=(level - 1,))
        a.show(view, (n - c,), "beads fall")
    a.done = ((0, n - 1),)
    a.commit(view)


@algorithm("flash_sort", "Flash Sort", "Distribution", "O(n)", "O(n)", "O(n²)", "O(m)", False, True,
           "Classify keys into ~0.43n classes by linear interpolation, permute in place, finish with insertion sort.",
           "Karl-Dietrich Neubert, 1998 (Dr. Dobb's).", keys="number")
def flash_sort(a):
    n = len(a)
    if n < 2:
        return
    mn = mx = a[0]
    for i in range(1, n):
        v = a[i]
        if v < mn:
            mn = v
        if v > mx:
            mx = v
    if mn == mx:
        return
    m = max(2, int(0.43 * n))
    c1 = (m - 1) / (mx - mn)

    def cls(v):
        return int(c1 * (v - mn))

    count = [0] * m
    a.label = "classify keys into classes by linear interpolation"
    for i in range(n):
        count[cls(a[i])] += 1
    a.set_aux(count, "class sizes")
    a.mark((), "classified")
    starts, s = [], 0
    for c in count:
        starts.append(s)
        s += c
    ends = [starts[k] + count[k] for k in range(m)]
    nxt = list(starts)
    a.label = "permute every element into its class (cycle leader)"
    for b in range(m):
        while nxt[b] < ends[b]:
            d = cls(a[nxt[b]])
            if d == b:
                nxt[b] += 1
            else:
                a.swap(nxt[b], nxt[d])
                nxt[d] += 1
    a.set_aux(None)
    a.label = "classes are in order: finish with insertion sort"
    for i in range(1, n):
        key, j = a[i], i - 1
        if a[j] > key:
            while j >= 0 and a[j] > key:
                a[j + 1] = a[j]
                j -= 1
            a[j + 1] = key


@algorithm("sleep_sort", "Sleep Sort (simulated)", "Distribution", "O(n + max)", "O(n + max)", "O(n + max)", "O(n)", True, False,
           "Each element 'sleeps' for its value and is emitted on waking; here the clock is simulated tick by tick.",
           "Anonymous 4chan post, 2011 — a joke that is secretly a counting sort over time.", keys="int", viz_n=40)
def sleep_sort(a):
    n = len(a)
    if n == 0:
        return
    vals = [a[i] for i in range(n)]
    off = min(vals)
    wake = {}
    for i, v in enumerate(vals):
        wake.setdefault(v - off, []).append(v)
    span = max(v - off for v in vals) + 1
    out = []
    a.label = "every element is asleep"
    for t in range(span):
        if t in wake:
            out.extend(wake[t])
            a.done = ((0, len(out) - 1),)
            a.label = f"clock tick {t}: {len(wake[t])} element(s) wake up"
            a.set_aux([len(wake.get(k, [])) if k > t else 0 for k in range(span)], "sleepers per wake-up tick", hl=(t,))
            a.show(out + [v for v in vals if v - off > t], (len(out) - 1,), f"t={t}")
    a.commit(out)
