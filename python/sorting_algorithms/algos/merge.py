"""Merge-based sorts."""
from ..base import algorithm


@algorithm("merge_sort", "Merge Sort", "Merge", "O(n log n)", "O(n log n)", "O(n log n)", "O(n)", True, False,
           "Split in half, sort each half recursively, merge the two sorted halves.",
           "John von Neumann, 1945 (EDVAC) — one of the first programs ever written for a stored-program computer.")
def merge_sort(a):
    def merge(lo, mid, hi):
        a.focus = (lo, hi - 1)
        a.label = f"merge [{lo}, {mid}) and [{mid}, {hi})"
        left = [a[k] for k in range(lo, mid)]
        i, j, k = 0, mid, lo
        while i < len(left) and j < hi:
            if a[j] < left[i]:
                a[k] = a[j]
                j += 1
            else:
                a[k] = left[i]
                i += 1
            k += 1
        while i < len(left):
            a[k] = left[i]
            i += 1
            k += 1

    def sort(lo, hi):
        if hi - lo < 2:
            return
        mid = (lo + hi) // 2
        sort(lo, mid)
        sort(mid, hi)
        merge(lo, mid, hi)

    sort(0, len(a))


@algorithm("merge_sort_bottom_up", "Merge Sort (Bottom-Up)", "Merge", "O(n log n)", "O(n log n)", "O(n log n)", "O(n)", True, False,
           "Iterative merge sort: merge runs of width 1, 2, 4, … with no recursion.",
           "Standard in external sorting and in Knuth's Algorithm S.")
def merge_sort_bottom_up(a):
    n = len(a)
    width = 1
    while width < n:
        for lo in range(0, n, 2 * width):
            mid, hi = min(lo + width, n), min(lo + 2 * width, n)
            if mid >= hi:
                continue
            a.focus = (lo, hi - 1)
            a.label = f"merge runs of width {width}"
            left = [a[k] for k in range(lo, mid)]
            i, j, k = 0, mid, lo
            while i < len(left) and j < hi:
                if a[j] < left[i]:
                    a[k] = a[j]
                    j += 1
                else:
                    a[k] = left[i]
                    i += 1
                k += 1
            while i < len(left):
                a[k] = left[i]
                i += 1
                k += 1
        width *= 2


@algorithm("in_place_merge_sort", "In-Place Merge Sort", "Merge", "O(n log n)", "O(n log² n)", "O(n log² n)", "O(log n)", True, True,
           "Merges without a buffer by binary-searching a split point and rotating blocks (SymMerge-style).",
           "Kim & Kutzner 2004 'Stable minimum storage merging by symmetric comparisons'; Go's sort.Stable.")
def in_place_merge_sort(a):
    def reverse(i, j):
        j -= 1
        while i < j:
            a.swap(i, j)
            i += 1
            j -= 1

    def rotate(i, m, j):
        reverse(i, m)
        reverse(m, j)
        reverse(i, j)

    def merge(lo, mid, hi):
        if lo >= mid or mid >= hi:
            return
        a.focus = (lo, hi - 1)
        a.label = "rotate blocks around a binary-searched split point"
        if hi - lo == 2:
            if a[mid] < a[lo]:
                a.swap(lo, mid)
            return
        if mid - lo >= hi - mid:
            i = (lo + mid) // 2
            pivot = a[i]
            l, h = mid, hi
            while l < h:
                m = (l + h) // 2
                if a[m] < pivot:
                    l = m + 1
                else:
                    h = m
            j = l
            rotate(i, mid, j)
            nm = i + (j - mid)
            merge(lo, i, nm)
            merge(nm + 1, j, hi)
        else:
            j = (mid + hi) // 2
            pivot = a[j]
            l, h = lo, mid
            while l < h:
                m = (l + h) // 2
                if pivot < a[m]:
                    h = m
                else:
                    l = m + 1
            i = l
            rotate(i, mid, j + 1)
            nm = i + (j + 1 - mid)
            merge(lo, i, nm - 1)
            merge(nm, j + 1, hi)

    def sort(lo, hi):
        if hi - lo < 2:
            return
        mid = (lo + hi) // 2
        sort(lo, mid)
        sort(mid, hi)
        merge(lo, mid, hi)

    sort(0, len(a))


@algorithm("strand_sort", "Strand Sort", "Merge", "O(n)", "O(n²)", "O(n²)", "O(n)", True, False,
           "Repeatedly pull an increasing 'strand' out of the input and merge it into the output list.",
           "Described in Wikipedia/Knuth exercises; natural-merge flavour.", adaptive=True)
def strand_sort(a):
    n = len(a)
    rest = [a[i] for i in range(n)]
    out = []
    while rest:
        strand, keep = [rest[0]], []
        for idx, x in enumerate(rest[1:], 1):
            if x >= strand[-1]:
                strand.append(x)
            else:
                keep.append(x)
            a.done = ((0, len(out) - 1),) if out else ()
            a.label = "pulling an ascending strand out of the input"
            a.show(out + strand + keep + rest[idx + 1:], (len(out) + len(strand) - 1,), "pull")
        merged, i, j = [], 0, 0
        while i < len(out) and j < len(strand):
            if strand[j] < out[i]:
                merged.append(strand[j])
                j += 1
            else:
                merged.append(out[i])
                i += 1
        merged += out[i:] + strand[j:]
        out, rest = merged, keep
        a.done = ((0, len(out) - 1),) if out else ()
        a.label = f"pulled a strand of {len(strand)}, merged into the output"
        a.show(out + rest, (len(out) - 1,) if out else (), "merge strand")
    a.commit(out)


