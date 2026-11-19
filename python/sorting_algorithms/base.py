"""Core machinery shared by every algorithm.

Each algorithm is written as plain, readable code against a :class:`Tracked`
array.  The array counts comparisons / reads / writes and, when a
:class:`SortTracer` is attached, records an animation frame for every
observable event.  Algorithms therefore contain no tracing boilerplate and the
numbers reported by the benchmarks are measured on exactly the code that is
animated.

Public entry points are produced by the :func:`algorithm` decorator, which
registers the implementation together with its metadata (complexity,
stability, family, history) in :data:`REGISTRY`.
"""
from __future__ import annotations

import sys
from dataclasses import dataclass, field
from typing import Any, Callable, Dict, List, Optional, Sequence, Tuple, Union

Number = Union[int, float]

__all__ = [
    "Number",
    "TraceFrame",
    "SortTracer",
    "Stats",
    "Tracked",
    "AlgoInfo",
    "REGISTRY",
    "ALGORITHMS",
    "algorithm",
    "measure",
]


# --------------------------------------------------------------------------- #
# Trace data structures
# --------------------------------------------------------------------------- #
@dataclass
class TraceFrame:
    """One animation frame: array state plus what just happened to it."""

    state: List[Any]
    highlights: Tuple[int, ...] = field(default_factory=tuple)
    note: str = ""
    comparisons: int = 0
    writes: int = 0
    # --- optional presentation metadata used by the GIF renderer ---------------------------------
    focus: Optional[Tuple[int, int]] = None          # active sub-range (inclusive); everything else is dimmed
    done: Tuple[Tuple[int, int], ...] = ()           # ranges known to be in their final position
    pivot: Optional[int] = None                      # index of the pivot / current minimum / key being placed
    label: str = ""                                  # short phase caption, e.g. "gap = 5"
    aux: Optional[List[int]] = None                  # auxiliary structure (counts, bucket sizes, pile heights, ...)
    aux_label: str = ""
    aux_hl: Tuple[int, ...] = ()


class SortTracer:
    """Collects :class:`TraceFrame` objects.

    ``max_frames`` bounds memory for pathological runs; once reached, further
    frames are dropped except the terminating ``"sorted"`` frame.
    """

    def __init__(self, name: str = "", max_frames: int = 200_000):
        self.name = name
        self.max_frames = max_frames
        self.frames: List[TraceFrame] = []
        self.truncated = False

    def __bool__(self) -> bool:  # truthiness must not depend on frame count
        return True

    def record(
        self,
        arr: Sequence[Any],
        highlights: Tuple[int, ...] = (),
        note: str = "",
        comparisons: int = 0,
        writes: int = 0,
        **extra,
    ) -> None:
        if len(self.frames) >= self.max_frames and note != "sorted":
            self.truncated = True
            return
        self.frames.append(TraceFrame(list(arr), tuple(highlights), note, comparisons, writes, **extra))

    def __len__(self) -> int:
        return len(self.frames)

    def __iter__(self):
        return iter(self.frames)


@dataclass
class Stats:
    comparisons: int = 0
    reads: int = 0
    writes: int = 0

    @property
    def operations(self) -> int:
        return self.comparisons + self.writes


# --------------------------------------------------------------------------- #
# Instrumented containers
# --------------------------------------------------------------------------- #
class _Key:
    """Wraps an element so every comparison is counted (and can emit a frame)."""

    __slots__ = ("v", "t")

    def __init__(self, v: Any, t: "Tracked"):
        self.v = v
        self.t = t

    def __lt__(self, o: "_Key") -> bool:
        self.t._compare()
        return self.v < o.v

    def __le__(self, o: "_Key") -> bool:
        self.t._compare()
        return self.v <= o.v

    def __gt__(self, o: "_Key") -> bool:
        self.t._compare()
        return self.v > o.v

    def __ge__(self, o: "_Key") -> bool:
        self.t._compare()
        return self.v >= o.v

    def __eq__(self, o: object) -> bool:  # type: ignore[override]
        self.t._compare()
        return self.v == o.v  # type: ignore[attr-defined]

    __hash__ = None  # type: ignore[assignment]

    def __repr__(self) -> str:  # pragma: no cover - debugging aid
        return f"Key({self.v!r})"


