import itertools
import random
from pathlib import Path

import pytest

import sorting_algorithms as sa
from sorting_algorithms import ALGORITHMS, REGISTRY, SortTracer, measure

SLOW_CAP = {"bogo_sort": 5, "bozo_sort": 5, "slow_sort": 12, "stooge_sort": 25}
NAMES = sorted(ALGORITHMS)
ROOT = Path(__file__).resolve().parents[2]


def sample(name, rng, n):
    n = min(n, SLOW_CAP.get(name, n))
    return [rng.randint(-5, 9) for _ in range(n)]


def test_registry_matches_exports():
    assert set(ALGORITHMS) == set(REGISTRY)
    assert len(ALGORITHMS) >= 48
    for name in ALGORITHMS:
        assert getattr(sa, name) is ALGORITHMS[name]


@pytest.mark.parametrize("name", NAMES)
def test_sorts_random_inputs(name):
    rng = random.Random(1234)
    for n in list(range(0, 20)) + [37, 64, 100]:
        data = sample(name, rng, n)
        original = list(data)
        assert ALGORITHMS[name](data) == sorted(original)
        assert data == original, "input must not be mutated"


@pytest.mark.parametrize("name", NAMES)
def test_structured_inputs(name):
    n = min(40, SLOW_CAP.get(name, 40))
    for data in ([3] * n, list(range(n)), list(range(n, 0, -1)), [1, 0] * (n // 2)):
        assert ALGORITHMS[name](data) == sorted(data)


@pytest.mark.parametrize("name", NAMES)
def test_trace_ends_sorted_and_counts_ops(name):
    rng = random.Random(7)
    data = sample(name, rng, 12)
    out, tracer = ALGORITHMS[name](data, trace=True)
    assert out == sorted(data)
    assert tracer.frames[0].note == "start" and tracer.frames[0].state == data
    assert tracer.frames[-1].note == "sorted" and tracer.frames[-1].state == sorted(data)
    result, stats = measure(name, data)
    assert result == sorted(data)
    assert stats.comparisons >= 0 and stats.writes >= 0


def test_external_tracer_is_used():
    tr = SortTracer("x")
    out, same = sa.bubble_sort([3, 1, 2], tracer=tr)
    assert same is tr and out == [1, 2, 3]


@pytest.mark.parametrize("name", [n for n in NAMES if REGISTRY[n].stable and REGISTRY[n].keys == "any"])
def test_declared_stable_algorithms_are_stable(name):
    class Item:
        def __init__(self, k, tag):
            self.k, self.tag = k, tag

        def __lt__(self, o): return self.k < o.k
        def __le__(self, o): return self.k <= o.k
        def __gt__(self, o): return self.k > o.k
        def __ge__(self, o): return self.k >= o.k
        def __eq__(self, o): return self.k == o.k
        __hash__ = None

    rng = random.Random(99)
    for _ in range(30):
        items = [Item(rng.randint(0, 5), i) for i in range(rng.randint(2, 40))]
        out = ALGORITHMS[name](items)
        assert [(x.k, x.tag) for x in out] == sorted(((x.k, x.tag) for x in items), key=lambda t: t[0])


@pytest.mark.parametrize("name", ["bitonic_sort", "odd_even_merge_sort"])
def test_networks_zero_one_principle(name):
    for n in range(1, 15):
        for bits in itertools.product([0, 1], repeat=n):
            assert ALGORITHMS[name](list(bits)) == sorted(bits)


def test_bogo_and_bozo_guardrails():
    with pytest.raises(RuntimeError):
        sa.bogo_sort([3, 2, 1], max_shuffles=0)
    with pytest.raises(RuntimeError):
        sa.bozo_sort([3, 2, 1], max_swaps=0)


def test_integer_only_algorithms_reject_other_types():
    with pytest.raises(TypeError):
        sa.counting_sort([1.5, 2.5])
    with pytest.raises(TypeError):
        sa.radix_sort_lsd(["a"])


def test_float_keys_for_number_algorithms():
    data = [0.5, -1.25, 3.0, 2.0, 0.0]
    assert sa.bucket_sort(data) == sorted(data)
    assert sa.flash_sort(data) == sorted(data)


def test_comparison_counts_are_sane():
    rng = random.Random(0)
    data = rng.sample(range(500), 500)
    _, merge = measure("merge_sort", data)
    _, bubble = measure("bubble_sort", data)
    assert merge.comparisons < 500 * 10
    assert bubble.comparisons > 50_000
    _, cyc = measure("cycle_sort", data)
    _, sel = measure("selection_sort", data)
    assert cyc.writes <= 500 + 5 and sel.writes <= 2 * 500


def test_registry_metadata_complete():
    for name, info in REGISTRY.items():
        assert info.title and info.summary and info.best and info.average and info.worst, name
        assert info.family in sa.FAMILIES


def test_every_algorithm_has_gif_in_readme():
    readme = (ROOT / "README.md").read_text()
    for name in REGISTRY:
        assert f"visualizations/gifs/{name}.gif" in readme, name
        assert (ROOT / "visualizations" / "gifs" / f"{name}.gif").exists(), name
