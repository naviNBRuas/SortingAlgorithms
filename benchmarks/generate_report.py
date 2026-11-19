"""Turn report/data/benchmarks.json into figures and REPORT.md.

    PYTHONPATH=python python benchmarks/generate_report.py
"""
from __future__ import annotations

import json
import math
from collections import defaultdict
from pathlib import Path

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

from sorting_algorithms import FAMILIES, REGISTRY

ROOT = Path(__file__).resolve().parents[1]
DATA = ROOT / "report" / "data" / "benchmarks.json"
FIG = ROOT / "report" / "figures"
FIG.mkdir(parents=True, exist_ok=True)

FAMCOL = {"Exchange": "#e5534b", "Selection": "#daaa3f", "Insertion": "#57ab5a", "Merge": "#539bf5",
          "Hybrid": "#b083f0", "Distribution": "#39c5cf", "Network": "#f69d50", "Probabilistic": "#768390"}
BIG = 1024


def style(ax):
    ax.set_facecolor("#0d1117")
    ax.figure.set_facecolor("#0d1117")
    for s in ax.spines.values():
        s.set_color("#30363d")
    ax.tick_params(colors="#c9d1d9")
    ax.xaxis.label.set_color("#c9d1d9")
    ax.yaxis.label.set_color("#c9d1d9")
    ax.title.set_color("#e6edf3")
    ax.grid(color="#21262d", lw=0.6)


def load():
    raw = json.loads(DATA.read_text())
    idx = {}
    for r in raw["results"]:
        idx[(r["algorithm"], r["n"], r["distribution"])] = r
    return raw["meta"], idx


def ops(r):
    return r["comparisons"] + r["writes"]


