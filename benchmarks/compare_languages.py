#!/usr/bin/env python3
"""Cross-language speed comparison: builds every edition with optimising flags and times the same algorithms
on the same deterministic data (n = 1000 values in 0..9999; smaller n for the super-polynomial sorts).

    python3 benchmarks/compare_languages.py            # writes report/data/languages.json
    COBC=/path/to/cobc python3 benchmarks/compare_languages.py   # include COBOL

Each driver reports the *median* time of one sort() call over repeated runs (>= 40 ms of total work, JIT
warm-up for Java). Python is measured twice: the plain kernels (what the other editions are generated
from) and the instrumented reference implementation (which counts every comparison and write).
COBOL has no fine-grained clock, so whole processes are timed and a data-fill-only baseline is subtracted.
"""
from __future__ import annotations

import json
import os
import platform
import shutil
import statistics
import subprocess
import sys
import time

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
BUILD = os.path.join(ROOT, "benchmarks", ".build")
OUT = os.path.join(ROOT, "report", "data", "languages.json")
sys.path.insert(0, os.path.join(ROOT, "python"))
sys.path.insert(0, os.path.join(ROOT, "kernels"))

ALGOS = [l.split() for l in open(os.path.join(ROOT, "benchmarks", "algorithms.txt")).read().split("\n") if l.strip()]
ALGOS = [(a, int(n)) for a, n in ALGOS]


def sh(cmd, cwd=None, env=None, timeout=900):
    return subprocess.run(cmd, cwd=cwd or ROOT, env=env, check=True, capture_output=True, text=True, timeout=timeout).stdout


def parse(out):
    res = {}
    for line in out.splitlines():
        p = line.split()
        if len(p) == 3:
            res[p[0]] = float(p[2])
    return res


