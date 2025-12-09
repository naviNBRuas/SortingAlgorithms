from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def selection_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("selection_sort", trace, tracer)
    n = len(arr)
    for i in range(n):
        min_idx = i
        for j in range(i + 1, n):
            if tracer:
                tracer.record(arr, (min_idx, j), "compare")
            if arr[j] < arr[min_idx]:
                min_idx = j
        arr[i], arr[min_idx] = arr[min_idx], arr[i]
        if tracer:
            tracer.record(arr, (i, min_idx), "select")
    return _finalize(arr, tracer, ret_trace)
