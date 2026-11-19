"""Sorting algorithm atlas: traced, instrumented, registry-driven implementations."""
from .base import (  # noqa: F401
    Number, TraceFrame, SortTracer, Stats, Tracked, AlgoInfo, REGISTRY, ALGORITHMS, FAMILIES, measure,
)
from .algos import exchange, selection, insertion, merge, distribution, network  # noqa: F401  (register algorithms)

globals().update(ALGORITHMS)
introsort = ALGORITHMS["intro_sort"]  # backwards-compatible alias

__all__ = [
    "Number", "TraceFrame", "SortTracer", "Stats", "Tracked", "AlgoInfo",
    "REGISTRY", "ALGORITHMS", "FAMILIES", "measure", "introsort", *ALGORITHMS,
]
