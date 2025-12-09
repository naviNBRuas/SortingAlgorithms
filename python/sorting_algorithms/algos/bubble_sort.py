from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def bubble_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("bubble_sort", trace, tracer)
    n = len(arr)
    for i in range(n):
        for j in range(0, n - i - 1):
            if tracer:
                tracer.record(arr, (j, j + 1), "compare")
            if arr[j] > arr[j + 1]:
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                if tracer:
                    tracer.record(arr, (j, j + 1), "swap")
    return _finalize(arr, tracer, ret_trace)
