from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def bucket_sort(data: Sequence[Number], *, buckets: int = 10, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("bucket_sort", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)
    min_val, max_val = min(arr), max(arr)
    range_width = (max_val - min_val) / buckets if buckets else 1
    bucket_list: List[List[Number]] = [[] for _ in range(buckets)]
    for value in arr:
        idx = int((value - min_val) / range_width) if range_width > 0 else 0
        idx = min(idx, buckets - 1)
        bucket_list[idx].append(value)
        if tracer:
            tracer.record(arr, (), f"assign to bucket {idx}")
    sorted_arr: List[Number] = []
    for b in bucket_list:
        sorted_arr.extend(sorted(b))
    if tracer:
        tracer.record(sorted_arr, (), "concat buckets")
    return _finalize(sorted_arr, tracer, ret_trace)
