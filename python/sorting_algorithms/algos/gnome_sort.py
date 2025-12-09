from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def gnome_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("gnome_sort", trace, tracer)
    idx = 0
    while idx < len(arr):
        if idx == 0 or arr[idx] >= arr[idx - 1]:
            idx += 1
        else:
            arr[idx], arr[idx - 1] = arr[idx - 1], arr[idx]
            if tracer:
                tracer.record(arr, (idx - 1, idx), "swap")
            idx -= 1
    return _finalize(arr, tracer, ret_trace)
