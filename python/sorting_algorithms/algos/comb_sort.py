from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def comb_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None, shrink: float = 1.3):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("comb_sort", trace, tracer)
    gap = len(arr)
    swapped = True
    while gap > 1 or swapped:
        gap = max(1, int(gap / shrink))
        swapped = False
        for i in range(len(arr) - gap):
            j = i + gap
            if tracer:
                tracer.record(arr, (i, j), f"gap={gap}")
            if arr[i] > arr[j]:
                arr[i], arr[j] = arr[j], arr[i]
                swapped = True
                if tracer:
                    tracer.record(arr, (i, j), "swap")
    return _finalize(arr, tracer, ret_trace)