def _min_run(n):
    r = 0
    while n >= 64:
        r |= n & 1
        n >>= 1
    return n + r


@algorithm("tim_sort", "Tim Sort", "Hybrid", "O(n)", "O(n log n)", "O(n log n)", "O(n)", True, False,
           "Detects natural runs, extends short ones with binary insertion, and merges them under stack invariants. "
           "(This version omits galloping mode.)",
           "Tim Peters 2002 for CPython; default sort in Python, Java (objects), Android, Rust (stable).", adaptive=True)
def tim_sort(a):
    n = len(a)
    if n < 2:
        return
    minrun = _min_run(n)

    def reverse(i, j):
        j -= 1
        while i < j:
            a.swap(i, j)
            i += 1
            j -= 1

    def binary_insert(lo, start, hi):
        a.focus = (lo, hi - 1)
        a.label = "extend a short run with binary insertion"
        for i in range(start, hi):
            key = a[i]
            l, h = lo, i
            while l < h:
                m = (l + h) // 2
                if key < a[m]:
                    h = m
                else:
                    l = m + 1
            if l != i:
                for j in range(i, l, -1):
                    a[j] = a[j - 1]
                a[l] = key

    runs = []  # (start, length)

    def merge_at(i):
        (s1, l1), (s2, l2) = runs[i], runs[i + 1]
        a.focus = (s1, s2 + l2 - 1)
        a.label = f"merge two adjacent runs ({l1} + {l2})"
        left = [a[k] for k in range(s1, s1 + l1)]
        x, j, k, end = 0, s2, s1, s2 + l2
        while x < len(left) and j < end:
            if a[j] < left[x]:
                a[k] = a[j]
                j += 1
            else:
                a[k] = left[x]
                x += 1
            k += 1
        while x < len(left):
            a[k] = left[x]
            x += 1
            k += 1
        runs[i] = (s1, l1 + l2)
        del runs[i + 1]

    def collapse():
        while len(runs) > 1:
            m = len(runs) - 2
            L = [r[1] for r in runs]
            if (m > 0 and L[m - 1] <= L[m] + L[m + 1]) or (m > 1 and L[m - 2] <= L[m - 1] + L[m]):
                if L[m - 1] < L[m + 1]:
                    m -= 1
                merge_at(m)
            elif L[m] <= L[m + 1]:
                merge_at(m)
            else:
                break

    lo = 0
    while lo < n:
        r = lo + 1
        a.label = "detect the next natural run"
        a.focus = None
        if r < n:
            if a[r] < a[r - 1]:
                while r < n and a[r] < a[r - 1]:
                    r += 1
                reverse(lo, r)
            else:
                while r < n and not a[r] < a[r - 1]:
                    r += 1
        force = min(minrun, n - lo)
        if r - lo < force:
            binary_insert(lo, r, lo + force)
            r = lo + force
        runs.append((lo, r - lo))
        collapse()
        lo = r
    while len(runs) > 1:
        m = len(runs) - 2
        if m > 0 and runs[m - 1][1] < runs[m + 1][1]:
            m -= 1
        merge_at(m)


@algorithm("intro_sort", "Intro Sort", "Hybrid", "O(n log n)", "O(n log n)", "O(n log n)", "O(log n)", False, True,
           "Median-of-three quicksort that switches to heap sort past a depth limit and to insertion sort on tiny ranges.",
           "David Musser, 1997; basis of C++ std::sort in libstdc++ and libc++.")
def intro_sort(a):
    from .selection import _sift_down

    def insertion(lo, hi):
        a.focus = (lo, hi)
        a.pivot = None
        a.label = "small range: insertion sort"
        for i in range(lo + 1, hi + 1):
            key = a[i]
            j = i - 1
            while j >= lo and a[j] > key:
                a[j + 1] = a[j]
                j -= 1
            if j + 1 != i:
                a[j + 1] = key

    def heap(lo, hi):
        n = hi - lo + 1
        for s in range((n - 2) // 2, -1, -1):
            _sift_down(a, s, n - 1, lo)
        for end in range(n - 1, 0, -1):
            a.swap(lo, lo + end)
            _sift_down(a, 0, end - 1, lo)

    def sort(lo, hi, depth):
        while hi - lo + 1 > 12:
            a.focus = (lo, hi)
            if depth == 0:
                a.label = "depth limit reached: switch to heap sort"
                heap(lo, hi)
                return
            a.label = "quicksort partition (median of three)"
            depth -= 1
            mid = (lo + hi) // 2
            if a[mid] < a[lo]:
                a.swap(mid, lo)
            if a[hi] < a[lo]:
                a.swap(hi, lo)
            if a[hi] < a[mid]:
                a.swap(hi, mid)
            a.pivot = mid
            pivot = a[mid]
            i, j = lo, hi
            while i <= j:
                while a[i] < pivot:
                    i += 1
                while a[j] > pivot:
                    j -= 1
                if i <= j:
                    a.swap(i, j)
                    i += 1
                    j -= 1
            sort(lo, j, depth)
            lo = i
        insertion(lo, hi)

    n = len(a)
    if n > 1:
        sort(0, n - 1, 2 * (n.bit_length() - 1))
