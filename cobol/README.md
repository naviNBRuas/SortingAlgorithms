# COBOL sorts (GnuCOBOL)

56 programs, one `.cob` file per algorithm, free-format source for [GnuCOBOL](https://gnucobol.sourceforge.io) 3.x.
Each file holds the algorithm's entry program (`PROGRAM-ID. bubble-sort`) and its helper programs; all are `RECURSIVE`.

```cobol
CALL "bubble-sort" USING BY REFERENCE tbl BY CONTENT n
```

`tbl` is a table of `USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES` (signed 32-bit integers) and `n` a `BINARY-DOUBLE SIGNED`.
`bogo-sort` / `bozo-sort` take a third `BY CONTENT` argument (attempt budget), also an 8-byte item.

```sh
cd cobol && make test        # cobc -x -free test.cob *.cob && ./test_runner
```

## Status: verified

All 56 programs compile cleanly and pass `make test` with **GnuCOBOL 3.2.0**, including a run built with `-debug` (runtime
subscript and argument-size checks). The test driver checks every sort against a reference insertion sort on random,
sorted, reversed and all-equal inputs of many lengths.

Notes on the COBOL calling convention used (found by testing): integers are passed `BY CONTENT` as 8-byte data items (never
literals, which are only 4 bytes), arrays `BY REFERENCE`, and results come back through a trailing output parameter, because
`PROCEDURE DIVISION RETURNING` is not fully implemented in 3.2. Program names are limited to 31 characters, so helper programs
are named `<stem initials><3-hex hash>-<helper>`.

Limits of this edition: tables are fixed-capacity (65,536 elements), so `n` must stay below that; the wide-range fallbacks in
counting/pigeonhole/sleep sorts trigger at a key range of 60,000 (instead of 4,000,000 elsewhere).
