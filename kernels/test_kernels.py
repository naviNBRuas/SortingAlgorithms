"""Run every kernel natively (they are plain Python) against sorted()."""
import importlib.util
import itertools
import os
import random
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
sys.path.insert(0, HERE)

SMALL = {"bogo_sort": 5, "bozo_sort": 5, "slow_sort": 12, "stooge_sort": 40, "permutation_sort": 6}
EXTRA = {"bogo_sort": (5_000_000,), "bozo_sort": (5_000_000,)}


def load(name):
    spec = importlib.util.spec_from_file_location(name, os.path.join(HERE, "algos", name + ".py"))
    mod = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(mod)
    return getattr(mod, name)


def names():
    return sorted(f[:-3] for f in os.listdir(os.path.join(HERE, "algos")) if f.endswith(".py"))


def check(name, only=None):
    f = load(name)
    cap = SMALL.get(name, 200)
    rng = random.Random(5)
    extra = EXTRA.get(name, ())
    cases = []
    for n in range(0, min(cap, 40) + 1):
        for lo, hi in ((-5, 9), (-1000000, 1000000), (0, 1)):
            cases.append([rng.randint(lo, hi) for _ in range(n)])
        cases.append(list(range(n)))
        cases.append(list(range(n, 0, -1)))
        cases.append([7] * n)
    if cap > 40:
        big = min(cap, 1500)
        cases.append([rng.randint(-50000, 50000) for _ in range(big)])
        cases.append(list(range(big)))
        cases.append(list(range(big, 0, -1)))
    cases.append([2147483647, -2147483648, 0, -1, 2147483647, -2147483648, 5, 5][: min(8, cap)])
    for c in cases:
        a = list(c)
        f(a, len(a), *extra)
        if a != sorted(c):
            return f"{name} FAILED on {c[:20]} -> {a[:20]}"
    return None


if __name__ == "__main__":
    bad = 0
    for nm in (sys.argv[1:] or names()):
        err = check(nm)
        print(("FAIL " + err) if err else f"ok   {nm}")
        bad += bool(err)
    sys.exit(1 if bad else 0)
