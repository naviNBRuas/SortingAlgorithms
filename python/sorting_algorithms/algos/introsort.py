import math
from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def introsort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("introsort", trace, tracer)
    max_depth = int(math.log2(len(arr) + 1)) * 2 if arr else 0

    def _heapify(n: int, i: int):
        largest = i
        l, r = 2 * i + 1, 2 * i + 2
        if l < n and arr[l] > arr[largest]:
            largest = l
        if r < n and arr[r] > arr[largest]:
            largest = r
        if largest != i:
            arr[i], arr[largest] = arr[largest], arr[i]
            if tracer:
                tracer.record(arr, (i, largest), "heapify swap")
            _heapify(n, largest)

    def _heapsort(n: int):
        for i in range(n // 2 - 1, -1, -1):
            _heapify(n, i)
        for i in range(n - 1, 0, -1):
            arr[0], arr[i] = arr[i], arr[0]
            if tracer:
                tracer.record(arr, (0, i), "extract max")
            _heapify(i, 0)

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

    def _introsort(lo: int, hi: int, depth: int):
        size = hi - lo + 1
        if size <= 16:
            for i in range(lo + 1, hi + 1):
                key = arr[i]
                j = i - 1
                while j >= lo and arr[j] > key:
                    arr[j + 1] = arr[j]
                    j -= 1
                arr[j + 1] = key
                if tracer:
                    tracer.record(arr, (j + 1,), "insert")
            return
        if depth == 0:
            _heapsort(hi + 1)
            return
        p = _partition(lo, hi)
        _introsort(lo, p - 1, depth - 1)
        _introsort(p + 1, hi, depth - 1)

    if arr:
        _introsort(0, len(arr) - 1, max_depth)
    return _finalize(arr, tracer, ret_trace)
