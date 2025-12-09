from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def heap_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("heap_sort", trace, tracer)

    def heapify(n: int, i: int):
        largest = i
        l = 2 * i + 1
        r = 2 * i + 2
        if l < n and arr[l] > arr[largest]:
            largest = l
        if r < n and arr[r] > arr[largest]:
            largest = r
        if largest != i:
            arr[i], arr[largest] = arr[largest], arr[i]
            if tracer:
                tracer.record(arr, (i, largest), "heapify swap")
            heapify(n, largest)

    n = len(arr)
    for i in range(n // 2 - 1, -1, -1):
        heapify(n, i)
    for i in range(n - 1, 0, -1):
        arr[0], arr[i] = arr[i], arr[0]
        if tracer:
            tracer.record(arr, (0, i), "extract max")
        heapify(i, 0)
    return _finalize(arr, tracer, ret_trace)
