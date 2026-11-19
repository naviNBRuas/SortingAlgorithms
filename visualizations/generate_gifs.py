"""Render one animated GIF per algorithm (plus race montages) from real execution traces.

    PYTHONPATH=python python visualizations/generate_gifs.py                 # everything
    PYTHONPATH=python python visualizations/generate_gifs.py bubble_sort merge_sort
    PYTHONPATH=python python visualizations/generate_gifs.py --races-only

Frames come from the same instrumented code the tests and benchmarks run, so every animation shows the algorithm's
true sequence of compares and writes. What each frame shows:

  * bars coloured by value (cyan → indigo), so you can see order emerge;
  * amber = elements being compared, red = elements written/swapped, pink = pivot / current candidate;
  * green = elements already in their final position; bars outside the active range are dimmed;
  * a phase caption ("merge [0, 8) and [8, 16)", "gap = 5", ...), live compare/write counters and a progress bar;
  * for distribution sorts, heaps' siblings aside, a second panel with the auxiliary structure (counts, buckets, piles).
"""
from __future__ import annotations

import argparse
import colorsys
import random
import sys
from pathlib import Path
from typing import List, Optional, Sequence

from PIL import Image, ImageDraw, ImageFont

from sorting_algorithms import ALGORITHMS, REGISTRY, SortTracer

OUT = Path(__file__).resolve().parent / "gifs"

BG = (13, 17, 23)
PANEL = (22, 27, 34)
BORDER = (48, 54, 61)
TEXT = (230, 237, 243)
MUTED = (139, 148, 158)
COMPARE = (255, 236, 61)
WRITE = (255, 69, 58)
PIVOT = (255, 45, 160)
DONE = (48, 209, 88)
AUX = (64, 200, 224)

W, H = 560, 380
MAX_FRAMES = 160
FRAME_MS = 45

_FONT_DIR = Path("/usr/share/fonts/truetype/dejavu")


def font(size: int, bold: bool = False):
    name = "DejaVuSans-Bold.ttf" if bold else "DejaVuSans.ttf"
    for base in (_FONT_DIR, Path("/usr/share/fonts/dejavu")):
        if (base / name).exists():
            return ImageFont.truetype(str(base / name), size)
    try:
        import matplotlib
        return ImageFont.truetype(str(Path(matplotlib.get_data_path()) / "fonts/ttf" / name), size)
    except Exception:
        return ImageFont.load_default()


FONTS = {}


def F(size, bold=False):
    k = (size, bold)
    if k not in FONTS:
        FONTS[k] = font(size, bold)
    return FONTS[k]


def bar_color(t: float):
    r, g, b = colorsys.hsv_to_rgb(0.50 + 0.19 * t, 0.62, 1.0)
    return int(r * 255), int(g * 255), int(b * 255)


def dim(c, f=0.38):
    return tuple(int(BG[i] + (c[i] - BG[i]) * f) for i in range(3))


NOTE_TEXT = {
    "start": "initial array", "sorted": "sorted: verifying left to right", "compare": "comparing two elements",
    "swap": "swapping two elements", "write": "writing an element", "place": "placing an element in the output",
    "commit": "copying the result back", "insert": "inserting", "extract": "extracting the next smallest",
    "count": "counting keys", "gather": "gathering results", "scatter": "scattering into buckets",
    "bucket": "distributing into buckets", "deal": "dealing onto piles", "collect": "collecting from piles",
    "drop": "dropping into holes", "prefix": "prefix sums", "try": "trying a permutation",
}


def wrap(draw, text, fnt, width, max_lines):
    words, lines, cur = text.split(), [], ""
    for w in words:
        t = (cur + " " + w).strip()
        if draw.textlength(t, font=fnt) <= width:
            cur = t
        else:
            lines.append(cur)
            cur = w
    lines.append(cur)
    if len(lines) > max_lines:
        lines = lines[:max_lines]
        lines[-1] = lines[-1].rstrip(" ,.;:") + "…"
    return lines


def fit(draw, text, fnt, width):
    if draw.textlength(text, font=fnt) <= width:
        return text
    while text and draw.textlength(text + "…", font=fnt) > width:
        text = text[:-1]
    return text + "…"


class Style:
    """Per-algorithm static layout."""

    def __init__(self, name, vmin, vmax, has_aux):
        info = REGISTRY[name]
        self.info = info
        self.vmin, self.vmax = vmin, vmax
        self.has_aux = has_aux


