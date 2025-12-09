from bisect import bisect_left
from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def binary_insertion_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("binary_insertion_sort", trace, tracer)
    for i in range(1, len(arr)):
        key = arr[i]
        pos = bisect_left(arr, key, 0, i)
        arr[pos + 1 : i + 1] = arr[pos:i]
        arr[pos] = key
        if tracer:
            tracer.record(arr, (pos,), "insert")
    return _finalize(arr, tracer, ret_trace)
