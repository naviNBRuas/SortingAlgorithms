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
            for j in range(k % p, n - k, 2 * k):
                for i in range(min(k, n - j - k)):
                    if (i + j) // (2 * p) == (i + j + k) // (2 * p):
                        _cmp_swap(a, i + j, i + j + k)
            k //= 2
        p *= 2