def draw_bars(d, x0, y0, w, h, frame, st: Style, sweep=None, tile=False):
    state = frame.state
    n = len(state)
    if n == 0:
        return
    span = (st.vmax - st.vmin) or 1
    slot = w / n
    gap = 1 if slot >= 5 else 0
    focus = frame.focus
    done = set()
    for lo, hi in frame.done or ():
        done.update(range(max(lo, 0), min(hi, n - 1) + 1))
    hl = set(frame.highlights)
    hl_color = COMPARE if frame.note == "compare" else WRITE
    if focus:
        fx0 = x0 + focus[0] * slot
        fx1 = x0 + (focus[1] + 1) * slot
        d.rectangle([fx0, y0, fx1, y0 + h], fill=PANEL)
    for i, v in enumerate(state):
        t = min(max((float(v) - st.vmin) / span, 0.0), 1.0)
        bh = 3 + (h - 6) * t
        base = bar_color(t)
        if sweep is not None and i < sweep:
            c = DONE
        elif i in hl and not tile:
            c = hl_color
        elif i in hl:
            c = hl_color
        elif frame.pivot is not None and i == frame.pivot:
            c = PIVOT
        elif i in done:
            c = DONE
        elif focus and not (focus[0] <= i <= focus[1]):
            c = dim(base)
        else:
            c = base
        xa = x0 + i * slot
        d.rectangle([xa, y0 + h - bh, xa + slot - gap - 0.01, y0 + h], fill=c)


def draw_aux(d, x0, y0, w, h, frame):
    aux = frame.aux
    d.rectangle([x0 - 1, y0 - 1, x0 + w, y0 + h], outline=BORDER)
    d.text((x0 + 6, y0 + 3), fit(d, frame.aux_label or "auxiliary structure", F(10), w - 12), font=F(10), fill=MUTED)
    if not aux:
        return
    m = max(max(aux), 1)
    n = len(aux)
    top = y0 + 18
    bh_max = h - 22
    slot = (w - 8) / n
    gap = 1 if slot >= 5 else 0
    hl = set(frame.aux_hl)
    for i, v in enumerate(aux):
        bh = 2 + (bh_max - 2) * v / m if v else 1
        xa = x0 + 4 + i * slot
        d.rectangle([xa, top + bh_max - bh, xa + slot - gap - 0.01, top + bh_max], fill=COMPARE if i in hl else AUX)
        if n <= 14 and slot >= 14:
            s = str(v)
            d.text((xa + slot / 2 - d.textlength(s, font=F(9)) / 2, top + bh_max - bh - 11), s, font=F(9), fill=TEXT)


def draw_frame(frame, st: Style, step, total, sweep=None) -> Image.Image:
    img = Image.new("RGB", (W, H), BG)
    d = ImageDraw.Draw(img)
    info = st.info
    # header
    d.text((14, 10), info.title, font=F(18, True), fill=TEXT)
    fam = info.family
    fw = d.textlength(fam, font=F(10, True)) + 14
    d.rounded_rectangle([W - 14 - fw, 12, W - 14, 30], radius=9, outline=BORDER, fill=PANEL)
    d.text((W - 14 - fw + 7, 15), fam, font=F(10, True), fill=MUTED)
    chips = (f"best {info.best}  ·  avg {info.average}  ·  worst {info.worst}  ·  space {info.space}  ·  "
             f"{'stable' if info.stable else 'unstable'}  ·  {'in-place' if info.in_place else 'extra memory'}")
    d.text((14, 36), fit(d, chips, F(10), W - 28), font=F(10), fill=(110, 168, 254))
    for i, line in enumerate(wrap(d, info.summary, F(11), W - 28, 2)):
        d.text((14, 54 + i * 15), line, font=F(11), fill=MUTED)
    # panels
    main_y = 90
    foot_h = 52
    aux_h = 62 if st.has_aux else 0
    main_h = H - main_y - foot_h - (aux_h + 8 if st.has_aux else 0)
    draw_bars(d, 14, main_y, W - 28, main_h, frame, st, sweep)
    if st.has_aux:
        ay = main_y + main_h + 8
        if frame.aux:
            draw_aux(d, 14, ay, W - 28, aux_h, frame)
        else:
            d.rectangle([13, ay - 1, W - 14, ay + aux_h], outline=BORDER)
            d.text((20, ay + 3), "auxiliary structure appears here", font=F(10), fill=(80, 88, 96))
    # footer: phase caption, counters, legend, progress
    fy = H - foot_h + 4
    if sweep is not None:
        phase = "sorted ✓  verifying left to right" if sweep < len(frame.state) else "sorted ✓"
    else:
        phase = frame.label or NOTE_TEXT.get(frame.note, frame.note)
    d.text((14, fy), fit(d, phase, F(12, True), W - 28), font=F(12, True), fill=TEXT)
    hud = f"compares {frame.comparisons:,}   writes {frame.writes:,}"
    d.text((W - 14 - d.textlength(hud, font=F(10, True)), fy + 23), hud, font=F(10, True), fill=MUTED)
    lx = 14
    for label, col in (("compare", COMPARE), ("write / swap", WRITE), ("pivot / candidate", PIVOT), ("final position", DONE)):
        d.rectangle([lx, fy + 24, lx + 8, fy + 32], fill=col)
        d.text((lx + 12, fy + 22), label, font=F(9), fill=MUTED)
        lx += 18 + d.textlength(label, font=F(9)) + 12
    d.rectangle([14, H - 8, W - 14, H - 5], fill=PANEL)
    d.rectangle([14, H - 8, 14 + (W - 28) * min(step / max(total, 1), 1.0), H - 5], fill=(110, 168, 254))
    return img


