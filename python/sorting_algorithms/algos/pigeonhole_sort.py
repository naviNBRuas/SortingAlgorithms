from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def pigeonhole_sort(data: Sequence[int], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("pigeonhole_sort", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)
    min_val, max_val = min(arr), max(arr)
    size = max_val - min_val + 1
    holes = [0] * size
    for x in arr:
        holes[x - min_val] += 1
        if tracer:
            tracer.record(arr, (), f"count {x}")
    idx = 0
    for i, count in enumerate(holes):
        while count > 0:
            arr[idx] = i + min_val
            idx += 1
            count -= 1
            if tracer:
                tracer.record(arr, (idx - 1,), "fill")
    return _finalize(arr, tracer, ret_trace)
