from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def strand_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("strand_sort", trace, tracer)
    output: List[Number] = []

    def merge(left: List[Number], right: List[Number]) -> List[Number]:
        merged: List[Number] = []
        i = j = 0
        while i < len(left) and j < len(right):
            if left[i] <= right[j]:
                merged.append(left[i]); i += 1
            else:
                merged.append(right[j]); j += 1
        merged.extend(left[i:])
        merged.extend(right[j:])
        return merged

    while arr:
        strand = [arr.pop(0)]
        i = 0
        while i < len(arr):
            if arr[i] >= strand[-1]:
                strand.append(arr.pop(i))
            else:
                i += 1
        output = merge(output, strand)
        if tracer:
            tracer.record(output + strand, (), "strand merge")

    return _finalize(output, tracer, ret_trace)
