from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def shell_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("shell_sort", trace, tracer)
    gap = len(arr) // 2
    while gap > 0:
        for i in range(gap, len(arr)):
            temp = arr[i]
            j = i
            while j >= gap and arr[j - gap] > temp:
                arr[j] = arr[j - gap]
                j -= gap
                if tracer:
                    tracer.record(arr, (j, j + gap), f"gap={gap}")
            arr[j] = temp
            if tracer:
                tracer.record(arr, (j,), f"gap={gap} insert")
        gap //= 2
    return _finalize(arr, tracer, ret_trace)
