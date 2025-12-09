from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def radix_sort_lsd(data: Sequence[int], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("radix_sort_lsd", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)

    positives = [x for x in arr if x >= 0]
    negatives = [-x for x in arr if x < 0]

    def _radix(nonneg: List[int]):
        if not nonneg:
            return []
        max_val = max(nonneg)
        exp = 1
        out = list(nonneg)
        while max_val // exp > 0:
            buckets = [[] for _ in range(10)]
            for num in out:
                digit = (num // exp) % 10
                buckets[digit].append(num)
            out = [num for bucket in buckets for num in bucket]
            if tracer:
                tracer.record(positives + [-n for n in negatives], (), f"exp={exp}")
            exp *= 10
        return out

    sorted_pos = _radix(positives)
    sorted_neg = list(reversed(_radix(negatives)))
    sorted_neg = [-x for x in sorted_neg]
    merged = sorted_neg + sorted_pos
    return _finalize(merged, tracer, ret_trace)
