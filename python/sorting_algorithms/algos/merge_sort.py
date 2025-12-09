from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def merge_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("merge_sort", trace, tracer)

    def _merge(left: int, mid: int, right: int):
        merged = []
        i, j = left, mid
        while i < mid and j < right:
            if tracer:
                tracer.record(arr, (i, j), "compare")
            if arr[i] <= arr[j]:
                merged.append(arr[i]); i += 1
            else:
                merged.append(arr[j]); j += 1
        merged.extend(arr[i:mid]); merged.extend(arr[j:right])
        arr[left:right] = merged
        if tracer:
            tracer.record(arr, tuple(range(left, right)), "merge")

    def _merge_sort(left: int, right: int):
        if right - left <= 1:
            return
        mid = (left + right) // 2
        _merge_sort(left, mid)
        _merge_sort(mid, right)
        _merge(left, mid, right)

    _merge_sort(0, len(arr))
    return _finalize(arr, tracer, ret_trace)
