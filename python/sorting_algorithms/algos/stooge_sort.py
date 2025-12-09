from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def stooge_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("stooge_sort", trace, tracer)

    def _stooge(i: int, j: int):
        if arr[i] > arr[j]:
            arr[i], arr[j] = arr[j], arr[i]
            if tracer:
                tracer.record(arr, (i, j), "swap")
        if j - i + 1 > 2:
            t = (j - i + 1) // 3
            _stooge(i, j - t)
            _stooge(i + t, j)
            _stooge(i, j - t)

    if arr:
        _stooge(0, len(arr) - 1)
    return _finalize(arr, tracer, ret_trace)