def data(n):
    state, d = 12345, []
    for _ in range(n):
        state = (state * 1103515245 + 12345) % 2147483648
        d.append((state // 16) % 10000)
    return d


def median_time(fn, data_, min_total=0.04, max_total=3.0, max_rounds=400, min_rounds=1):
    times, total = [], 0.0
    while len(times) < max_rounds and (len(times) < min_rounds or total < min_total) and total < max_total:
        work = list(data_)
        t0 = time.perf_counter()
        out = fn(work)
        dt = time.perf_counter() - t0
        res = work if out is None else out
        times.append(dt)
        total += dt
    assert res == sorted(data_)
    return statistics.median(times) * 1e3


def python_kernels():
    import test_kernels
    res = {}
    for a, n in ALGOS:
        f = test_kernels.load(a)

        def run(w, f=f):
            f(w, len(w))
        res[a] = median_time(run, data(n))
        print(f"  py-kernel {a:26s} {res[a]:10.3f} ms", flush=True)
    return res


def python_instrumented():
    import sorting_algorithms as sa
    res = {}
    for a, n in ALGOS:
        fn = sa.ALGORITHMS[a]
        res[a] = median_time(lambda w, fn=fn: fn(w), data(n))
        print(f"  py-instrumented {a:26s} {res[a]:10.3f} ms", flush=True)
    return res


def build_and_run():
    os.makedirs(BUILD, exist_ok=True)
    results, versions = {}, {}
    env = dict(os.environ)
    env["PATH"] = env["PATH"] + ":" + os.path.expanduser("~/.hermes/dev/go/bin") + ":" + os.path.expanduser("~/.hermes/dev/cargo/bin")

    def attempt(name, fn):
        t0 = time.time()
        try:
            results[name] = fn()
            print(f"[{name}] ok ({time.time() - t0:.0f}s)", flush=True)
        except Exception as e:  # keep going: a missing toolchain should not abort the whole run
            print(f"[{name}] SKIPPED: {e}", flush=True)

    def c():
        sh(["make", "-C", "c", "clean"]); sh(["make", "-C", "c", "libsort.a"])
        sh(["gcc", "-O2", "-Ic", "c/bench.c", "-Lc", "-lsort", "-o", f"{BUILD}/bench_c"])
        versions["c"] = sh(["gcc", "--version"]).splitlines()[0] + " -O2"
        return parse(sh([f"{BUILD}/bench_c"]))

    def cpp():
        sh(["g++", "-std=c++17", "-O2", "-Icpp/include", "cpp/tests/bench.cpp", "-o", f"{BUILD}/bench_cpp"])
        versions["cpp"] = sh(["g++", "--version"]).splitlines()[0] + " -O2"
        return parse(sh([f"{BUILD}/bench_cpp"]))

    def java():
        out = os.path.join(BUILD, "java")
        sh(["javac", "-d", out, *[os.path.join("java/src/sorting", f) for f in os.listdir(os.path.join(ROOT, "java/src/sorting")) if f.endswith(".java")]])
        versions["java"] = subprocess.run(["java", "-version"], capture_output=True, text=True).stderr.splitlines()[0] + " (JIT, 20 warm-up runs)"
        return parse(sh(["java", "-cp", out, "sorting.Bench"]))

    def go():
        sh(["go", "build", "-o", f"{BUILD}/bench_go", "./cmd/bench"], cwd=os.path.join(ROOT, "go"), env=env)
        versions["go"] = sh(["go", "version"], env=env).strip()
        return parse(sh([f"{BUILD}/bench_go"]))

    def rust():
        sh(["cargo", "build", "--release", "--bin", "bench"], cwd=os.path.join(ROOT, "rust"), env=env)
        versions["rust"] = sh(["rustc", "--version"], env=env).strip() + " --release"
        return parse(sh([os.path.join(ROOT, "rust/target/release/bench")]))

    def asm():
        sh(["make", "-C", "assembly", "clean"]); sh(["make", "-C", "assembly", "libsortasm.a"])
        sh(["gcc", "-O2", "assembly/bench.c", "-Lassembly", "-lsortasm", "-o", f"{BUILD}/bench_asm"])
        versions["asm"] = "GNU as (hand-written 28 + compiled 28), timed through a C harness"
        return parse(sh([f"{BUILD}/bench_asm"]))

    def mc():
        sh(["make", "-C", "machine-code", "all"])
        sh(["gcc", "-O2", "machine-code/bench.c", "-o", f"{BUILD}/bench_mc"])
        versions["machine"] = "raw x86-64 images loaded into executable memory"
        return parse(sh([f"{BUILD}/bench_mc"], cwd=os.path.join(ROOT, "machine-code")))

    def cobol():
        cobc = os.environ.get("COBC") or shutil.which("cobc")
        if not cobc:
            raise RuntimeError("no cobc (set COBC=/path/to/cobc)")
        cenv = dict(os.environ)
        base = os.path.dirname(os.path.dirname(cobc))
        cenv["LD_LIBRARY_PATH"] = os.path.join(base, "lib") + ":" + cenv.get("LD_LIBRARY_PATH", "")
        cenv["COB_LIBRARY_PATH"] = os.path.join(base, "lib")
        cenv["PATH"] = os.path.dirname(cobc) + ":" + cenv["PATH"]
        cob = [f for f in sorted(os.listdir(os.path.join(ROOT, "cobol"))) if f.endswith(".cob") and f not in ("test.cob", "bench.cob")]
        sh([cobc, "-x", "-free", "-O2", "-o", f"{BUILD}/bench_cobol", "cobol/bench.cob", *[f"cobol/{f}" for f in cob]], env=cenv)
        versions["cobol"] = sh([cobc, "--version"], env=cenv).splitlines()[0] + " -O2 (process-timed)"

        def wall(idx, reps=3):
            ts = []
            for _ in range(reps):
                t0 = time.perf_counter()
                subprocess.run([f"{BUILD}/bench_cobol", str(idx)], env=cenv, capture_output=True, timeout=300)
                ts.append(time.perf_counter() - t0)
            return statistics.median(ts) * 1e3

        base = wall(0, 5)
        res = {}
        for i, (a, n) in enumerate(ALGOS, 1):
            try:
                res[a] = max(wall(i, 1 if a in ("bubble_sort",) else 3) - base, 0.0)
            except subprocess.TimeoutExpired:
                continue
            print(f"  cobol {a:26s} {res[a]:10.1f} ms", flush=True)
        return res

    for name, fn in (("c", c), ("cpp", cpp), ("java", java), ("go", go), ("rust", rust), ("asm", asm), ("machine", mc), ("cobol", cobol)):
        attempt(name, fn)
    return results, versions


def main():
    results, versions = build_and_run()
    print("python kernels ...", flush=True)
    results["python_kernel"] = python_kernels()
    versions["python_kernel"] = f"CPython {platform.python_version()}, plain kernels"
    print("python instrumented ...", flush=True)
    results["python_instrumented"] = python_instrumented()
    versions["python_instrumented"] = f"CPython {platform.python_version()}, tracing reference implementation (counts every compare/write)"
    cpu = [l.split(":")[1].strip() for l in open("/proc/cpuinfo") if l.startswith("model name")][0]
    os.makedirs(os.path.dirname(OUT), exist_ok=True)
    json.dump({"meta": {"cpu": cpu, "os": platform.platform(), "versions": versions,
                        "sizes": dict(ALGOS), "note": "median ms per sort() call"},
               "results": results}, open(OUT, "w"), indent=1)
    print("wrote", OUT)


if __name__ == "__main__":
    main()
