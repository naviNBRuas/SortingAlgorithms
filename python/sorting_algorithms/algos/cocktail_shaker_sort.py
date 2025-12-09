from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def cocktail_shaker_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("cocktail_shaker_sort", trace, tracer)
    n = len(arr)
    start, end = 0, n - 1
    swapped = True
    while swapped:
        swapped = False
        for i in range(start, end):
            if tracer:
                tracer.record(arr, (i, i + 1), "forward compare")
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True
                if tracer:
                    tracer.record(arr, (i, i + 1), "swap")
        if not swapped:
            break
        swapped = False
        end -= 1
        for i in range(end - 1, start - 1, -1):
            if tracer:
                tracer.record(arr, (i, i + 1), "backward compare")
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                swapped = True
                if tracer:
                    tracer.record(arr, (i, i + 1), "swap")
        start += 1
    return _finalize(arr, tracer, ret_trace)
