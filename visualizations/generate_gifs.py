"""Generate optimized, dark-themed animated GIFs for sorting traces."""

from pathlib import Path
from typing import List

import imageio.v2 as imageio
import matplotlib.pyplot as plt
import numpy as np

from sorting_algorithms import ALGORITHMS, SortTracer

# Optional per-algorithm keyword tweaks to keep visualization fast/reproducible
ALGO_KWARGS = {
    "bogo_sort": {"max_shuffles": 128, "seed": 0},
}

# Sample sizes per algorithm (len(sample)), tuned for runtime vs. clarity
DEFAULT_N = 80
SAMPLE_SIZE = {
    # Heavy / pathological
    "bogo_sort": 6,
    "stooge_sort": 12,
    "pancake_sort": 40,
    "bitonic_sort": 32,  # power-of-two friendly
    "cycle_sort": 40,
    "patience_sort": 60,
    "strand_sort": 60,
}

OUTPUT_DIR = Path(__file__).resolve().parent / "gifs"
OUTPUT_DIR.mkdir(parents=True, exist_ok=True)


def _sample_for(name: str) -> np.ndarray:
    rng = np.random.default_rng(0)
    n = SAMPLE_SIZE.get(name, DEFAULT_N)
    arr = rng.permutation(np.arange(-n // 2, n // 2))[:n]
    return arr


def _downsample_frames(frames, max_frames: int = 400):
    if len(frames) <= max_frames:
        return frames
    idx = np.linspace(0, len(frames) - 1, num=max_frames, dtype=int)
    return [frames[i] for i in idx]


def render_trace(frames, title: str, filename: Path, interval: float = 0.08, max_frames: int = 400):
    frames = _downsample_frames(frames, max_frames=max_frames)
    images: List = []

    for frame in frames:
        fig, ax = plt.subplots(figsize=(6, 4), facecolor="black")
        ax.set_facecolor("black")

        bars = ax.bar(
            range(len(frame.state)),
            frame.state,
            color="#7bdff2",
            edgecolor="none",
            width=0.9,
        )
        for idx in frame.highlights:
            if 0 <= idx < len(bars):
                bars[idx].set_color("#ff5c8a")

        ax.set_title(title, color="white", fontsize=12, pad=10)
        ax.set_xticks([])
        ax.set_yticks([])
        for spine in ax.spines.values():
            spine.set_visible(False)

        plt.tight_layout(pad=0.2)
        fig.canvas.draw()
        rgba = np.asarray(fig.canvas.buffer_rgba())
        image = rgba[:, :, :3].copy()  # drop alpha for GIFs
        images.append(image)
        plt.close(fig)

    imageio.mimsave(filename, images, duration=interval)


def generate_all():
    for name, func in ALGORITHMS.items():
        tracer = SortTracer(name)
        start_sample = _sample_for(name)
        tracer.record(start_sample, note="start")
        kwargs = ALGO_KWARGS.get(name, {})

        try:
            result = func(start_sample.copy(), tracer=tracer, **kwargs)
        except ValueError:
            continue
        except RuntimeError:
            if name == "bogo_sort":
                sorted_arr = sorted(start_sample)
                tracer.record(sorted_arr, note="sorted (fallback)")
                arr = sorted_arr
            else:
                continue
        else:
            if isinstance(result, tuple):
                arr, tracer = result
            else:
                arr = result

        if tracer and (len(tracer.frames) == 0 or tracer.frames[-1].note != "sorted"):
            tracer.record(arr, note="sorted")

        gif_path = OUTPUT_DIR / f"{name}.gif"
        render_trace(tracer.frames, name.replace("_", " ").title(), gif_path)
        print(f"Generated {gif_path}")


if __name__ == "__main__":
    generate_all()
