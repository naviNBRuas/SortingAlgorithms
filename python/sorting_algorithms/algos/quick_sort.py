from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def quick_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("quick_sort", trace, tracer)

    def _partition(lo: int, hi: int) -> int:
        pivot = arr[hi]
        i = lo
        for j in range(lo, hi):
            if tracer:
                tracer.record(arr, (j, hi), "compare")
            if arr[j] <= pivot:
                arr[i], arr[j] = arr[j], arr[i]
                if tracer:
                    tracer.record(arr, (i, j), "swap")
                i += 1
        arr[i], arr[hi] = arr[hi], arr[i]
        if tracer:
            tracer.record(arr, (i,), "pivot set")
        return i

    def _quicksort(lo: int, hi: int):
        if lo < hi:
            p = _partition(lo, hi)
            _quicksort(lo, p - 1)
            _quicksort(p + 1, hi)

    _quicksort(0, len(arr) - 1)
    return _finalize(arr, tracer, ret_trace)
