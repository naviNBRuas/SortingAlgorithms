# COBOL sorts (GnuCOBOL)

56 programs, one `.cob` file per algorithm, free-format source for [GnuCOBOL](https://gnucobol.sourceforge.io) 3.x.
Each file holds the algorithm's entry program (`PROGRAM-ID. bubble-sort`) and its helper programs; all are `RECURSIVE`.

```cobol
CALL "bubble-sort" USING BY REFERENCE tbl BY VALUE n
```

`tbl` is a table of `USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES` (signed 32-bit integers) and `n` a `BINARY-DOUBLE SIGNED`.
`bogo-sort` / `bozo-sort` take a third `BY VALUE` argument (attempt budget).

```sh
cd cobol && make test        # cobc -x -free test.cob *.cob && ./test_runner
```

## Status: generated, **not yet compiled**

These files are produced by `kernels/backends/cobol.py` from the same verified kernels as every other language, but the
environment that generated them had no COBOL compiler, so they have **not been compiled or run**. Expect that a first
`make test` may surface syntax or runtime-semantics issues in the generator (not in the algorithms, which are verified in the
kernels). CI has a job that installs GnuCOBOL and runs the suite.

Limits of this edition: tables are fixed-capacity (65,536 elements), so `n` must stay below that; the wide-range fallbacks in
counting/pigeonhole/sleep sorts trigger at a key range of 60,000 (instead of 4,000,000 elsewhere).
