from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def pancake_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("pancake_sort", trace, tracer)

    def flip(k: int):
        arr[:k] = arr[:k][::-1]
        if tracer:
            tracer.record(arr, tuple(range(k)), f"flip {k}")

    n = len(arr)
    for curr_size in range(n, 1, -1):
        max_idx = max(range(curr_size), key=arr.__getitem__) if curr_size else 0
        if max_idx != curr_size - 1:
            flip(max_idx + 1)
            flip(curr_size)
    return _finalize(arr, tracer, ret_trace)
