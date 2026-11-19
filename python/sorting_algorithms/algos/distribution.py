"""Non-comparison sorts that look at key values (digits, ranges, counts)."""
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
    for v in vals:
        count[v - lo + 1] += 1
    for i in range(1, len(count)):
        count[i] += count[i - 1]
    out = [0] * n
    placements = []
    for v in vals:
        out[count[v - lo]] = v
        placements.append((count[v - lo], v))
        count[v - lo] += 1
    cur = _place(a, vals, placements)
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
    for v in vals:
        holes[v - lo].append(v)
    pos, placements = 0, []
    for h in holes:
        for v in h:
            placements.append((pos, v))
            pos += 1
    a.commit(_place(a, vals, placements, "gather"))


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
    exp = 1
    while max(cur) // exp > 0:
        count = [0] * 11
        for v in cur:
            count[_digit(v, exp) + 1] += 1
        for i in range(1, 11):
            count[i] += count[i - 1]
        placements = []
        for v in cur:
            d = _digit(v, exp)
            placements.append((count[d], v))
            count[d] += 1
        cur = _place(a, [x + off for x in cur], [(p, v + off) for p, v in placements], f"pass 10^{len(str(exp)) - 1}")
        cur = [x - off for x in cur]
        exp *= 10
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
        buckets = [[] for _ in range(10)]
        for v in cur[lo:hi]:
            buckets[_digit(v, exp)].append(v)
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
        count = [0] * 10
        for i in range(lo, hi):
            count[_digit(a.items[i], exp)] += 1
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
    for v in vals:
        buckets[int((v - lo) * scale)].append(v)
    out = []
    for b in buckets:
        for i in range(1, len(b)):
            key, j = b[i], i - 1
            while j >= 0 and b[j] > key:
                b[j + 1] = b[j]
                j -= 1
            b[j + 1] = key
        out.extend(b)
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
    a.show(vals, (), "load beads")
    view = [off] * n
    ge = [0] * (mx + 2)
    for v in h:
        ge[v] += 1
    for r in range(mx - 1, -1, -1):
        ge[r] += ge[r + 1]
    for level in range(1, mx + 1):
        c = ge[level]
        for k in range(c):
            view[n - 1 - k] = off + level
        a.show(view, tuple(range(n - c, n)), "beads fall")
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
    for i in range(n):
        count[cls(a[i])] += 1
    starts, s = [], 0
    for c in count:
        starts.append(s)
        s += c
    ends = [starts[k] + count[k] for k in range(m)]
    nxt = list(starts)
    for b in range(m):
        while nxt[b] < ends[b]:
            d = cls(a[nxt[b]])
            if d == b:
                nxt[b] += 1
            else:
                a.swap(nxt[b], nxt[d])
                nxt[d] += 1
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
    out = []
    for t in range(max(v - off for v in vals) + 1):
        if t in wake:
            out.extend(wake[t])
            a.show(out + [v for v in vals if v - off > t], (len(out) - 1,), f"t={t}")
    a.commit(out)
