from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def insertion_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("insertion_sort", trace, tracer)
    for i in range(1, len(arr)):
        key = arr[i]
        j = i - 1
        if tracer:
            tracer.record(arr, (i,), "key")
        while j >= 0 and arr[j] > key:
            arr[j + 1] = arr[j]
            j -= 1
            if tracer:
                tracer.record(arr, (j + 1,), "shift")
        arr[j + 1] = key
        if tracer:
            tracer.record(arr, (j + 1,), "insert")
    return _finalize(arr, tracer, ret_trace)
