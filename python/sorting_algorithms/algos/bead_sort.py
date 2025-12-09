from typing import Sequence, Optional, List
from ..base import _setup_tracer, _finalize, SortTracer, Number


def bead_sort(data: Sequence[int], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("bead_sort", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)

    min_val = min(arr)
    if min_val < 0:
        # shift to non-negative domain; bead sort assumes >=0
        shift = -min_val
        arr = [x + shift for x in arr]
    else:
        shift = 0

    max_val = max(arr)
    grid = [[0] * len(arr) for _ in range(max_val)]

    for col, val in enumerate(arr):
        for row in range(val):
            grid[row][col] = 1
    if tracer:
        tracer.record(arr, (), "load beads")

    for row in grid:
        beads = sum(row)
        row[:] = [1] * beads + [0] * (len(arr) - beads)

    output: List[int] = []
    for col in range(len(arr)):
        count = sum(grid[row][col] for row in range(max_val))
        output.append(count)
    output.reverse()  # natural bead drop yields descending; reverse to ascending
    if shift:
        output = [x - shift for x in output]
    if tracer:
        tracer.record(output, (), "collect")
    return _finalize(output, tracer, ret_trace)