class Tracked:
    """List-like array that counts operations and records frames.

    ``raw=True`` stores plain numbers (used by distribution sorts, which look at
    key *values* rather than comparing elements); comparisons are then not
    counted because none are performed.
    """

    def __init__(self, data: Sequence[Any], tracer: Optional[SortTracer] = None, raw: bool = False):
        self.tracer = tracer
        self.raw = raw
        self.stats = Stats()
        self._recent: Tuple[int, ...] = ()
        self.items: List[Any] = list(data) if raw else [_Key(x, self) for x in data]
        # presentation hints (cheap attribute writes; only read when a tracer is attached)
        self.focus: Optional[Tuple[int, int]] = None
        self.done: Tuple[Tuple[int, int], ...] = ()
        self.pivot: Optional[int] = None
        self.label: str = ""
        self.aux: Optional[List[int]] = None
        self.aux_label: str = ""
        self.aux_hl: Tuple[int, ...] = ()

    # -- basic container protocol ------------------------------------------
    def __len__(self) -> int:
        return len(self.items)

    def __getitem__(self, i: int):
        self.stats.reads += 1
        if self.tracer is not None:
            self._recent = (self._recent[-1], i) if self._recent else (i,)
        return self.items[i]

    def __setitem__(self, i: int, v: Any) -> None:
        self.stats.writes += 1
        self.items[i] = v
        self._frame((i,), "write")

    def swap(self, i: int, j: int) -> None:
        if i == j:
            return
        self.stats.writes += 2
        self.items[i], self.items[j] = self.items[j], self.items[i]
        self._frame((i, j), "swap")

    # -- helpers for out-of-place algorithms -------------------------------
    def values(self) -> List[Any]:
        """Current contents as plain values (no counting)."""
        return [x if self.raw else x.v for x in self.items]

    def wrap(self, v: Any) -> Any:
        """Wrap a plain value so it can be stored in this array (non-raw mode)."""
        return v if self.raw else _Key(v, self)

    def show(self, view: Sequence[Any], highlights: Tuple[int, ...] = (), note: str = "") -> None:
        """Emit a frame for an auxiliary view without touching the array."""
        if self.tracer is not None:
            self._recent = ()
            self.tracer.record(
                [x.v if isinstance(x, _Key) else x for x in view],
                highlights,
                note,
                self.stats.comparisons,
                self.stats.writes,
                **self._extra(),
            )

    def commit(self, values: Sequence[Any], note: str = "commit") -> None:
        """Overwrite the whole array from ``values`` (counts ``len`` writes)."""
        for i, v in enumerate(values):
            self.items[i] = v
        self.stats.writes += len(values)
        self._frame((), note)

    def mark(self, highlights: Tuple[int, ...] = (), note: str = "") -> None:
        self._frame(tuple(highlights), note)

    def set_aux(self, values: Optional[Sequence[int]], label: str = "", hl: Tuple[int, ...] = ()) -> None:
        """Attach an auxiliary structure to subsequent frames (None removes the panel)."""
        self.aux = None if values is None else list(values)
        self.aux_label = label
        self.aux_hl = tuple(hl)

    def _extra(self) -> dict:
        return dict(focus=self.focus, done=self.done, pivot=self.pivot, label=self.label,
                    aux=None if self.aux is None else list(self.aux), aux_label=self.aux_label, aux_hl=self.aux_hl)

    # -- internals -----------------------------------------------------------
    def _compare(self) -> None:
        self.stats.comparisons += 1
        if self.tracer is not None and self._recent:
            hl = self._recent
            self._recent = ()
            self.tracer.record(self.values(), hl, "compare", self.stats.comparisons, self.stats.writes, **self._extra())

    def _frame(self, hl: Tuple[int, ...], note: str) -> None:
        if self.tracer is not None:
            self._recent = ()
            self.tracer.record(self.values(), hl, note, self.stats.comparisons, self.stats.writes, **self._extra())


