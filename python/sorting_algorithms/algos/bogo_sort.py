import random
from typing import Sequence, Optional
from ..base import _setup_tracer, _finalize, SortTracer, Number


def bogo_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None, max_shuffles: int = 10_000, seed: int = 0):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("bogo_sort", trace, tracer)
    rng = random.Random(seed)
    attempts = 0
    while attempts < max_shuffles:
        if tracer:
            tracer.record(arr, (), f"attempt {attempts}")
        if all(arr[i] <= arr[i + 1] for i in range(len(arr) - 1)):
            return _finalize(arr, tracer, ret_trace)
        rng.shuffle(arr)
        attempts += 1
    raise RuntimeError("bogo_sort exceeded maximum shuffles; aborting")
