from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def odd_even_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("odd_even_sort", trace, tracer)
    n = len(arr)
    sorted_flag = False
    while not sorted_flag:
        sorted_flag = True
        for i in range(1, n - 1, 2):
            if tracer:
                tracer.record(arr, (i, i + 1), "odd compare")
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                sorted_flag = False
                if tracer:
                    tracer.record(arr, (i, i + 1), "swap")
        for i in range(0, n - 1, 2):
            if tracer:
                tracer.record(arr, (i, i + 1), "even compare")
            if arr[i] > arr[i + 1]:
                arr[i], arr[i + 1] = arr[i + 1], arr[i]
                sorted_flag = False
                if tracer:
                    tracer.record(arr, (i, i + 1), "swap")
    return _finalize(arr, tracer, ret_trace)
