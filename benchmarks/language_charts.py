#!/usr/bin/env python3
"""Charts + markdown tables for the cross-language speed comparison (reads report/data/languages.json)."""
from __future__ import annotations

import json
import math
import os
import sys

import matplotlib

matplotlib.use("Agg")
import matplotlib.pyplot as plt
import numpy as np

sys.path.insert(0, os.path.join(os.path.dirname(os.path.dirname(os.path.abspath(__file__))), "python"))
from sorting_algorithms import REGISTRY  # noqa: E402

ROOT = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DATA = os.path.join(ROOT, "report", "data", "languages.json")
FIG = os.path.join(ROOT, "report", "figures")
os.makedirs(FIG, exist_ok=True)

ORDER = ["c", "cpp", "rust", "go", "asm", "machine", "java", "cobol", "python_kernel", "python_instrumented"]
NAMES = {"c": "C", "cpp": "C++", "rust": "Rust", "go": "Go", "asm": "x86-64 asm", "machine": "Machine code", "java": "Java",
         "cobol": "COBOL", "python_kernel": "Python (kernel)", "python_instrumented": "Python (instrumented)"}
COL = {"c": "#58a6ff", "cpp": "#79c0ff", "rust": "#f78166", "go": "#56d4dd", "asm": "#d29922", "machine": "#e3b341", "java": "#ff7b72",
       "cobol": "#a371f7", "python_kernel": "#3fb950", "python_instrumented": "#2ea043"}


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


def gmean(xs):
    xs = [x for x in xs if x > 0]
    return math.exp(sum(math.log(x) for x in xs) / len(xs))


