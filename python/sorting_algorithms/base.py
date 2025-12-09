from __future__ import annotations

from dataclasses import dataclass, field
from typing import List, Sequence, Tuple, Optional, Union

Number = Union[int, float]


@dataclass
class TraceFrame:
    state: List[Number]
    highlights: Tuple[int, ...] = field(default_factory=tuple)
    note: str = ""


class SortTracer:
    def __init__(self, name: str):
        self.name = name
        self.frames: List[TraceFrame] = []

    def __bool__(self) -> bool:  # pragma: no cover - truthiness should not depend on frame count
        return True

    def record(self, arr: Sequence[Number], highlights: Tuple[int, ...] = (), note: str = "") -> None:
        self.frames.append(TraceFrame(list(arr), tuple(highlights), note))

    def __len__(self) -> int:  # pragma: no cover - trivial
        return len(self.frames)

    def __iter__(self):  # pragma: no cover - trivial
        return iter(self.frames)


def _setup_tracer(name: str, trace: bool, tracer: Optional[SortTracer]):
    if tracer:
        return tracer, True
    if trace:
        return SortTracer(name), True
    return None, False


def _finalize(result: List[Number], tracer: Optional[SortTracer], should_return_trace: bool):
    if tracer:
        tracer.record(result, note="sorted")
    return (result, tracer) if should_return_trace else result
