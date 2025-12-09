"""Command-line driver to run any sorting algorithm from the library.

Examples:
  python -m sorting_algorithms --algo quick_sort --size 12 --seed 7
  python -m sorting_algorithms --algo all
"""
from __future__ import annotations

import argparse
import random
import time
from typing import List

from . import ALGORITHMS


def run_algorithm(name: str, data: List[int]):
    func = ALGORITHMS[name]
    start = time.perf_counter()
    result = func(data)
    elapsed = (time.perf_counter() - start) * 1e3
    return result, elapsed


def main():
    parser = argparse.ArgumentParser(description="Run sorting algorithms with sample data.")
    parser.add_argument("--algo", default="all", help="Algorithm name or 'all'")
    parser.add_argument("--size", type=int, default=12, help="Number of elements to sort")
    parser.add_argument("--seed", type=int, default=0, help="Random seed for reproducibility")
    parser.add_argument("--trace", action="store_true", help="Enable tracing (where supported)")
    args = parser.parse_args()

    rng = random.Random(args.seed)
    data = [rng.randint(-50, 50) for _ in range(args.size)]

    names = list(ALGORITHMS.keys()) if args.algo == "all" else [args.algo]

    for name in names:
        arr = list(data)
        func = ALGORITHMS[name]
        kwargs = {"trace": args.trace}
        if name == "bogo_sort" and not args.trace:
            kwargs["max_shuffles"] = 500  # guardrail
        start = time.perf_counter()
        result = func(arr, **kwargs)
        elapsed = (time.perf_counter() - start) * 1e3
        if isinstance(result, tuple):
            sorted_arr, tracer = result
            print(f"{name:20s} | {elapsed:8.3f} ms | sorted length={len(sorted_arr)} | frames={len(tracer.frames)}")
        else:
            print(f"{name:20s} | {elapsed:8.3f} ms | sorted length={len(result)}")


-if __name__ == "__main__":
-    main()
+if __name__ == "__main__":
+    main()