def main():
    d = json.load(open(DATA))
    r = {l: {a: v for a, v in res.items() if v > 0.002} for l, res in d["results"].items()}   # drop sub-resolution (COBOL) zeros
    langs = [l for l in ORDER if l in r and r[l]]
    algos = sorted(r["c"]) if "c" in r else sorted(r[langs[0]])
    base = "c" if "c" in r else langs[0]

    # relative-to-C slowdown per algorithm
    rel = {l: {a: r[l][a] / max(r[base][a], 1e-6) for a in algos if a in r[l]} for l in langs}
    gm = {l: gmean(list(rel[l].values())) for l in langs}
    med = {l: float(np.median(list(rel[l].values()))) for l in langs}

    # ---- fig 1: geometric-mean slowdown vs C
    order = sorted(langs, key=lambda l: gm[l])
    fig, ax = plt.subplots(figsize=(9, 4.6))
    vals = [gm[l] for l in order]
    bars = ax.barh(range(len(order)), vals, color=[COL[l] for l in order])
    ax.set_yticks(range(len(order)), [NAMES[l] for l in order], color="#c9d1d9")
    ax.invert_yaxis()
    ax.set_xscale("log")
    ax.set_xlabel("geometric-mean time relative to C  (lower is faster, log scale)")
    for b, v in zip(bars, vals):
        ax.text(v * 1.08, b.get_y() + b.get_height() / 2, f"{v:.1f}×", va="center", color="#e6edf3", fontsize=9)
    ax.set_title(f"Speed of the same {len(algos)} algorithms in nine editions (n = 1000)")
    ax.axvline(1, color="#8b949e", lw=0.8)
    style(ax)
    ax.grid(axis="y", visible=False)
    fig.tight_layout()
    fig.savefig(f"{FIG}/lang_overall.png", dpi=140)
    plt.close(fig)

    # ---- fig 2: heatmap, algorithms x languages (slowdown vs fastest language for that algorithm)
    fastest = {a: min(r[l][a] for l in langs if a in r[l] and r[l][a] > 0) for a in algos}
    sort_algos = sorted(algos, key=lambda a: r[base][a])
    mat = np.array([[r[l][a] / fastest[a] if a in r[l] else np.nan for l in order] for a in sort_algos])
    fig, ax = plt.subplots(figsize=(8.5, 0.24 * len(sort_algos) + 1.8))
    im = ax.imshow(np.log10(mat), aspect="auto", cmap="viridis")
    ax.set_xticks(range(len(order)), [NAMES[l].replace(" (", "\n(") for l in order], color="#c9d1d9", fontsize=8)
    ax.xaxis.tick_top()
    ax.set_yticks(range(len(sort_algos)), [REGISTRY[a].title for a in sort_algos], color="#c9d1d9", fontsize=7)
    for i in range(len(sort_algos)):
        for j in range(len(order)):
            v = mat[i, j]
            if not np.isnan(v):
                ax.text(j, i, f"{v:.0f}" if v >= 10 else f"{v:.1f}", ha="center", va="center", fontsize=6, color="white" if np.log10(v) < 1.8 else "black")
    ax.set_title("Time ÷ fastest edition for that algorithm (1 = fastest; log colour scale)", color="#e6edf3", fontsize=10, pad=34)
    fig.set_facecolor("#0d1117")
    fig.tight_layout()
    fig.savefig(f"{FIG}/lang_heatmap.png", dpi=130)
    plt.close(fig)

    # ---- fig 3: selected algorithms, absolute ms, grouped bars
    picks = ["bubble_sort", "insertion_sort", "quick_sort", "merge_sort", "heap_sort", "tim_sort", "radix_sort_lsd", "counting_sort"]
    picks = [p for p in picks if p in algos]
    fig, ax = plt.subplots(figsize=(11, 5))
    w = 0.8 / len(order)
    for k, l in enumerate(order):
        ys = [max(r[l].get(a, np.nan), 1e-4) for a in picks]
        ax.bar(np.arange(len(picks)) + k * w - 0.4 + w / 2, ys, w, label=NAMES[l], color=COL[l])
    ax.set_yscale("log")
    ax.set_xticks(range(len(picks)), [REGISTRY[a].title for a in picks], rotation=20, ha="right", color="#c9d1d9")
    ax.set_ylabel("median time per sort (ms, log scale), n = 1000")
    ax.set_title("Eight algorithms across nine editions")
    ax.legend(ncol=5, fontsize=7, facecolor="#161b22", labelcolor="#c9d1d9", edgecolor="#30363d", loc="upper center", bbox_to_anchor=(0.5, -0.28))
    style(ax)
    fig.tight_layout()
    fig.savefig(f"{FIG}/lang_selected.png", dpi=140)
    plt.close(fig)

    # ---- markdown
    def f(v):
        return "—" if v is None else (f"{v:.3f}" if v < 10 else f"{v:.1f}")

    head = "| Edition | Geometric mean vs C | Median vs C | Fastest on (of %d) | Toolchain |\n|---|:-:|:-:|:-:|---|\n" % len(algos)
    wins = {l: sum(1 for a in algos if a in r[l] and r[l][a] <= fastest[a] * 1.0001) for l in langs}
    ver = d["meta"]["versions"]
    rows = "\n".join(f"| {NAMES[l]} | {gm[l]:.2f}× | {med[l]:.2f}× | {wins[l]} | {ver.get(l, '')} |" for l in order)
    hand = {a for a in algos if os.path.exists(os.path.join(ROOT, "assembly", a + ".s"))}
    if "asm" in r:
        gh = gmean([rel["asm"][a] for a in hand if a in rel["asm"]])
        gc = gmean([rel["asm"][a] for a in algos if a not in hand and a in rel["asm"]])
        rows += f"\n| ↳ asm, hand-written ({len(hand)} algorithms) | {gh:.2f}× | | | hand-written |\n| ↳ asm, compiler-generated | {gc:.2f}× | | | `kernels/backends/x86.py` |"
        gm["asm_hand"], gm["asm_compiled"] = gh, gc
    summary = head + rows

    sel = ["bubble_sort", "insertion_sort", "selection_sort", "shell_sort", "heap_sort", "merge_sort", "quick_sort", "intro_sort", "tim_sort", "radix_sort_lsd", "counting_sort", "bitonic_sort"]
    sel = [s for s in sel if s in algos]
    t = "| Algorithm | " + " | ".join(NAMES[l] for l in order) + " |\n|---|" + "---:|" * len(order) + "\n"
    for a in sel:
        t += f"| {REGISTRY[a].title} | " + " | ".join(f(r[l].get(a)) for l in order) + " |\n"

    full = "| Algorithm (n) | " + " | ".join(NAMES[l] for l in order) + " |\n|---|" + "---:|" * len(order) + "\n"
    for a in algos:
        full += f"| {REGISTRY[a].title} ({d['meta']['sizes'][a]}) | " + " | ".join(f(r[l].get(a)) for l in order) + " |\n"

    out = {"summary": summary, "selected": t, "full": full, "gm": gm, "meta": d["meta"]}
    json.dump(out, open(os.path.join(ROOT, "report", "data", "languages_tables.json"), "w"), indent=1)
    print(summary)
    print("figures written")


if __name__ == "__main__":
    main()
