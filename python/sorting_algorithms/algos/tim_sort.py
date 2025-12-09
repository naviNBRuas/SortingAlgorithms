from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def tim_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    tracer, ret_trace = _setup_tracer("tim_sort", trace, tracer)
    arr = sorted(data)
    if tracer:
        tracer.record(list(data), (), "start")
        tracer.record(arr, (), "python sorted() (Timsort)")
    return _finalize(arr, tracer, ret_trace)
