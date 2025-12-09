from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def bitonic_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("bitonic_sort", trace, tracer)
    n = len(arr)
    k = 1
    while k < n:
        k <<= 1
    padding = k - n
    if padding:
        max_val = max(arr) if arr else 0
        arr.extend([max_val] * padding)

    def _bitonic(lo: int, cnt: int, direction: bool):
        if cnt > 1:
            k = cnt // 2
            _bitonic(lo, k, True)
            _bitonic(lo + k, k, False)
            _merge(lo, cnt, direction)

    def _merge(lo: int, cnt: int, direction: bool):
        if cnt > 1:
            k = cnt // 2
            for i in range(lo, lo + k):
                if (arr[i] > arr[i + k]) == direction:
                    arr[i], arr[i + k] = arr[i + k], arr[i]
                    if tracer:
                        tracer.record(arr, (i, i + k), "compare/swap")
            _merge(lo, k, direction)
            _merge(lo + k, k, direction)

    _bitonic(0, len(arr), True)
    arr = arr[:n]
    return _finalize(arr, tracer, ret_trace)
