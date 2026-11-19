"""Command-line driver.

Examples:
  python -m sorting_algorithms --list
  python -m sorting_algorithms --algo quick_sort --size 12 --seed 7 --trace
  python -m sorting_algorithms --algo all --size 200
"""
from __future__ import annotations

import argparse
import random
import time

from . import ALGORITHMS, REGISTRY, measure


def main(argv=None) -> int:
    parser = argparse.ArgumentParser(description="Run sorting algorithms on random data.")
    parser.add_argument("--algo", default="all", help="algorithm name or 'all'")
    parser.add_argument("--size", type=int, default=12, help="number of elements")
    parser.add_argument("--seed", type=int, default=0, help="random seed")
    parser.add_argument("--trace", action="store_true", help="record animation frames and print the count")
    parser.add_argument("--list", action="store_true", help="list algorithms and exit")
    args = parser.parse_args(argv)

    if args.list:
        for name, info in REGISTRY.items():
            print(f"{name:24s} {info.family:13s} best {info.best:12s} avg {info.average:14s} worst {info.worst}")
        return 0

    names = list(ALGORITHMS) if args.algo == "all" else [args.algo]
    unknown = [n for n in names if n not in ALGORITHMS]
    if unknown:
        parser.error(f"unknown algorithm {unknown[0]!r}; use --list")

    rng = random.Random(args.seed)
    data = [rng.randint(-50, 50) for _ in range(args.size)]
    print(f"{'algorithm':24s} {'ms':>9s} {'compares':>10s} {'writes':>9s}  ok")
    for name in names:
        size = min(args.size, REGISTRY[name].bench_max_n or args.size)
        sample = data[:size]
        t0 = time.perf_counter()
        out, st = measure(name, sample)
        ms = (time.perf_counter() - t0) * 1e3
        extra = ""
        if args.trace:
            _, tr = ALGORITHMS[name](sample, trace=True, **REGISTRY[name].bench_kwargs)
            extra = f"  frames={len(tr)}"
        print(f"{name:24s} {ms:9.3f} {st.comparisons:10d} {st.writes:9d}  {out == sorted(sample)}{extra}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