# --------------------------------------------------------------------------- #
# Registry
# --------------------------------------------------------------------------- #
@dataclass(frozen=True)
class AlgoInfo:
    name: str
    title: str
    family: str
    best: str
    average: str
    worst: str
    space: str
    stable: bool
    in_place: bool
    summary: str
    history: str = ""
    keys: str = "any"  # "any" (comparable), "number", or "int"
    viz_n: int = 64
    viz_kwargs: Dict[str, Any] = field(default_factory=dict)
    bench_max_n: Optional[int] = None  # largest n the benchmark suite will try
    bench_kwargs: Dict[str, Any] = field(default_factory=dict)
    adaptive: bool = False


REGISTRY: Dict[str, AlgoInfo] = {}
ALGORITHMS: Dict[str, Callable] = {}

FAMILIES = [
    "Exchange",
    "Selection",
    "Insertion",
    "Merge",
    "Hybrid",
    "Distribution",
    "Network",
    "Probabilistic",
]


def _check_keys(info: AlgoInfo, data: Sequence[Any]) -> None:
    if info.keys == "int":
        for x in data:
            if not isinstance(x, int):
                raise TypeError(f"{info.name} requires integer keys, got {type(x).__name__}")
    elif info.keys == "number":
        for x in data:
            if not isinstance(x, (int, float)):
                raise TypeError(f"{info.name} requires numeric keys, got {type(x).__name__}")


def _execute(info: AlgoInfo, impl: Callable, data: Sequence[Any], tracer: Optional[SortTracer], kw: Dict[str, Any]):
    _check_keys(info, data)
    arr = Tracked(data, tracer, raw=info.keys != "any")
    if tracer is not None:
        tracer.record(arr.values(), (), "start")
    old_limit = sys.getrecursionlimit()
    needed = 4 * len(arr) + 1000
    if needed > old_limit:
        sys.setrecursionlimit(needed)
    try:
        impl(arr, **kw)
    finally:
        sys.setrecursionlimit(old_limit)
    out = arr.values()
    if tracer is not None:
        tracer.record(out, (), "sorted", arr.stats.comparisons, arr.stats.writes, done=((0, len(out) - 1),) if out else ())
    return out, arr.stats


def algorithm(
    name: str,
    title: str,
    family: str,
    best: str,
    average: str,
    worst: str,
    space: str,
    stable: bool,
    in_place: bool,
    summary: str,
    history: str = "",
    keys: str = "any",
    viz_n: int = 64,
    viz_kwargs: Optional[Dict[str, Any]] = None,
    bench_max_n: Optional[int] = None,
    bench_kwargs: Optional[Dict[str, Any]] = None,
    adaptive: bool = False,
):
    """Register ``impl(a: Tracked, **kw)`` and expose it as a public sort function.

    The public function has the signature
    ``fn(data, *, trace=False, tracer=None, **kw)``.  It never mutates ``data``;
    it returns the sorted list, or ``(sorted_list, tracer)`` when tracing.
    """
    if family not in FAMILIES:
        raise ValueError(f"unknown family {family!r}")

    info = AlgoInfo(
        name, title, family, best, average, worst, space, stable, in_place, summary, history,
        keys, viz_n, viz_kwargs or {}, bench_max_n, bench_kwargs or {}, adaptive,
    )

    def decorate(impl: Callable) -> Callable:
        def public(data: Sequence[Any], *, trace: bool = False, tracer: Optional[SortTracer] = None, **kw):
            use = tracer if tracer is not None else (SortTracer(name) if trace else None)
            out, _ = _execute(info, impl, data, use, kw)
            return (out, use) if use is not None else out

        def with_stats(data: Sequence[Any], **kw) -> Tuple[List[Any], Stats]:
            return _execute(info, impl, data, None, kw)

        public.__name__ = name
        public.__qualname__ = name
        public.__doc__ = f"{title}: {summary}"
        public.with_stats = with_stats  # type: ignore[attr-defined]
        public.info = info  # type: ignore[attr-defined]
        if name in REGISTRY:
            raise ValueError(f"duplicate algorithm {name!r}")
        REGISTRY[name] = info
        ALGORITHMS[name] = public
        return public

    return decorate


def measure(name: str, data: Sequence[Any], **kw) -> Tuple[List[Any], Stats]:
    """Run ``name`` on ``data`` without tracing; return ``(result, Stats)``."""
    kw = {**REGISTRY[name].bench_kwargs, **kw}
    return ALGORITHMS[name].with_stats(data, **kw)  # type: ignore[attr-defined]
