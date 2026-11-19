"""Sorting networks: data-independent comparator schedules (parallel / hardware friendly)."""
from ..base import algorithm


def _cmp_swap(a, i, j):
    if a[i] > a[j]:
        a.swap(i, j)


@algorithm("bitonic_sort", "Bitonic Sort", "Network", "O(n log² n)", "O(n log² n)", "O(n log² n)", "O(1)", False, True,
           "Batcher's bitonic network: build ever-longer bitonic sequences, then merge them with half-cleaners.",
           "Ken Batcher, 1968; the workhorse of GPU sorting. Arbitrary n handled by skipping out-of-range comparators.")
def bitonic_sort(a):
    n = len(a)
    size = 1
    while size < n:
        size *= 2
    k = 2
    while k <= size:
        a.label = f"stage: build bitonic sequences of length {k}"
        for blk in range(0, size, k):
            for t in range(k // 2):
                i, j = blk + t, blk + k - 1 - t
                if j < n:
                    _cmp_swap(a, i, j)
        j = k // 4
        while j >= 1:
            for i in range(size):
                if not i & j and i + j < n:
                    _cmp_swap(a, i, i + j)
            j //= 2
        k *= 2


@algorithm("odd_even_merge_sort", "Batcher Odd–Even Merge Sort", "Network", "O(n log² n)", "O(n log² n)", "O(n log² n)", "O(1)", False, True,
           "Batcher's other network: recursively merge sorted halves with an odd–even merge.",
           "Ken Batcher, 1968; Knuth TAOCP vol. 3 §5.3.4.")
def odd_even_merge_sort(a):
    n = len(a)
    p = 1
    while p < n:
        k = p
        while k >= 1:
            a.label = f"merge sorted blocks of {p}: compare distance {k}"
            for j in range(k % p, n - k, 2 * k):
                for i in range(min(k, n - j - k)):
                    if (i + j) // (2 * p) == (i + j + k) // (2 * p):
                        _cmp_swap(a, i + j, i + j + k)
            k //= 2
        p *= 2


@algorithm("pairwise_sorting_network", "Pairwise Sorting Network", "Network", "O(n log² n)", "O(n log² n)", "O(n log² n)", "O(1)", False, True,
           "Compare pairs, then pairs of pairs, in a pattern with the same size as Batcher's networks but a simpler structure.",
           "Ian Parberry, 1992 ('The pairwise sorting network').")
def pairwise_sorting_network(a):
    n = len(a)
    size = 1
    while size < n:
        size *= 2
    step = 1
    while step < size:
        a.label = f"compare elements {step} apart"
        b, c = step, 0
        while b < size:
            if b < n:
                _cmp_swap(a, b - step, b)
            b += 1
            c += 1
            if c >= step:
                c = 0
                b += step
        step *= 2
    step //= 4
    e = 1
    while step > 0:
        d = e
        while d > 0:
            b, c = (d + 1) * step, 0
            while b < size:
                if b < n:
                    _cmp_swap(a, b - d * step, b)
                b += 1
                c += 1
                if c >= step:
                    c = 0
                    b += step
            d //= 2
        step //= 2
        e = e * 2 + 1
