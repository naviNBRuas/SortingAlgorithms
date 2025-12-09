from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def counting_sort(data: Sequence[int], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("counting_sort", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)
    min_val = min(arr)
    max_val = max(arr)
    k = max_val - min_val + 1
    counts = [0] * k
    for value in arr:
        counts[value - min_val] += 1
        if tracer:
            tracer.record(arr, (), f"count {value}")
    idx = 0
    for i, c in enumerate(counts):
        while c > 0:
            arr[idx] = i + min_val
            c -= 1
            idx += 1
            if tracer:
                tracer.record(arr, (idx - 1,), "write")
    return _finalize(arr, tracer, ret_trace)
