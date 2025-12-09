from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number
from .heap_sort import heap_sort


def smooth_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    """
    Simplified smooth sort wrapper using heapsort as a Leonardo heap surrogate
    for instructional clarity.
    """
    arr = list(data)
    tracer, ret_trace = _setup_tracer("smooth_sort", trace, tracer)
    result = heap_sort(arr, tracer=tracer, trace=False)
    return result if not ret_trace else (result, tracer)
