from bisect import bisect_left
from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def patience_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("patience_sort", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)

    piles: List[List[Number]] = []
    for x in arr:
        i = bisect_left([p[-1] for p in piles], x)
        if i == len(piles):
            piles.append([x])
        else:
            piles[i].append(x)
        if tracer:
            flattened = [v for pile in piles for v in pile]
            tracer.record(flattened, (), f"place {x} -> pile {i}")

    # collect using multiway merge (simple: repeatedly pop min top)
    result: List[Number] = []
    tops = [pile[-1] for pile in piles]
    while piles:
        min_idx = min(range(len(tops)), key=tops.__getitem__)
        result.append(tops[min_idx])
        piles[min_idx].pop()
        if piles[min_idx]:
            tops[min_idx] = piles[min_idx][-1]
        else:
            piles.pop(min_idx)
            tops.pop(min_idx)
        if tracer:
            tracer.record(result + tops, (), "collect")

    return _finalize(result, tracer, ret_trace)
