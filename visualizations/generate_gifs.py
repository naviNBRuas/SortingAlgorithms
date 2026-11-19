"""Render one animated GIF per algorithm (plus a multi-algorithm race) from real traces.

    PYTHONPATH=python python visualizations/generate_gifs.py            # everything
    PYTHONPATH=python python visualizations/generate_gifs.py bubble_sort merge_sort
    PYTHONPATH=python python visualizations/generate_gifs.py --race-only

Frames come from the same instrumented code the tests and benchmarks run, so
every animation shows the algorithm's true sequence of compares and writes.
"""
from __future__ import annotations

import argparse
import random
import sys
from pathlib import Path
from typing import List, Sequence

from PIL import Image, ImageDraw, ImageFont

from sorting_algorithms import ALGORITHMS, REGISTRY, SortTracer

OUT = Path(__file__).resolve().parent / "gifs"

BG = (13, 17, 23)
BAR = (88, 166, 255)
COMPARE = (242, 204, 96)
WRITE = (255, 123, 114)
DONE = (63, 185, 80)
TEXT = (230, 237, 243)
MUTED = (139, 148, 158)

W, H = 480, 270
MAX_FRAMES = 170
FRAME_MS = 45


def _font(size: int):
    for path in (
        "/usr/share/fonts/truetype/dejavu/DejaVuSans.ttf",
        "/usr/share/fonts/dejavu/DejaVuSans.ttf",
    ):
        if Path(path).exists():
            return ImageFont.truetype(path, size)
    try:
        import matplotlib
        return ImageFont.truetype(str(Path(matplotlib.get_data_path()) / "fonts/ttf/DejaVuSans.ttf"), size)
    except Exception:
        return ImageFont.load_default()


def draw_frame(state, highlights, kind, title, subtitle, hud, w=W, h=H, sweep=None, scale=1.0):
    img = Image.new("RGB", (w, h), BG)
    d = ImageDraw.Draw(img)
    big, small = _font(int(15 * scale)), _font(int(10 * scale))
    d.text((12 * scale, 8 * scale), title, font=big, fill=TEXT)
    d.text((12 * scale, 28 * scale), subtitle, font=small, fill=MUTED)
    tw = d.textlength(hud, font=small)
    d.text((w - tw - 12 * scale, 11 * scale), hud, font=small, fill=MUTED)
    top, bottom, margin = int(50 * scale), h - int(10 * scale), int(12 * scale)
    n = len(state)
    if n == 0:
        return img
    vals = [float(v) for v in state]
    lo, hi = min(vals), max(vals)
    span = (hi - lo) or 1.0
    slot = (w - 2 * margin) / n
    gap = 1 if slot > 4 else 0
    hl = set(highlights)
    color = COMPARE if kind == "compare" else WRITE
    for i, v in enumerate(vals):
        bh = 3 + (bottom - top - 3) * (v - lo) / span
        x0 = margin + i * slot
        c = BAR
        if sweep is not None and i < sweep:
            c = DONE
        elif i in hl:
            c = color
        d.rectangle([x0, bottom - bh, x0 + slot - gap - 0.01, bottom], fill=c)
    return img


def _pick(frames: Sequence, limit: int) -> List:
    if len(frames) <= limit:
        return list(frames)
    step = (len(frames) - 1) / (limit - 1)
    idx = sorted({round(i * step) for i in range(limit)})
    return [frames[i] for i in idx]


def _sample(n: int, seed: int = 7) -> List[int]:
    vals = list(range(1, n + 1))
    random.Random(seed).shuffle(vals)
    return vals


def trace_for(name: str, n: int | None = None):
    info = REGISTRY[name]
    n = n or info.viz_n
    tracer = SortTracer(name)
    data = _sample(n)
    try:
        ALGORITHMS[name](data, tracer=tracer, **info.viz_kwargs)
    except RuntimeError:  # bogo/bozo guard: show what we have, then the sorted result
        tracer.record(sorted(data), (), "sorted")
    return tracer


