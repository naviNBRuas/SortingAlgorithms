"""Regenerate the data-driven sections of README.md from the registry, teaching notes and benchmark data.

    PYTHONPATH=python python scripts/build_docs.py

Sections between <!-- BEGIN:TAG --> / <!-- END:TAG --> markers are rewritten: TABLE (catalogue), GALLERY (one entry per
algorithm with GIF, teaching notes and measured numbers), LANGSUM and LANGSELECT (speed comparison tables).
<!--N-->56<!--/N--> style counters are refreshed too.
"""
from __future__ import annotations

import json
import re
from pathlib import Path

from sorting_algorithms import FAMILIES, REGISTRY
from sorting_algorithms.notes import NOTES

ROOT = Path(__file__).resolve().parents[1]
README = ROOT / "README.md"

FAMILY_BLURB = {
    "Exchange": "Fix inversions by swapping elements: the bubble family, the quicksorts, and a few pathological relatives.",
    "Selection": "Repeatedly select an extreme element: selection sort, the heap family, cycle and tournament sorts.",
    "Insertion": "Grow a sorted structure one element at a time: arrays, gapped arrays, trees and piles.",
    "Merge": "Combine sorted runs: classic merge sorts, an in-place variant and run-based strand sort.",
    "Hybrid": "Production sorts that stitch several strategies together.",
    "Distribution": "Look at key *values* instead of comparing elements: counting, radix, bucket and friends. Their compare counters stay at 0 because no two elements are ever compared.",
    "Network": "Data-independent comparator schedules, ideal for hardware, SIMD and GPUs.",
    "Probabilistic": "Randomised sorts with no worst-case bound, included as cautionary tales.",
}


def yn(v: bool) -> str:
    return "✓" if v else "✗"


def table() -> str:
    rows = ["| Algorithm | Family | Best | Average | Worst | Extra space | Stable | In-place |",
            "| --- | --- | --- | --- | --- | --- | :-: | :-: |"]
    for fam in FAMILIES:
        for n, i in REGISTRY.items():
            if i.family == fam:
                rows.append(f"| [{i.title}](#{n}) | {fam} | {i.best} | {i.average} | {i.worst} | {i.space} | {yn(i.stable)} | {yn(i.in_place)} |")
    return "\n".join(rows)


def _load(name):
    p = ROOT / "report" / "data" / name
    return json.loads(p.read_text()) if p.exists() else None


def fmt_ms(v):
    if v is None:
        return None
    return f"{v:.3f} ms" if v < 10 else f"{v:.1f} ms"


def gallery() -> str:
    ops = _load("benchmarks.json")
    lang = _load("languages.json")
    ops_idx = {}
    if ops:
        for r in ops["results"]:
            if r["n"] == 1024 and r["distribution"] == "random":
                ops_idx[r["algorithm"]] = r
    out = []
    for fam in FAMILIES:
        members = [(n, i) for n, i in REGISTRY.items() if i.family == fam]
        if not members:
            continue
        out.append(f"### {fam}\n\n{FAMILY_BLURB[fam]}\n")
        for n, i in members:
            how, use = NOTES[n]
            out.append(f'<a id="{n}"></a>\n#### {i.title}\n')
            out.append(f'<p align="center"><img src="visualizations/gifs/{n}.gif" alt="{i.title} animation" width="560"></p>\n')
            out.append(f"> {i.summary}\n")
            out.append(f"**How it works.** {how}\n")
            out.append(f"**When to use it.** {use}\n")
            flags = ["Stable" if i.stable else "Unstable", "in-place" if i.in_place else "uses extra memory"]
            if i.adaptive:
                flags.append("adaptive")
            out.append("| Best | Average | Worst | Extra space | Properties |\n| :-: | :-: | :-: | :-: | --- |\n"
                       f"| {i.best} | {i.average} | {i.worst} | {i.space} | {', '.join(flags)} |\n")
            facts = []
            r = ops_idx.get(n)
            if r:
                facts.append(f"{r['comparisons']:,.0f} comparisons · {r['writes']:,.0f} writes at n = 1024 (random input)")
            if lang and n in lang["results"].get("c", {}):
                res = lang["results"]
                bits = []
                for key, label in (("c", "C"), ("rust", "Rust"), ("java", "Java"), ("python_kernel", "Python")):
                    v = res.get(key, {}).get(n)
                    if v and v > 0.002:
                        bits.append(f"{label} {fmt_ms(v)}")
                if bits:
                    facts.append(f"time at n = {lang['meta']['sizes'][n]}: " + " · ".join(bits))
            if facts:
                out.append("<sub>**Measured:** " + "; ".join(facts) + "</sub>  ")
            if i.history:
                out.append(f"<sub>**Origin:** {i.history}</sub>")
            out.append("\n<sub>[↑ back to catalogue](#catalogue)</sub>\n")
    return "\n".join(out)


def splice(text: str, tag: str, body: str) -> str:
    pat = re.compile(rf"(<!-- BEGIN:{tag} -->\n).*?(\n<!-- END:{tag} -->)", re.S)
    if not pat.search(text):
        raise SystemExit(f"marker {tag} missing in README.md")
    return pat.sub(lambda m: m.group(1) + body + m.group(2), text)


def main():
    text = README.read_text()
    text = splice(text, "TABLE", table())
    text = splice(text, "GALLERY", gallery())
    tabs = _load("languages_tables.json")
    if tabs:
        text = splice(text, "LANGSUM", tabs["summary"])
        text = splice(text, "LANGSELECT", tabs["selected"])
    text = re.sub(r"<!--N-->\d+<!--/N-->", f"<!--N-->{len(REGISTRY)}<!--/N-->", text)
    README.write_text(text)
    print(f"README updated: {len(REGISTRY)} algorithms")


if __name__ == "__main__":
    main()