def main():
    meta, idx = load()
    algos = list(REGISTRY)
    big = [a for a in algos if (a, BIG, "random") in idx]
    skip_small = [a for a in algos if a not in big]

    # ---- Fig 1: scaling curves -------------------------------------------------
    fig, axes = plt.subplots(1, 2, figsize=(13, 5.2))
    def slope(a):
        ns = [n for n in meta["sizes"] if (a, n, "random") in idx and n >= 128]
        return float(np.polyfit(np.log(ns), np.log([max(1, ops(idx[(a, n, "random")])) for n in ns]), 1)[0])

    quad = {a for a in big if slope(a) >= 1.55}
    for ax, title, group in (
        (axes[0], "Quadratic behaviour (fitted p ≥ 1.55)", [a for a in big if a in quad]),
        (axes[1], "n log n, n log² n and linear (p < 1.55)", [a for a in big if a not in quad]),
    ):
        finals = sorted(group, key=lambda a: -ops(idx[(a, 2048, "random")]))
        label = set(finals[:5]) | set(finals[-3:])
        for a in group:
            ns = sorted(n for (x, n, d) in idx if x == a and d == "random")
            y = [max(1, ops(idx[(a, n, "random")])) for n in ns]
            ax.plot(ns, y, marker="o", ms=3, lw=1.4, color=FAMCOL[REGISTRY[a].family], alpha=0.85)
            if a in label:
                ax.annotate(REGISTRY[a].title.split(" (")[0], (ns[-1], y[-1]), fontsize=7, color="#c9d1d9",
                            xytext=(4, 0), textcoords="offset points")
        ax.set_xscale("log", base=2)
        ax.set_yscale("log")
        ax.set_xlim(right=2 ** 13)
        ax.set_xlabel("n (random permutation)")
        ax.set_ylabel("operations = comparisons + writes")
        ax.set_title(title)
        style(ax)
    handles = [plt.Line2D([], [], color=c, lw=3, label=f) for f, c in FAMCOL.items()]
    axes[1].legend(handles=handles, fontsize=7, facecolor="#161b22", labelcolor="#c9d1d9", edgecolor="#30363d", loc="upper left")
    fig.tight_layout()
    fig.savefig(FIG / "scaling.png", dpi=130)
    plt.close(fig)

    # ---- Fig 2: heatmap of ops / (n log2 n) -------------------------------------
    dists = meta["distributions"]
    order = sorted(big, key=lambda a: ops(idx[(a, BIG, "random")]))
    mat = np.array([[ops(idx[(a, BIG, d)]) / (BIG * math.log2(BIG)) for d in dists] for a in order])
    fig, ax = plt.subplots(figsize=(7.2, 0.27 * len(order) + 1.6))
    im = ax.imshow(np.log10(np.maximum(mat, 1e-2)), aspect="auto", cmap="magma", vmin=-1, vmax=1.3)
    ax.set_xticks(range(len(dists)), [d.replace("_", "\n") for d in dists], color="#c9d1d9", fontsize=8)
    ax.set_yticks(range(len(order)), [REGISTRY[a].title for a in order], color="#c9d1d9", fontsize=7.5)
    for i in range(len(order)):
        for j in range(len(dists)):
            ax.text(j, i, f"{mat[i, j]:.2f}" if mat[i, j] < 100 else f"{mat[i, j]:.0f}", ha="center", va="center",
                    fontsize=6.5, color="white" if mat[i, j] < 3 else "black")
    ax.set_title(f"Operations ÷ (n·log₂n) at n = {BIG}  (lower is better)", color="#e6edf3", fontsize=10)
    fig.set_facecolor("#0d1117")
    fig.tight_layout()
    fig.savefig(FIG / "heatmap.png", dpi=130)
    plt.close(fig)

    # ---- Fig 3/4: writes and runtime ---------------------------------------------
    for key, label, fname, log in (("writes", "array writes", "writes.png", True), ("ms", "median runtime (ms)", "runtime.png", True)):
        order = sorted(big, key=lambda a: idx[(a, BIG, "random")][key])
        fig, ax = plt.subplots(figsize=(8, 0.22 * len(order) + 1.2))
        vals = [max(idx[(a, BIG, "random")][key], 0.5) for a in order]
        ax.barh(range(len(order)), vals, color=[FAMCOL[REGISTRY[a].family] for a in order])
        ax.set_yticks(range(len(order)), [REGISTRY[a].title for a in order], fontsize=7.5, color="#c9d1d9")
        if log:
            ax.set_xscale("log")
        ax.set_xlabel(f"{label}, n = {BIG}, random permutation")
        style(ax)
        ax.grid(axis="y", visible=False)
        fig.tight_layout()
        fig.savefig(FIG / fname, dpi=130)
        plt.close(fig)

    # ---- empirical exponents ------------------------------------------------------
    expo = {}
    for a in big:
        ns = [n for n in meta["sizes"] if (a, n, "random") in idx and n >= 64]
        ys = [max(1, ops(idx[(a, n, "random")])) for n in ns]
        if len(ns) >= 3:
            expo[a] = float(np.polyfit(np.log(ns), np.log(ys), 1)[0])
    order = sorted(expo, key=expo.get)
    fig, ax = plt.subplots(figsize=(8, 0.22 * len(order) + 1.2))
    ax.barh(range(len(order)), [expo[a] for a in order], color=[FAMCOL[REGISTRY[a].family] for a in order])
    ax.set_yticks(range(len(order)), [REGISTRY[a].title for a in order], fontsize=7.5, color="#c9d1d9")
    ax.axvline(1, color="#8b949e", lw=0.8, ls="--")
    ax.axvline(2, color="#8b949e", lw=0.8, ls="--")
    ax.set_xlabel("fitted exponent p in ops ≈ c·nᵖ  (n = 64 … 2048, random input)")
    style(ax)
    ax.grid(axis="y", visible=False)
    fig.tight_layout()
    fig.savefig(FIG / "exponents.png", dpi=130)
    plt.close(fig)

    # ---- tables -------------------------------------------------------------------
    def tbl(header, rows):
        return "\n".join(["| " + " | ".join(header) + " |", "|" + "|".join(["---"] + [":-:"] * (len(header) - 1)) + "|"]
                         + ["| " + " | ".join(map(str, r)) + " |" for r in rows])

    comp_based = [a for a in big if REGISTRY[a].keys == "any"]
    by_cmp = sorted(comp_based, key=lambda a: idx[(a, BIG, "random")]["comparisons"])
    t_cmp = tbl(["Rank", "Algorithm", "Comparisons", "× lower bound", "Writes"],
                [(i + 1, REGISTRY[a].title, f"{idx[(a, BIG, 'random')]['comparisons']:,.0f}",
                  f"{idx[(a, BIG, 'random')]['comparisons'] / math.ceil(math.log2(math.factorial(BIG))):.2f}",
                  f"{idx[(a, BIG, 'random')]['writes']:,.0f}") for i, a in enumerate(by_cmp[:12])])
    by_w = sorted([a for a in big if REGISTRY[a].in_place], key=lambda a: idx[(a, BIG, "random")]["writes"])
    t_w = tbl(["Rank", "Algorithm", "Writes", "Comparisons"],
              [(i + 1, REGISTRY[a].title, f"{idx[(a, BIG, 'random')]['writes']:,.0f}",
                f"{idx[(a, BIG, 'random')]['comparisons']:,.0f}") for i, a in enumerate(by_w[:10])])
    adapt = sorted(comp_based, key=lambda a: ops(idx[(a, BIG, "sorted")]) / ops(idx[(a, BIG, "random")]))
    t_ad = tbl(["Algorithm", "Sorted ÷ random", "Reversed ÷ random", "Nearly-sorted ÷ random", "Few-unique ÷ random"],
               [(REGISTRY[a].title,
                 *[f"{ops(idx[(a, BIG, d)]) / ops(idx[(a, BIG, 'random')]):.2f}" for d in ("sorted", "reversed", "nearly_sorted", "few_unique")])
                for a in adapt])
    t_exp = tbl(["Algorithm", "Fitted p", "Claimed average"],
                [(REGISTRY[a].title, f"{expo[a]:.2f}", REGISTRY[a].average) for a in sorted(expo, key=expo.get)])
    by_ms = sorted(big, key=lambda a: idx[(a, BIG, "random")]["ms"])
    t_ms = tbl(["Rank", "Algorithm", "ms (n=1024)", "Comparisons", "Writes"],
               [(i + 1, REGISTRY[a].title, f"{idx[(a, BIG, 'random')]['ms']:.2f}",
                 f"{idx[(a, BIG, 'random')]['comparisons']:,.0f}", f"{idx[(a, BIG, 'random')]['writes']:,.0f}") for i, a in enumerate(by_ms)])

    path_rows = []
    for a in algos:
        if REGISTRY[a].bench_max_n:
            ns = sorted(n for (x, n, d) in idx if x == a and d == "random")
            mx = ns[-1]
            r = idx[(a, mx, "random")]
            path_rows.append((REGISTRY[a].title, mx, f"{r['comparisons']:,.0f}", f"{r['writes']:,.0f}", f"{r['ms']:.1f}"))

    qs = idx[("quick_sort", BIG, "sorted")]["comparisons"]
    qs_r = idx[("quick_sort", BIG, "random")]["comparisons"]
    q3 = idx[("quick_sort_3way", BIG, "few_unique")]["comparisons"]
    q3l = idx[("quick_sort", BIG, "few_unique")]["comparisons"]
    best_cmp = by_cmp[0]
    least_w = by_w[0]
    fastest = by_ms[0]
    ln = lambda a: REGISTRY[a].title
    lb = math.ceil(math.log2(math.factorial(BIG)))

    md = f"""# Sorting Algorithms: Empirical Study

*Generated by `benchmarks/generate_report.py` from `report/data/benchmarks.json`.
Python {meta['python']}, {meta['platform']}.*

## 1. Summary

We implemented {len(REGISTRY)} sorting algorithms in a single instrumented framework, verified them against Python's `sorted()`
(random, sorted, reversed, duplicate-heavy and tiny inputs; stability; 0-1 principle for networks) and measured each on
{len(meta['distributions'])} input shapes at sizes n = {meta['sizes'][0]} … {meta['sizes'][-1]}.

Headline results at n = {BIG} (random permutation):

- **Fewest comparisons:** {ln(best_cmp)} with {idx[(best_cmp, BIG, 'random')]['comparisons']:,.0f}, i.e. {idx[(best_cmp, BIG, 'random')]['comparisons'] / lb:.2f}× the information-theoretic minimum ⌈log₂ n!⌉ = {lb:,}.
- **Fewest writes:** {ln(least_w)} ({idx[(least_w, BIG, 'random')]['writes']:,.0f} writes).
- **Fastest wall-clock in Python:** {ln(fastest)} ({idx[(fastest, BIG, 'random')]['ms']:.2f} ms); see §5 for why this ranking differs from the operation counts.
- **Input shape matters enormously:** Lomuto quicksort uses {qs_r:,.0f} comparisons on random data but {qs:,.0f} on sorted data (**{qs / qs_r:.0f}×**), while 3-way quicksort needs {q3:,.0f} instead of {q3l:,.0f} on 10-valued data (**{q3l / max(q3, 1):.1f}× fewer**).

## 2. Method

**Instrumentation.** Algorithms operate on a `Tracked` array; every element is wrapped so each `<`, `<=`, `>`, `>=`, `==` is counted, and every
`a[i] = v` or `swap` counts as a write (a swap is two). Counts are therefore exact and machine-independent.
Distribution sorts (counting, radix, bucket, …) never compare elements, so they report 0 comparisons and are ranked by writes and
runtime. Out-of-place algorithms that build an auxiliary structure (tree, patience, tournament, strand, counting, …) report only
the final copy-back as writes (n), so *their write counts understate memory traffic*; treat write rankings with that caveat.

**Inputs.** `random` (permutation of 0..n−1), `sorted`, `reversed`, `nearly_sorted` (sorted with n/20 random swaps), `few_unique`
(10 distinct values). Seeds are fixed. Sizes are powers of two from {meta['sizes'][0]} to {meta['sizes'][-1]}; super-polynomial sorts
(Stooge, Slow, Bogo, Bozo, Permutation) are capped (Stooge ≤ 128, Slow ≤ 24, Bogo ≤ 7, Bozo ≤ 6, Permutation ≤ 8) and the factorial-time ones are averaged over 12 trials.

**Runtime.** Median of {meta['repeats']} runs of the instrumented-but-untraced code path. This is *Python* time with per-comparison object
overhead — useful for relative comparison, not a statement about C performance.

## 3. Comparison efficiency

![Scaling of operation counts](report/figures/scaling.png)

Algorithms are split by measured slope on the log-log axes (left: quadratic, right: everything else); only the five most and three least expensive in each panel are labelled. Colour encodes family.

### Fewest comparisons at n = {BIG} (random)

{t_cmp}

### Fewest writes at n = {BIG} (random), in-place algorithms

Out-of-place sorts are excluded because their counted writes are just the final copy-back (see §2).

{t_w}

![Writes](report/figures/writes.png)

## 4. Input sensitivity

![Heatmap of operations per n log n](report/figures/heatmap.png)

Operations ÷ (n·log₂ n) for every algorithm and input shape. Values near 1 mean "about as many operations as the n log n ideal";
dark cells are algorithms that handle that shape gracefully; bright cells indicate quadratic behaviour.

### Adaptivity (comparison-based algorithms; ratio of operations to the random-input cost)

{t_ad}

Reading the table: a ratio far below 1 on `sorted` marks an adaptive algorithm (insertion, bubble, gnome, Tim, smooth, …); a ratio above 1 on `sorted`
or `reversed` marks an algorithm with a degenerate case (Lomuto and dual-pivot quicksort with fixed end pivots, unbalanced tree sort).

## 5. Wall-clock time (Python)

{t_ms}

![Runtime](report/figures/runtime.png)

In CPython the cost of an operation is dominated by interpreter overhead, so algorithms with fewer, simpler Python-level steps (the
bucket/counting/radix family working on plain integers) beat theoretically superior comparison sorts, and anything that allocates
auxiliary lists and wraps elements pays for it. Do not read this table as a prediction for compiled languages.

## 6. Empirical growth exponents

We fitted ops ≈ c·nᵖ over n = 64 … 2048 on random input.

![Fitted exponents](report/figures/exponents.png)

{t_exp}

Caveats: over this range n log n appears as p ≈ 1.1–1.25 and quadratic sorts as p ≈ 2. For the distribution sorts and the out-of-place tree/patience/tournament/strand sorts the
fit only reflects *counted* operations (comparisons + writes); work that the counters do not see — walking a count array of size k, dropping beads on n·max cells,
ticking a simulated clock — is not included, so their p ≈ 1 understates their true cost (bead sort is Θ(S), not Θ(n)). Ordering within a tight cluster (e.g. 1.14 vs 1.19) is not significant.

## 7. Pathological algorithms

{tbl(['Algorithm', 'Largest n tried', 'Comparisons', 'Writes', 'ms'], path_rows)}

These algorithms are included for completeness: their cost explodes super-polynomially (Stooge ≈ n^2.7, Slow sort worse than any polynomial,
Bogo/Bozo/Permutation factorial), which is why they are capped.

## 8. Threats to validity

- Single machine, single Python version; wall-clock numbers vary. Operation counts are exact.
- One seed per (n, distribution) for deterministic algorithms; random pivots are not used anywhere.
- Python's `sorted()` (Timsort in C) is not part of the comparison; the pure-Python `tim_sort` here omits galloping mode.
- Distribution sorts are given integer keys in a range proportional to n; with huge key ranges (k ≫ n) counting/pigeonhole/bead/sleep sorts degrade, as their complexity predicts.
- Write counts exclude auxiliary buffers, as noted in §2.

## 9. Reproducing

```sh
export PYTHONPATH=$PWD/python
python benchmarks/run_benchmarks.py && python benchmarks/generate_report.py
```
"""
    lang_json = ROOT / "report" / "data" / "languages_tables.json"
    if lang_json.exists():
        lt = json.loads(lang_json.read_text())
        md += f"""
## 10. Cross-language speed comparison

The same algorithms on the same deterministic data (n = 1000 values in 0..9999; smaller n for the super-polynomial sorts) in every edition,
on {lt['meta']['cpu']} ({lt['meta']['os']}). Each value is the median time of one `sort()` call. Reproduce with `benchmarks/compare_languages.py`
and `benchmarks/language_charts.py`.

![Geometric-mean slowdown relative to C](report/figures/lang_overall.png)

{lt['summary']}

### Representative algorithms (median ms per sort)

{lt['selected']}

![Eight algorithms across nine editions](report/figures/lang_selected.png)

![Time relative to the fastest edition, per algorithm](report/figures/lang_heatmap.png)

### All algorithms (median ms per sort; n in parentheses)

{lt['full']}

Notes: Java is JIT-warmed (20 untimed runs) and excludes JVM start-up; COBOL is timed per process with a data-fill-only baseline
subtracted (about 1 ms resolution; sub-millisecond results are shown as —); the two assembly rows and the machine-code row execute identical
instructions; Python is measured both as plain kernels and as the instrumented reference implementation.
"""
    (ROOT / "REPORT.md").write_text(md)
    print("REPORT.md written")


if __name__ == "__main__":
    main()