def pick(frames: Sequence, limit: int) -> List:
    """Evenly spaced frames, plus the first frame of every distinct phase label so no phase is skipped."""
    if len(frames) <= limit:
        return list(frames)
    keep = {round(i * (len(frames) - 1) / (limit - 1)) for i in range(limit)}
    last = None
    for i, f in enumerate(frames):
        if f.label != last:
            keep.add(i)
            last = f.label
    idx = sorted(keep)
    if len(idx) > limit + 40:      # too many phase changes (e.g. per-element labels): thin evenly
        step = len(idx) / (limit + 40)
        idx = sorted({idx[int(i * step)] for i in range(limit + 40)} | {0, len(frames) - 1})
    return [frames[i] for i in idx]


def sample(n: int, kind: str = "random", seed: int = 7) -> List[int]:
    rng = random.Random(seed)
    vals = list(range(1, n + 1))
    if kind == "random":
        rng.shuffle(vals)
    elif kind == "nearly":
        for _ in range(max(2, n // 12)):
            i, j = rng.randrange(n), rng.randrange(n)
            vals[i], vals[j] = vals[j], vals[i]
    elif kind == "reversed":
        vals.reverse()
    elif kind == "few":
        vals = [rng.randint(1, 5) * (n // 5) for _ in range(n)]
    return vals


def trace_for(name: str, n: Optional[int] = None, kind: str = "random"):
    info = REGISTRY[name]
    n = n or info.viz_n
    tracer = SortTracer(name)
    data = sample(n, kind)
    try:
        ALGORITHMS[name](data, tracer=tracer, **info.viz_kwargs)
    except RuntimeError:
        tracer.record(sorted(data), (), "sorted")
    return tracer


def _save(images: List[Image.Image], durations: List[int], path: Path):
    ref = Image.new("RGB", (images[0].width, images[0].height * 3 + 16))
    for k, im in enumerate((images[0], images[len(images) // 2], images[-1])):
        ref.paste(im, (0, k * images[0].height))
    sd = ImageDraw.Draw(ref)
    y = images[0].height * 3
    for i in range(64):                                    # every gradient colour, bright and dimmed
        sd.rectangle([i * 8, y, i * 8 + 7, y + 7], fill=bar_color(i / 63))
        sd.rectangle([i * 8, y + 8, i * 8 + 7, y + 15], fill=dim(bar_color(i / 63)))
    palette = ref.quantize(colors=128, method=Image.Quantize.MEDIANCUT)
    frames = [im.quantize(palette=palette, dither=Image.Dither.NONE) for im in images]
    path.parent.mkdir(parents=True, exist_ok=True)
    frames[0].save(path, save_all=True, append_images=frames[1:], duration=durations, loop=0, optimize=True, disposal=1)


def render(name: str) -> Path:
    tracer = trace_for(name)
    all_frames = tracer.frames
    vmin = min(float(v) for v in all_frames[-1].state)
    vmax = max(float(v) for v in all_frames[-1].state)
    has_aux = any(f.aux for f in all_frames)
    st = Style(name, vmin, vmax, has_aux)
    frames = pick(all_frames, MAX_FRAMES)
    total = len(frames)
    images, durations = [], []
    for k, f in enumerate(frames):
        images.append(draw_frame(f, st, k, total))
        durations.append(FRAME_MS * (10 if k == 0 else 1))
    last = frames[-1]
    n = len(last.state)
    step = max(1, n // 22)
    final = type(last)(last.state, (), "sorted", last.comparisons, last.writes, aux=None)
    for s in list(range(step, n, step)) + [n]:
        images.append(draw_frame(final, st, total, total, sweep=s))
        durations.append(FRAME_MS)
    durations[-1] = 2200
    path = OUT / f"{name}.gif"
    _save(images, durations, path)
    return path


# ------------------------------------------------------------------------------ race montages
RACES = {
    "race": ("Sorting race: nine classics, equal operation budgets",
             ["bubble_sort", "selection_sort", "insertion_sort", "shell_sort", "comb_sort", "heap_sort", "merge_sort", "quick_sort", "tim_sort"], "random", 3),
    "race_quadratic": ("The O(n²) family: same random input",
                       ["bubble_sort", "cocktail_shaker_sort", "gnome_sort", "odd_even_sort", "selection_sort", "insertion_sort"], "random", 3),
    "race_nlogn": ("The O(n log n) family: same random input",
                   ["merge_sort", "quick_sort_hoare", "heap_sort", "intro_sort", "tim_sort", "tree_sort"], "random", 3),
    "race_distribution": ("Beyond comparisons: distribution sorts",
                          ["counting_sort", "radix_sort_lsd", "radix_sort_msd", "bucket_sort", "flash_sort", "american_flag_sort"], "random", 3),
    "race_nearly_sorted": ("Adaptivity: nearly sorted input",
                           ["bubble_sort", "insertion_sort", "tim_sort", "smooth_sort", "quick_sort", "merge_sort"], "nearly", 3),
    "race_sorted_input": ("The worst case for naive pivots: already-sorted input",
                          ["quick_sort", "quick_sort_hoare", "quick_sort_3way", "intro_sort", "merge_sort", "tim_sort"], "sorted", 3),
}


def render_race(key: str, steps=170) -> Path:
    title, names, kind, cols = RACES[key]
    n = 48
    traces = {k: trace_for(k, n, "random" if kind == "random" else ("sorted" if kind == "sorted" else kind)).frames for k in names}
    if kind == "sorted":
        traces = {}
        for k in names:
            tr = SortTracer(k)
            data = list(range(1, n + 1))
            ALGORITHMS[k](data, tracer=tr)
            traces[k] = tr.frames
    ops = {k: [f.comparisons + f.writes for f in fr] for k, fr in traces.items()}
    total = max(o[-1] for o in ops.values())
    tw, th = 260, 176
    rows = (len(names) + cols - 1) // cols
    head = 34
    images, durations = [], []
    cursor = {k: 0 for k in names}
    styles = {}
    for k in names:
        fr = traces[k]
        styles[k] = Style(k, min(float(v) for v in fr[-1].state), max(float(v) for v in fr[-1].state), False)
    for s in range(steps + 1):
        budget = total * (s / steps) ** 0.75
        canvas = Image.new("RGB", (tw * cols, th * rows + head), BG)
        cd = ImageDraw.Draw(canvas)
        cd.text((12, 6), title, font=F(14, True), fill=TEXT)
        cd.text((12, 22), "every tile advances by the same number of primitive operations (compares + writes)", font=F(9), fill=MUTED)
        for t, k in enumerate(names):
            fr, o, c = traces[k], ops[k], cursor[k]
            while c < len(fr) - 1 and o[c + 1] <= budget:
                c += 1
            cursor[k] = c
            f = fr[c]
            done = c == len(fr) - 1
            tile = Image.new("RGB", (tw, th), BG)
            td = ImageDraw.Draw(tile)
            td.text((8, 5), REGISTRY[k].title, font=F(11, True), fill=TEXT)
            hud = f"{o[c]:,} ops" + ("  ✓" if done else "")
            td.text((tw - 8 - td.textlength(hud, font=F(10)), 7), hud, font=F(10), fill=DONE if done else MUTED)
            draw_bars(td, 8, 24, tw - 16, th - 32, f, styles[k], sweep=len(f.state) if done else None, tile=True)
            canvas.paste(tile, ((t % cols) * tw, head + (t // cols) * th))
        images.append(canvas)
        durations.append(FRAME_MS)
    durations[0] = 600
    durations[-1] = 2600
    path = OUT / f"{key}.gif"
    _save(images, durations, path)
    return path


def main(argv=None):
    ap = argparse.ArgumentParser()
    ap.add_argument("names", nargs="*", help="algorithm names (default: all)")
    ap.add_argument("--races-only", action="store_true")
    args = ap.parse_args(argv)
    if not args.races_only:
        for name in args.names or list(ALGORITHMS):
            p = render(name)
            print(f"{p.name:34s} {p.stat().st_size / 1024:7.0f} KB", flush=True)
    if args.races_only or not args.names:
        for key in RACES:
            p = render_race(key)
            print(f"{p.name:34s} {p.stat().st_size / 1024:7.0f} KB", flush=True)


if __name__ == "__main__":
    sys.exit(main())
