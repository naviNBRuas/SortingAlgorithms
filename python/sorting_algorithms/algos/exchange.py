"""Exchange-based sorts: bubble family, quicksort family, and pathological relatives."""
import random

from ..base import algorithm


@algorithm("bubble_sort", "Bubble Sort", "Exchange", "O(n)", "O(n²)", "O(n²)", "O(1)", True, True,
           "Repeated adjacent swaps float the maximum to the right; stops early when a pass makes no swap.",
           "Teaching staple since the 1950s (Friend 1956; named by Iverson 1962).", adaptive=True)
def bubble_sort(a):
    n = len(a)
    for i in range(n - 1):
        swapped = False
        for j in range(n - 1 - i):
            if a[j] > a[j + 1]:
                a.swap(j, j + 1)
                swapped = True
        a.done = ((n - 1 - i, n - 1),)
        if not swapped:
            break


@algorithm("cocktail_shaker_sort", "Cocktail Shaker Sort", "Exchange", "O(n)", "O(n²)", "O(n²)", "O(1)", True, True,
           "Bidirectional bubble sort: alternating forward and backward passes shrink both ends.",
           "Also called bidirectional bubble sort or shuttle sort.", adaptive=True)
def cocktail_shaker_sort(a):
    lo, hi = 0, len(a) - 1
    while lo < hi:
        swapped = False
        for i in range(lo, hi):
            if a[i] > a[i + 1]:
                a.swap(i, i + 1)
                swapped = True
        hi -= 1
        a.done = ((0, lo - 1), (hi + 1, len(a) - 1))
        for i in range(hi, lo, -1):
            if a[i - 1] > a[i]:
                a.swap(i - 1, i)
                swapped = True
        lo += 1
        a.done = ((0, lo - 1), (hi + 1, len(a) - 1))
        if not swapped:
            break


@algorithm("odd_even_sort", "Odd–Even (Brick) Sort", "Exchange", "O(n)", "O(n²)", "O(n²)", "O(1)", True, True,
           "Alternates compare-exchange phases over odd and even adjacent pairs; every phase is parallelisable.",
           "Habermann 1972; the basis of mesh-connected parallel sorting.", adaptive=True)
def odd_even_sort(a):
    n = len(a)
    done = False
    while not done:
        done = True
        for start in (1, 0):
            a.label = "odd pairs (1,2) (3,4)…" if start else "even pairs (0,1) (2,3)…"
            for i in range(start, n - 1, 2):
                if a[i] > a[i + 1]:
                    a.swap(i, i + 1)
                    done = False


@algorithm("comb_sort", "Comb Sort", "Exchange", "O(n log n)", "O(n²/2^p)", "O(n²)", "O(1)", False, True,
           "Bubble sort with a shrinking gap (factor 1.3) so small values near the end move quickly.",
           "Włodzimierz Dobosiewicz 1980; popularised by Lacey & Box, BYTE 1991.", adaptive=True)
def comb_sort(a):
    n = len(a)
    gap, swapped = n, True
    while gap > 1 or swapped:
        gap = max(1, int(gap / 1.3))
        a.label = f"gap = {gap}"
        swapped = False
        for i in range(n - gap):
            if a[i] > a[i + gap]:
                a.swap(i, i + gap)
                swapped = True


@algorithm("gnome_sort", "Gnome Sort", "Exchange", "O(n)", "O(n²)", "O(n²)", "O(1)", True, True,
           "A garden gnome steps forward when in order and swaps backward when not.",
           "Hamid Sarbazi-Azad 2000 (\"stupid sort\"); renamed by Dick Grune.", adaptive=True)
def gnome_sort(a):
    i, n = 0, len(a)
    while i < n:
        if i == 0 or not a[i - 1] > a[i]:
            i += 1
        else:
            a.swap(i - 1, i)
            i -= 1


@algorithm("exchange_sort", "Exchange Sort", "Exchange", "O(n²)", "O(n²)", "O(n²)", "O(1)", False, True,
           "Compares position i with every later position and swaps whenever they are inverted.",
           "Folklore; the simplest quadratic sort to write down.")
def exchange_sort(a):
    n = len(a)
    for i in range(n - 1):
        for j in range(i + 1, n):
            if a[j] < a[i]:
                a.swap(i, j)
        a.done = ((0, i),)


def _circle_pass(a, lo, hi):
    n = hi - lo
    if n < 2:
        return 0
    a.focus = (lo, hi - 1)
    swaps, m = 0, n // 2
    for i in range(m):
        if a[hi - 1 - i] < a[lo + i]:
            a.swap(hi - 1 - i, lo + i)
            swaps += 1
    if n & 1 and a[lo + m] < a[lo + m - 1]:
        a.swap(lo + m - 1, lo + m)
        swaps += 1
    return swaps + _circle_pass(a, lo, lo + m) + _circle_pass(a, lo + m, hi)


