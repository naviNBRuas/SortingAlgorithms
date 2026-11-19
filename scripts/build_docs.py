"""Regenerate the registry-driven sections of README.md (catalogue table + GIF gallery).

    PYTHONPATH=python python scripts/build_docs.py
"""
from __future__ import annotations

import re
from pathlib import Path

from sorting_algorithms import FAMILIES, REGISTRY

ROOT = Path(__file__).resolve().parents[1]
README = ROOT / "README.md"

FAMILY_BLURB = {
    "Exchange": "Fix inversions by swapping elements: the bubble family, the quicksorts, and a few pathological relatives.",
    "Selection": "Repeatedly select an extreme element: selection, the heaps, cycle and tournament sorts.",
    "Insertion": "Grow a sorted structure one element at a time: arrays, gapped arrays, trees and piles.",
    "Merge": "Combine sorted runs: classic merge sorts, in-place variants and run-based strand sort.",
    "Hybrid": "Production sorts that stitch several strategies together.",
    "Distribution": "Look at key values instead of comparing: counting, radix, bucket and friends. Compare counts are 0 because no element comparison is made.",
    "Network": "Data-independent comparator schedules, ideal for hardware and GPUs.",
    "Probabilistic": "Randomised sorts with no worst-case bound. Included as cautionary tales.",
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


def gallery() -> str:
    out = []
    for fam in FAMILIES:
        members = [(n, i) for n, i in REGISTRY.items() if i.family == fam]
        if not members:
            continue
        out.append(f"### {fam}\n\n{FAMILY_BLURB[fam]}\n")
        for n, i in members:
            flags = f"{'stable' if i.stable else 'unstable'}, {'in-place' if i.in_place else 'not in-place'}"
            out.append(f'<a id="{n}"></a>\n#### {i.title}\n')
            out.append(f"{i.summary}\n")
            out.append(f"<img src=\"visualizations/gifs/{n}.gif\" alt=\"{i.title} animation\" width=\"480\">\n")
            out.append(f"- **Time:** best {i.best} · average {i.average} · worst {i.worst}\n"
                       f"- **Space:** {i.space} · {flags}\n"
                       + (f"- **Origin:** {i.history}\n" if i.history else ""))
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
    README.write_text(text)
    print(f"README updated: {len(REGISTRY)} algorithms")


if __name__ == "__main__":
    main()