def _save(images: List[Image.Image], durations: List[int], path: Path):
    ref = Image.new("RGB", (images[0].width, images[0].height * 3))
    for k, im in enumerate((images[0], images[len(images) // 2], images[-1])):
        ref.paste(im, (0, k * images[0].height))
    palette = ref.quantize(colors=48, method=Image.Quantize.MEDIANCUT)
    frames = [im.quantize(palette=palette, dither=Image.Dither.NONE) for im in images]
    path.parent.mkdir(parents=True, exist_ok=True)
    frames[0].save(path, save_all=True, append_images=frames[1:], duration=durations, loop=0, optimize=True, disposal=1)


def render(name: str) -> Path:
    info = REGISTRY[name]
    tracer = trace_for(name)
    frames = _pick(tracer.frames, MAX_FRAMES)
    n = len(frames[-1].state)
    sub = f"{info.family}  ·  best {info.best}  avg {info.average}  worst {info.worst}"
    images, durations = [], []
    for k, f in enumerate(frames):
        hud = f"compares {f.comparisons:,}   writes {f.writes:,}"
        images.append(draw_frame(f.state, f.highlights, f.note, info.title, sub, hud))
        durations.append(FRAME_MS * (8 if k == 0 else 1))
    last = frames[-1]
    hud = f"compares {last.comparisons:,}   writes {last.writes:,}"
    step = max(1, n // 24)
    for s in list(range(step, n, step)) + [n]:
        images.append(draw_frame(last.state, (), "", info.title, sub, hud, sweep=s))
        durations.append(FRAME_MS)
    durations[-1] = 1800
    path = OUT / f"{name}.gif"
    _save(images, durations, path)
    return path


RACE = ["bubble_sort", "selection_sort", "insertion_sort", "shell_sort", "comb_sort",
        "heap_sort", "merge_sort", "quick_sort", "tim_sort"]


def render_race(names=RACE, n=48, cols=3, steps=190) -> Path:
    """Every tile advances by the same number of primitive operations (compares + writes)."""
    traces = {k: trace_for(k, n).frames for k in names}
    ops = {k: [f.comparisons + f.writes for f in fr] for k, fr in traces.items()}
    total = max(o[-1] for o in ops.values())
    tw, th = 240, 150
    rows = (len(names) + cols - 1) // cols
    small = 0.62
    images, durations = [], []
    cursor = {k: 0 for k in names}
    for s in range(steps + 1):
        budget = total * (s / steps) ** 0.8
        canvas = Image.new("RGB", (tw * cols, th * rows + 28), BG)
        cd = ImageDraw.Draw(canvas)
        cd.text((10, 5), "Sorting race: each tile advances by equal operation count (compares + writes)", font=_font(11), fill=TEXT)
        for t, k in enumerate(names):
            fr, o, c = traces[k], ops[k], cursor[k]
            while c < len(fr) - 1 and o[c + 1] <= budget:
                c += 1
            cursor[k] = c
            f = fr[c]
            done = c == len(fr) - 1
            hud = f"{o[c]:,} ops"
            tile = draw_frame(f.state, f.highlights, f.note, REGISTRY[k].title, "", hud, tw, th,
                              sweep=len(f.state) if done else None, scale=0.62)
            canvas.paste(tile, ((t % cols) * tw, 28 + (t // cols) * th))
        images.append(canvas)
        durations.append(FRAME_MS)
    durations[-1] = 2500
    path = OUT / "race.gif"
    _save(images, durations, path)
    return path


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("names", nargs="*", help="algorithm names (default: all)")
    ap.add_argument("--race-only", action="store_true")
    args = ap.parse_args(argv)
    if not args.race_only:
        for name in args.names or list(ALGORITHMS):
            p = render(name)
            print(f"{p.name:34s} {p.stat().st_size / 1024:7.0f} KB", flush=True)
    if args.race_only or not args.names:
        p = render_race()
        print(f"{p.name:34s} {p.stat().st_size / 1024:7.0f} KB")


if __name__ == "__main__":
    sys.exit(main())