@algorithm("circle_sort", "Circle Sort", "Exchange", "O(n log n)", "O(n log² n)", "O(n log² n)", "O(log n)", False, True,
           "Compares first with last, second with second-last, …, recurses on halves, repeats until clean.",
           "Described by Gabriel Dabbs, 2014.")
def circle_sort(a):
    while _circle_pass(a, 0, len(a)):
        pass


@algorithm("quick_sort", "Quick Sort (Lomuto)", "Exchange", "O(n log n)", "O(n log n)", "O(n²)", "O(log n)", False, True,
           "Partition around the last element with Lomuto's single-index scheme, then recurse.",
           "Tony Hoare 1959; Lomuto partition popularised by Bentley's Programming Pearls.")
def quick_sort(a):
    def qs(lo, hi):
        if lo >= hi:
            return
        a.focus = (lo, hi)
        a.pivot = hi
        pivot = a[hi]
        i = lo
        for j in range(lo, hi):
            if a[j] <= pivot:
                a.swap(i, j)
                i += 1
        a.swap(i, hi)
        a.pivot = None
        a.done = a.done + ((i, i),)
        qs(lo, i - 1)
        qs(i + 1, hi)

    qs(0, len(a) - 1)


@algorithm("quick_sort_hoare", "Quick Sort (Hoare)", "Exchange", "O(n log n)", "O(n log n)", "O(n²)", "O(log n)", False, True,
           "Two indices converge from both ends around a middle pivot; fewer swaps than Lomuto.",
           "Hoare's original 1961 partition scheme.")
