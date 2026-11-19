"""Measure comparisons, writes and wall time for every algorithm.

    PYTHONPATH=python python benchmarks/run_benchmarks.py

Comparison and write counts are deterministic and machine-independent; wall time
(median of REPEATS runs of the *uninstrumented-trace* code path) is not.
Results land in report/data/benchmarks.json.
"""
from __future__ import annotations

import json
import platform
import random
import statistics
import sys
import time
from pathlib import Path

from sorting_algorithms import ALGORITHMS, REGISTRY, measure

SIZES = [16, 32, 64, 128, 256, 512, 1024, 2048]
DISTRIBUTIONS = ["random", "sorted", "reversed", "nearly_sorted", "few_unique"]
REPEATS = 3
OUT = Path(__file__).resolve().parents[1] / "report" / "data" / "benchmarks.json"
SMALL_TRIALS = 12  # averaged trials for the factorial-time sorts


def make(dist: str, n: int, seed: int):
    rng = random.Random(seed)
    if dist == "random":
        return rng.sample(range(n), n)
    if dist == "sorted":
        return list(range(n))
    if dist == "reversed":
        return list(range(n - 1, -1, -1))
    if dist == "nearly_sorted":
        a = list(range(n))
        for _ in range(max(1, n // 20)):
            i, j = rng.randrange(n), rng.randrange(n)
            a[i], a[j] = a[j], a[i]
        return a
    if dist == "few_unique":
        return [rng.randrange(10) for _ in range(n)]
    raise ValueError(dist)


def run_one(name, data, kw):
    best_t, res = [], None
    for _ in range(REPEATS):
        t0 = time.perf_counter()
        out, st = measure(name, data, **kw)
        best_t.append(time.perf_counter() - t0)
        res = (out, st)
    out, st = res
    assert out == sorted(data), (name, len(data))
    return {"comparisons": st.comparisons, "writes": st.writes, "reads": st.reads,
            "ms": statistics.median(best_t) * 1e3}


def main():
    results = []
    for name, info in REGISTRY.items():
        cap = info.bench_max_n or SIZES[-1]
        sizes = [n for n in SIZES if n <= cap] or []
        if cap < SIZES[0]:  # factorial-time sorts: tiny sizes, averaged
            sizes = list(range(3, cap + 1))
        for n in sizes:
            for dist in DISTRIBUTIONS:
                if cap < SIZES[0] and dist != "random":
                    continue
                trials = SMALL_TRIALS if cap < SIZES[0] else 1
                rows = []
                for t in range(trials):
                    kw = dict(info.bench_kwargs)
                    if cap < SIZES[0]:
                        if name == "bogo_sort":
                            kw.update({"seed": t, "max_shuffles": 5_000_000})
                        elif name == "bozo_sort":
                            kw.update({"seed": t, "max_swaps": 5_000_000})
                    rows.append(run_one(name, make(dist, n, 1000 + t), kw))
                results.append({"algorithm": name, "n": n, "distribution": dist,
                                **{k: statistics.mean(r[k] for r in rows) for k in rows[0]}})
        print(f"{name:26s} done", flush=True)
    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({
        "meta": {"python": platform.python_version(), "platform": platform.platform(),
                 "sizes": SIZES, "distributions": DISTRIBUTIONS, "repeats": REPEATS},
        "results": results}, indent=1))
    print(f"wrote {OUT} ({len(results)} rows)")


if __name__ == "__main__":
    sys.exit(main())