def quick_sort_hoare(a):
    def qs(lo, hi):
        while lo < hi:
            a.focus = (lo, hi)
            a.pivot = (lo + hi) // 2
            pivot = a[(lo + hi) // 2]
            i, j = lo - 1, hi + 1
            while True:
                i += 1
                while a[i] < pivot:
                    i += 1
                j -= 1
                while a[j] > pivot:
                    j -= 1
                if i >= j:
                    break
                a.swap(i, j)
            if j - lo < hi - j - 1:
                qs(lo, j)
                lo = j + 1
            else:
                qs(j + 1, hi)
                hi = j

    qs(0, len(a) - 1)


@algorithm("quick_sort_3way", "Quick Sort (3-way)", "Exchange", "O(n)", "O(n log n)", "O(n²)", "O(log n)", False, True,
           "Dutch-national-flag partition into <, =, > pivot; linear time on inputs with few distinct keys.",
           "Dijkstra's Dutch national flag problem (1976); Bentley–McIlroy 1993.", adaptive=True)
def quick_sort_3way(a):
    def qs(lo, hi):
        while lo < hi:
            a.focus = (lo, hi)
            a.pivot = (lo + hi) // 2
            pivot = a[(lo + hi) // 2]
            lt, i, gt = lo, lo, hi
            while i <= gt:
                if a[i] < pivot:
                    a.swap(lt, i)
                    lt += 1
                    i += 1
                elif a[i] > pivot:
                    a.swap(i, gt)
                    gt -= 1
                else:
                    i += 1
            a.pivot = None
            a.done = a.done + ((lt, gt),)
            if lt - lo < hi - gt:
                qs(lo, lt - 1)
                lo = gt + 1
            else:
                qs(gt + 1, hi)
                hi = lt - 1

    qs(0, len(a) - 1)


@algorithm("quick_sort_dual_pivot", "Quick Sort (Dual-Pivot)", "Exchange", "O(n log n)", "O(n log n)", "O(n²)", "O(log n)", False, True,
           "Two pivots split the range into three parts; the scheme used by Java's Arrays.sort. This version takes the end elements as pivots, so sorted input is quadratic.",
           "Vladimir Yaroslavskiy, 2009.")
def quick_sort_dual_pivot(a):
    def qs(lo, hi):
        if lo >= hi:
            return
        a.focus = (lo, hi)
        if a[lo] > a[hi]:
            a.swap(lo, hi)
        a.pivot = lo
        p, q = a[lo], a[hi]
        lt, gt, k = lo + 1, hi - 1, lo + 1
        while k <= gt:
            if a[k] < p:
                a.swap(k, lt)
                lt += 1
            elif a[k] > q:
                while k < gt and a[gt] > q:
                    gt -= 1
                a.swap(k, gt)
                gt -= 1
                if a[k] < p:
                    a.swap(k, lt)
                    lt += 1
            k += 1
        lt -= 1
        gt += 1
        a.swap(lo, lt)
        a.swap(hi, gt)
        a.pivot = None
        a.done = a.done + ((lt, lt), (gt, gt))
        qs(lo, lt - 1)
        qs(lt + 1, gt - 1)
        qs(gt + 1, hi)

    qs(0, len(a) - 1)


@algorithm("stooge_sort", "Stooge Sort", "Exchange", "O(n^2.71)", "O(n^2.71)", "O(n^2.71)", "O(log n)", False, True,
           "Sort the first 2/3, the last 2/3, then the first 2/3 again. Correct, and deliberately slow.",
           "Howard, Fine and Howard — a Three Stooges joke, textbook cautionary example (CLRS problem 7-3).",
           viz_n=18, bench_max_n=128)
def stooge_sort(a):
    def st(i, j):
        a.focus = (i, j)
        if a[i] > a[j]:
            a.swap(i, j)
        if j - i + 1 > 2:
            t = (j - i + 1) // 3
            st(i, j - t)
            st(i + t, j)
            st(i, j - t)

    if len(a) > 1:
        st(0, len(a) - 1)


@algorithm("slow_sort", "Slow Sort", "Exchange", "Ω(n^(log n / 2+ε))", "super-polynomial", "super-polynomial", "O(n)", False, True,
           "'Multiply and surrender': find the max of each half recursively, then sort the rest the same way.",
           "Broder & Stolfi, 'Pessimal Algorithms and Simplexity Analysis', 1986.",
           viz_n=14, bench_max_n=24)
def slow_sort(a):
    def slow(i, j):
        if i >= j:
            return
        a.focus = (i, j)
        m = (i + j) // 2
        slow(i, m)
        slow(m + 1, j)
        if a[m] > a[j]:
            a.swap(m, j)
        slow(i, j - 1)

    slow(0, len(a) - 1)


@algorithm("pancake_sort", "Pancake Sort", "Exchange", "O(n)", "O(n²)", "O(n²)", "O(1)", False, True,
           "Only prefix reversals ('spatula flips') are allowed: bring the max to the front, flip it into place.",
           "Gates & Papadimitriou 1979 (their only joint paper; Gates co-founded Microsoft).", adaptive=True)
def pancake_sort(a):
    def flip(k):
        a.label = f"flip the top {k + 1} pancakes"
        i = 0
        while i < k:
            a.swap(i, k)
            i += 1
            k -= 1

    for size in range(len(a), 1, -1):
        mx = 0
        for i in range(1, size):
            if a[i] > a[mx]:
                mx = i
        if mx == size - 1:
            continue
        if mx:
            flip(mx)
        flip(size - 1)
        a.done = ((size - 1, len(a) - 1),)


def _sorted_check(a):
    for i in range(len(a) - 1):
        if a[i] > a[i + 1]:
            return False
    return True


@algorithm("bogo_sort", "Bogo Sort", "Probabilistic", "O(n)", "O(n·n!)", "unbounded", "O(1)", False, True,
           "Shuffle until sorted. Guarded by max_shuffles so it always terminates.",
           "Jargon-file folklore ('permutation sort', 'stupid sort').",
           viz_n=6, viz_kwargs={"max_shuffles": 100_000, "seed": 3}, bench_max_n=7, adaptive=True)
def bogo_sort(a, max_shuffles: int = 10_000, seed: int = 0):
    rng = random.Random(seed)
    n = len(a)
    for attempt in range(max_shuffles + 1):
        a.label = f"attempt {attempt + 1}: shuffled?"
        if _sorted_check(a):
            return
        for i in range(n - 1, 0, -1):
            a.swap(i, rng.randint(0, i))
    raise RuntimeError("bogo_sort exceeded maximum shuffles; aborting")


@algorithm("bozo_sort", "Bozo Sort", "Probabilistic", "O(n)", "O(n·n!)", "unbounded", "O(1)", False, True,
           "Swap two random elements, check, repeat. Even less strategic than bogo sort.",
           "Jargon-file folklore.", viz_n=6, viz_kwargs={"max_swaps": 100_000, "seed": 5}, bench_max_n=6, adaptive=True)
def bozo_sort(a, max_swaps: int = 100_000, seed: int = 0):
    rng = random.Random(seed)
    n = len(a)
    for attempt in range(max_swaps + 1):
        a.label = f"attempt {attempt + 1}: random swap"
        if _sorted_check(a):
            return
        a.swap(rng.randrange(n), rng.randrange(n))
    raise RuntimeError("bozo_sort exceeded maximum swaps; aborting")


@algorithm("permutation_sort", "Permutation Sort", "Exchange", "O(n)", "O(n·n!)", "O(n·n!)", "O(n)", True, False,
           "Enumerate permutations in lexicographic order until one is sorted. Deterministic cousin of bogo sort.",
           "Folklore ('exhaustive search sort').", viz_n=6, bench_max_n=8, adaptive=True)
def permutation_sort(a):
    n = len(a)
    vals = [a[i] for i in range(n)]
    idx = list(range(n))
    attempt = 0
    while True:
        attempt += 1
        a.label = f"permutation #{attempt}"
        view = [vals[i] for i in idx]
        a.show(view, (), "try")
        if all(not view[i + 1] < view[i] for i in range(n - 1)):
            a.commit(view)
            return
        i = n - 2
        while i >= 0 and idx[i] > idx[i + 1]:
            i -= 1
        j = n - 1
        while idx[j] < idx[i]:
            j -= 1
        idx[i], idx[j] = idx[j], idx[i]
        idx[i + 1:] = reversed(idx[i + 1:])
