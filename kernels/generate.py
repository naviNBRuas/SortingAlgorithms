"""Transpile every kernel in kernels/algos/ into C, C++, Java, Go and Rust (plus tests).

    python kernels/generate.py            # regenerate c/ cpp/ java/ go/ rust/
    python kernels/generate.py --check    # exit 1 if generated files differ from what is on disk

The kernels are the single source of truth: each is verified natively in Python
(kernels/test_kernels.py), then translated mechanically, so every language runs the same algorithm.
"""
from __future__ import annotations

import os
import subprocess
import sys

sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))
import ir  # noqa: E402
from backends.clike import C, CPP, Go, Java, Rust  # noqa: E402
from backends.x86 import compile_kernel  # noqa: E402
from backends.cobol import compile_kernel as compile_cobol  # noqa: E402

# The 28 original algorithms have hand-written assembly in assembly/<stem>.s; the rest are compiled from kernels.
HAND_ASM = {
    "bubble_sort", "selection_sort", "insertion_sort", "binary_insertion_sort", "shell_sort", "comb_sort", "cocktail_shaker_sort",
    "odd_even_sort", "gnome_sort", "cycle_sort", "pancake_sort", "stooge_sort", "bitonic_sort", "merge_sort", "quick_sort",
    "heap_sort", "counting_sort", "pigeonhole_sort", "radix_sort_lsd", "bucket_sort", "bead_sort", "tree_sort", "patience_sort",
    "strand_sort", "tim_sort", "intro_sort", "smooth_sort", "bogo_sort",
}

ROOT = os.path.dirname(ir.HERE)
BANNER = "GENERATED from kernels/algos/{stem}.py by kernels/generate.py - do not edit; edit the kernel and regenerate."

# test-size caps for super-polynomial algorithms, and default values for their extra parameters
CAP = {"bogo_sort": 5, "bozo_sort": 5, "slow_sort": 12, "stooge_sort": 40, "permutation_sort": 6}
EXTRA_DEFAULT = 5_000_000

# Cross-language speed benchmark: same deterministic data (LCG, values 0..9999) and sizes everywhere.
BENCH_SKIP = {"bogo_sort", "bozo_sort", "permutation_sort"}          # cost is random / factorial
BENCH_N = {"stooge_sort": 200, "slow_sort": 16}                        # super-polynomial: smaller n
BENCH_DEFAULT_N = 1000

written: dict[str, str] = {}


def put(path: str, text: str):
    written[os.path.join(ROOT, path)] = text


def camel(stem: str) -> str:
    return "".join(p[:1].upper() + p[1:] for p in stem.split("_"))


def build():
    stems = ir.stems()
    meta = []  # (stem, extras)
    for stem in stems:
        fns, entry, extras = ir.load(stem)
        fnmap = {f.raw: f.name for f in fns}
        meta.append((stem, extras))
        ex_sig_c = "".join(f", size_t {e}" for e in extras)
        ex_call = "".join(f", (int64_t){e}" for e in extras)

        # ---------------- C ----------------
        g = C(fnmap)
        lines = [f"/* {BANNER.format(stem=stem)} */", '#include "../sorting_algorithms.h"', "#include <stdint.h>", "#include <stdlib.h>",
                 "static inline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }",
                 "static inline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }", ""]
        lines += [g.proto(f) for f in fns] + [""]
        for f in fns:
            lines += g.emit_fn(f) + [""]
        lines += [f"void {stem}(int *arr, size_t n{ex_sig_c}) {{", f"    {entry.name}((int32_t *)arr, (int64_t)n{ex_call});", "}", ""]
        put(f"c/src/{stem}.c", "\n".join(lines))

        # ---------------- C++ ----------------
        g = CPP(fnmap)
        lines = [f"// {BANNER.format(stem=stem)}", "#pragma once", "#include <algorithm>", "#include <cstddef>", "#include <cstdint>", "#include <vector>",
                 '#include "common.hpp"', "namespace sorting {", "namespace detail {", ""]
        lines += [g.proto(f).replace("static ", "inline ", 1) if False else g.fn_open(f)[:-2] + ";" for f in fns] + [""]
        for f in fns:
            lines += g.emit_fn(f) + [""]
        lines += ["}  // namespace detail", ""]
        ex_sig = "".join(f", int64_t {e}" for e in extras)
        ex_cl = "".join(f", {e}" for e in extras)
        lines += [f"inline void {stem}(std::vector<int>& v{ex_sig}) {{",
                  f"    detail::{entry.name}(reinterpret_cast<int32_t*>(v.data()), static_cast<int64_t>(v.size()){ex_cl});", "}",
                  "}  // namespace sorting", ""]
        # qualify detail:: calls inside detail namespace is unnecessary (same namespace)
        put(f"cpp/include/sorting/{stem}.hpp", "\n".join(lines))

        # ---------------- Java ----------------
        g = Java(fnmap)
        cls = camel(stem)
        lines = [f"// {BANNER.format(stem=stem)}", "package sorting;", "", f"public final class {cls} {{", f"    private {cls}() {{}}", ""]
        for f in fns:
            body = g.emit_fn(f)
            lines += ["    " + l if i else l for i, l in enumerate(body)]
            lines.append("")
        ex_sig = "".join(f", long {e}" for e in extras)
        ex_cl = "".join(f", {e}" for e in extras)
        lines += [f"    public static void sort(int[] a{ex_sig}) {{", f"        {entry.name}(a, a.length{ex_cl});", "    }", "}", ""]
        put(f"java/src/sorting/{cls}.java", "\n".join(_java_indent(lines)))

        # ---------------- Go ----------------
        g = Go(fnmap)
        lines = [f"// {BANNER.format(stem=stem)}", "", "package algorithms", "",
                 "func k_min(a, b int64) int64 {\n\tif a < b {\n\t\treturn a\n\t}\n\treturn b\n}",
                 "func k_max(a, b int64) int64 {\n\tif a > b {\n\t\treturn a\n\t}\n\treturn b\n}", ""]
        for f in fns:
            lines += g.emit_fn(f) + [""]
        ex_sig = "".join(f", {e} int64" for e in extras)
        ex_cl = "".join(f", {e}" for e in extras)
        lines += [f"// {camel(stem)} sorts a in place.", f"func {camel(stem)}(a []int{ex_sig}) {{", f"\t{entry.name}(a, int64(len(a)){ex_cl})", "}", ""]
        # Go helpers k_min/k_max must exist once per package: emit them in a shared file instead
        lines = [l for l in lines if not l.startswith("func k_m")]
        put(f"go/algorithms/{stem}.go", "\n".join(lines))

        # ---------------- x86-64 (compiled kernels, for algorithms without hand-written assembly) ----------------
        if stem not in HAND_ASM:
            put(f"assembly/generated/{stem}.s", compile_kernel(stem, fns, entry, BANNER.format(stem=stem) + " (compiler output, not hand-written)"))

        # ---------------- COBOL (unverified: no COBOL compiler available when generated) ----------------
        put(f"cobol/{stem}.cob", compile_cobol(stem, fns, entry, BANNER.format(stem=stem)))

        # ---------------- Rust ----------------
        g = Rust(fnmap)
        lines = [f"// {BANNER.format(stem=stem)}", ""]
        for f in fns:
            lines += g.emit_fn(f, public=False) + [""]
        ex_sig = "".join(f", {e}: i64" for e in extras)
        ex_cl = "".join(f", {e}" for e in extras)
        lines += [f"pub fn {stem}(a: &mut [i32]{ex_sig}) {{", f"    {entry.name}(a, a.len() as i64{ex_cl});", "}", ""]
        put(f"rust/src/{stem}.rs", "\n".join(lines))

    emit_support(meta)


def _java_indent(lines):
    # the Java emitter produced method bodies with 4-space indent relative to method; indent whole file consistently
    out = []
    for l in lines:
        out.append(l)
    return out


def emit_support(meta):
    stems = [m[0] for m in meta]
    # ---- C header + Makefile pieces
    hdr = ["#ifndef SORTING_ALGORITHMS_H", "#define SORTING_ALGORITHMS_H", "", "/* GENERATED by kernels/generate.py */", "#include <stddef.h>", ""]
    for stem, extras in meta:
        hdr.append(f"void {stem}(int *arr, size_t n{''.join(f', size_t {e}' for e in extras)});")
    hdr += ["", "#endif /* SORTING_ALGORITHMS_H */", ""]
    put("c/sorting_algorithms.h", "\n".join(hdr))

    put("cpp/include/sorting/common.hpp", "// GENERATED by kernels/generate.py\n#pragma once\n#include <cstdint>\nnamespace sorting {\nnamespace detail {\ninline int64_t k_min(int64_t a, int64_t b) { return a < b ? a : b; }\ninline int64_t k_max(int64_t a, int64_t b) { return a > b ? a : b; }\n}  // namespace detail\n}  // namespace sorting\n")

    # ---- Go shared helpers
    put("go/algorithms/helpers.go", "package algorithms\n\nfunc k_min(a, b int64) int64 {\n\tif a < b {\n\t\treturn a\n\t}\n\treturn b\n}\n\nfunc k_max(a, b int64) int64 {\n\tif a > b {\n\t\treturn a\n\t}\n\treturn b\n}\n")

    # ---- test drivers (same cases everywhere)
    def entry_call(stem, extras, fmt):
        return fmt(stem, [EXTRA_DEFAULT for _ in extras])

    # C
    rows = []
    for stem, extras in meta:
        if extras:
            rows.append(f"static void t_{stem}(int *a, size_t n) {{ {stem}(a, n{''.join(', ' + str(EXTRA_DEFAULT) for _ in extras)}); }}")
            rows_ref = f"t_{stem}"
        else:
            rows_ref = stem
    tbl = []
    wrappers = []
    for stem, extras in meta:
        if extras:
            wrappers.append(f"static void t_{stem}(int *a, size_t n) {{ {stem}(a, n{''.join(', ' + str(EXTRA_DEFAULT) for _ in extras)}); }}")
            tbl.append(f'    {{"{stem}", t_{stem}, {CAP.get(stem, 0)}}},')
        else:
            tbl.append(f'    {{"{stem}", {stem}, {CAP.get(stem, 0)}}},')
    put("c/test.c", C_TEST.replace("@WRAPPERS@", "\n".join(wrappers)).replace("@TABLE@", "\n".join(tbl)))

    # x86-64 assembly: link-level harness (calls the *_asm symbols directly) and libc-free check
    decls, wrappers, tbl = [], [], []
    for stem, extras in meta:
        sig = ", size_t" * len(extras)
        decls.append(f"void {stem}_asm(int *, size_t{sig});")
        if extras:
            wrappers.append(f"static void t_{stem}(int *a, size_t n) {{ {stem}_asm(a, n{''.join(', ' + str(EXTRA_DEFAULT) for _ in extras)}); }}")
            tbl.append(f'    {{"{stem}", t_{stem}, {CAP.get(stem, 0)}}},')
        else:
            tbl.append(f'    {{"{stem}", {stem}_asm, {CAP.get(stem, 0)}}},')
    t = C_TEST.replace('#include "sorting_algorithms.h"\n', "#include <stddef.h>\n" + "\n".join(decls) + "\n").replace("@WRAPPERS@", "\n".join(wrappers)).replace("@TABLE@", "\n".join(tbl))
    t = t.replace("exercises every C sort against qsort()", "exercises every assembly sort against qsort()").replace("all C sorts ok", "all assembly sorts ok")
    put("assembly/test.c", t)
    put("assembly/freestanding.c", FREESTANDING.replace("@DECLS@", "\n".join(decls)).replace("@WRAPPERS@", "\n".join(wrappers)).replace("@TABLE@", "\n".join(tbl)))

    # machine code: table of images + loader test
    rows = "\n".join(f'    {{"{st}", {CAP.get(st, 0)}, {len(ex)}}},' for st, ex in meta)
    put("machine-code/table.h", "/* GENERATED by kernels/generate.py: name, size cap (0 = none), number of extra arguments */\n" + rows + "\n")
    put("machine-code/test.c", MC_TEST)

    # COBOL test driver
    names = [m[0] for m in meta]
    calls = []
    caps = []
    for i, (stem, extras) in enumerate(meta, 1):
        extra = "".join(" BY CONTENT ws-extra" for _ in extras)
        calls.append(f"        WHEN {i}\n            CALL \"{stem.replace('_', '-')}\" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz{extra}")
        caps.append(f"        WHEN {i} MOVE {CAP.get(stem, 0)} TO ws-cap")
    put("cobol/test.cob", COBOL_TEST.replace("@N@", str(len(meta))).replace("@CALLS@", "\n".join(calls)).replace("@CAPS@", "\n".join(caps)))

    # ---- speed benchmark drivers (one per edition) ----
    bench = [(st, BENCH_N.get(st, BENCH_DEFAULT_N)) for st, _ in meta if st not in BENCH_SKIP]
    ctbl = "\n".join(f'    {{"{st}", {st}, {n}}},' for st, n in bench)
    cdecl = "\n".join(f"void {st}(int *, size_t);" for st, _ in bench)
    put("c/bench.c", C_BENCH.replace("@DECLS@", cdecl).replace("@TABLE@", ctbl))
    atbl = "\n".join(f'    {{"{st}", {st}_asm, {n}}},' for st, n in bench)
    adecl = "\n".join(f"void {st}_asm(int *, size_t);" for st, _ in bench)
    put("assembly/bench.c", C_BENCH.replace("@DECLS@", adecl).replace("@TABLE@", atbl))
    put("machine-code/bench.c", MC_BENCH.replace("@TABLE@", "\n".join(f'    {{"{st}", {n}}},' for st, n in bench)))
    put("cpp/tests/bench.cpp", CPP_BENCH.replace("@INCLUDES@", "\n".join(f'#include "sorting/{st}.hpp"' for st, _ in bench)).replace("@TABLE@", "\n".join(f'    {{"{st}", {n}, [](std::vector<int>& v) {{ sorting::{st}(v); }}}},' for st, n in bench)))
    put("java/src/sorting/Bench.java", JAVA_BENCH.replace("@TABLE@", "\n".join(f'        add("{st}", {n}, a -> {camel(st)}.sort(a));' for st, n in bench)))
    put("go/cmd/bench/main.go", GO_BENCH.replace("@TABLE@", "\n".join(f'\t{{"{st}", {n}, algorithms.{camel(st)}}},' for st, n in bench)))
    put("rust/src/bench.rs", RUST_BENCH.replace("@TABLE@", "\n".join(f'        ("{st}", {n}, Box::new(|a: &mut [i32]| {st}(a))),' for st, n in bench)))
    put("cobol/bench.cob", COBOL_BENCH.replace("@CALLS@", "\n".join(f'        WHEN {i}\n            MOVE {n} TO ws-nsz\n            PERFORM fill-data\n            CALL "{st.replace("_", "-")}" USING BY REFERENCE ws-tbl BY CONTENT ws-nsz' for i, (st, n) in enumerate(bench, 1))).replace("@NAMES@", "\n".join(f'        WHEN {i} DISPLAY "{st} {n}" WITH NO ADVANCING' for i, (st, n) in enumerate(bench, 1))))
    put("benchmarks/algorithms.txt", "\n".join(f"{st} {n}" for st, n in bench))

    # C++
    tbl = []
    for stem, extras in meta:
        call = f"sorting::{stem}(v{''.join(', ' + str(EXTRA_DEFAULT) for _ in extras)});"
        tbl.append(f'    {{"{stem}", [](std::vector<int>& v) {{ {call} }}, {CAP.get(stem, 0)}}},')
    inc = "\n".join(f'#include "sorting/{s}.hpp"' for s in stems)
    put("cpp/tests/tests.cpp", CPP_TEST.replace("@INCLUDES@", inc).replace("@TABLE@", "\n".join(tbl)))
    put("cpp/include/sorting/all.hpp", "// GENERATED by kernels/generate.py\n#pragma once\n" + inc.replace('"sorting/', '"') + "\n")

    # Java
    tbl = []
    for stem, extras in meta:
        args = "".join(f", {EXTRA_DEFAULT}L" for _ in extras)
        tbl.append(f'        add("{stem}", a -> {camel(stem)}.sort(a{args}), {CAP.get(stem, 0)});')
    put("java/src/sorting/Tests.java", JAVA_TEST.replace("@TABLE@", "\n".join(tbl)))

    # Go
    tbl = []
    for stem, extras in meta:
        args = "".join(f", {EXTRA_DEFAULT}" for _ in extras)
        tbl.append(f'\t{{"{stem}", func(a []int) {{ {camel(stem)}(a{args}) }}, {CAP.get(stem, 0)}}},')
    put("go/algorithms/sort_test.go", GO_TEST.replace("@TABLE@", "\n".join(tbl)))
    demo = "\n".join(f'\t\t{{"{s}", func(a []int) {{ algorithms.{camel(s)}(a{"".join(", " + str(EXTRA_DEFAULT) for _ in e)}) }}}},' for s, e in meta)
    put("go/cmd/main.go", GO_MAIN.replace("@TABLE@", demo))

    # Rust
    mods = "\n".join(f"pub mod {s};" for s in stems)
    uses = "\n".join(f"pub use {s}::{s};" for s in stems)
    put("rust/src/lib.rs", f"// GENERATED by kernels/generate.py\n#![allow(warnings)]\n{mods}\n\n{uses}\n")
    tbl = []
    for stem, extras in meta:
        args = "".join(f", {EXTRA_DEFAULT}" for _ in extras)
        tbl.append(f'        ("{stem}", Box::new(|a: &mut Vec<i32>| {stem}(a{args})), {CAP.get(stem, 0)}),')
    put("rust/tests/sorts.rs", RUST_TEST.replace("@TABLE@", "\n".join(tbl)))
    put("rust/src/main.rs", RUST_MAIN.replace("@TABLE@", "\n".join(t.replace("        (", "        (", 1) for t in tbl)))


# --------------------------------------------------------------------------------------
FREESTANDING = r'''/* GENERATED by kernels/generate.py. Links the assembly sorts with NO libc (-nostdlib -static): proves they
 * depend on nothing but the Linux kernel ABI. Exit status 0 = every sort produced sorted output. */
typedef unsigned long size_t;
typedef void (*sort_fn)(int *, size_t);
@DECLS@
@WRAPPERS@
static const struct { const char *name; sort_fn f; size_t cap; } table[] = {
@TABLE@
};

static unsigned long long rs = 88172645463325252ULL;
static unsigned rnd(void) { rs ^= rs << 13; rs ^= rs >> 7; rs ^= rs << 17; return (unsigned)(rs >> 11); }

static void say(const char *s) {
    size_t n = 0;
    while (s[n]) ++n;
    long r;
    __asm__ volatile("syscall" : "=a"(r) : "0"(1L), "D"(1L), "S"(s), "d"(n) : "rcx", "r11", "memory");
}

static void number(unsigned v) {
    char buf[16]; int i = 15; buf[i] = 0;
    do { buf[--i] = '0' + v % 10; v /= 10; } while (v);
    say(buf + i);
}

void c_start(void) {
    int bad = 0;
    size_t count = sizeof table / sizeof table[0];
    for (size_t k = 0; k < count; ++k) {
        int a[200];
        size_t n = table[k].cap ? table[k].cap : 200;
        for (size_t i = 0; i < n; ++i) a[i] = (int)(rnd() % 2001) - 1000;
        table[k].f(a, n);
        for (size_t i = 1; i < n; ++i) if (a[i - 1] > a[i]) { bad = 1; say("FAIL "); say(table[k].name); say("\n"); break; }
    }
    if (bad) say("freestanding: FAIL\n"); else { say("freestanding: all "); number((unsigned)count); say(" sorts ok without libc\n"); }
    long r;
    __asm__ volatile("syscall" : "=a"(r) : "0"(60L), "D"((long)bad) : "rcx", "r11", "memory");
    for (;;) {}
}

__asm__(".globl _start\n_start:\n  xor %ebp,%ebp\n  and $-16,%rsp\n  call c_start\n");
'''

COBOL_TEST = r'''>>SOURCE FORMAT FREE
      *> GENERATED by kernels/generate.py - runs every COBOL sort against a reference insertion sort.
IDENTIFICATION DIVISION.
PROGRAM-ID. cobol-sort-tests.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 ws-tbl.
    05 ws-tbl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 ws-ref.
    05 ws-ref-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 ws-algo USAGE BINARY-DOUBLE SIGNED.
01 ws-sz USAGE BINARY-DOUBLE SIGNED.
01 ws-mode USAGE BINARY-DOUBLE SIGNED.
01 ws-nsz USAGE BINARY-DOUBLE SIGNED.
01 ws-cap USAGE BINARY-DOUBLE SIGNED.
01 ws-i USAGE BINARY-DOUBLE SIGNED.
01 ws-j USAGE BINARY-DOUBLE SIGNED.
01 ws-state USAGE BINARY-DOUBLE SIGNED VALUE 12345.
01 ws-r USAGE BINARY-DOUBLE SIGNED.
01 ws-key USAGE BINARY-DOUBLE SIGNED.
01 ws-fails USAGE BINARY-DOUBLE SIGNED VALUE 0.
01 ws-extra USAGE BINARY-DOUBLE SIGNED VALUE 5000000.
01 ws-bad USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION.
main-para.
    PERFORM VARYING ws-algo FROM 1 BY 1 UNTIL ws-algo > @N@
        PERFORM set-cap
        PERFORM VARYING ws-sz FROM 1 BY 1 UNTIL ws-sz > 14
            PERFORM set-size
            IF ws-cap = 0 OR ws-nsz <= ws-cap
                PERFORM VARYING ws-mode FROM 0 BY 1 UNTIL ws-mode > 4
                    PERFORM run-case
                END-PERFORM
            END-IF
        END-PERFORM
    END-PERFORM
    IF ws-fails = 0
        DISPLAY "all COBOL sorts ok"
    ELSE
        DISPLAY ws-fails " failures"
    END-IF
    STOP RUN.

set-cap.
    EVALUATE ws-algo
@CAPS@
    END-EVALUATE.

set-size.
    EVALUATE ws-sz
        WHEN 1 MOVE 0 TO ws-nsz
        WHEN 2 MOVE 1 TO ws-nsz
        WHEN 3 MOVE 2 TO ws-nsz
        WHEN 4 MOVE 3 TO ws-nsz
        WHEN 5 MOVE 4 TO ws-nsz
        WHEN 6 MOVE 5 TO ws-nsz
        WHEN 7 MOVE 6 TO ws-nsz
        WHEN 8 MOVE 9 TO ws-nsz
        WHEN 9 MOVE 12 TO ws-nsz
        WHEN 10 MOVE 17 TO ws-nsz
        WHEN 11 MOVE 30 TO ws-nsz
        WHEN 12 MOVE 64 TO ws-nsz
        WHEN 13 MOVE 100 TO ws-nsz
        WHEN 14 MOVE 257 TO ws-nsz
    END-EVALUATE.

next-random.
    COMPUTE ws-state = FUNCTION MOD(ws-state * 1103515245 + 12345, 2147483648)
    COMPUTE ws-r = FUNCTION INTEGER-PART(ws-state / 16).

run-case.
    PERFORM VARYING ws-i FROM 1 BY 1 UNTIL ws-i > ws-nsz
        EVALUATE ws-mode
            WHEN 0
                PERFORM next-random
                COMPUTE ws-tbl-e(ws-i) = FUNCTION MOD(ws-r, 21) - 10
            WHEN 1
                PERFORM next-random
                COMPUTE ws-tbl-e(ws-i) = FUNCTION MOD(ws-r, 2000001) - 1000000
            WHEN 2
                COMPUTE ws-tbl-e(ws-i) = ws-i - 1
            WHEN 3
                COMPUTE ws-tbl-e(ws-i) = ws-nsz - ws-i + 1
            WHEN OTHER
                MOVE 7 TO ws-tbl-e(ws-i)
        END-EVALUATE
        MOVE ws-tbl-e(ws-i) TO ws-ref-e(ws-i)
    END-PERFORM
    PERFORM VARYING ws-i FROM 2 BY 1 UNTIL ws-i > ws-nsz
        MOVE ws-ref-e(ws-i) TO ws-key
        COMPUTE ws-j = ws-i - 1
        PERFORM UNTIL ws-j < 1
            IF ws-ref-e(ws-j) > ws-key
                MOVE ws-ref-e(ws-j) TO ws-ref-e(ws-j + 1)
                COMPUTE ws-j = ws-j - 1
            ELSE
                EXIT PERFORM
            END-IF
        END-PERFORM
        MOVE ws-key TO ws-ref-e(ws-j + 1)
    END-PERFORM
    PERFORM call-algo
    MOVE 0 TO ws-bad
    PERFORM VARYING ws-i FROM 1 BY 1 UNTIL ws-i > ws-nsz
        IF ws-tbl-e(ws-i) NOT = ws-ref-e(ws-i)
            MOVE 1 TO ws-bad
        END-IF
    END-PERFORM
    IF ws-bad = 1
        ADD 1 TO ws-fails
        DISPLAY "FAIL algorithm " ws-algo " n=" ws-nsz
    END-IF.

call-algo.
    EVALUATE ws-algo
@CALLS@
    END-EVALUATE.

END PROGRAM cobol-sort-tests.
'''


C_BENCH = r'''/* GENERATED by kernels/generate.py - times every sort on the shared dataset (n per algorithm). Prints: name n ms */
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
@DECLS@
typedef void (*sort_fn)(int *, size_t);
static const struct { const char *name; sort_fn f; size_t n; } table[] = {
@TABLE@
};

static unsigned long long state = 12345;
static void fill(int *d, size_t n) {
    state = 12345;
    for (size_t i = 0; i < n; ++i) { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; d[i] = (int)((state / 16) % 10000); }
}
static double now(void) { struct timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec * 1e3 + t.tv_nsec / 1e6; }
static int cmpd(const void *a, const void *b) { double x = *(const double *)a, y = *(const double *)b; return (x > y) - (x < y); }

int main(void) {
    static int data[4096], work[4096];
    for (size_t k = 0; k < sizeof table / sizeof table[0]; ++k) {
        size_t n = table[k].n;
        fill(data, n);
        double times[400]; int rounds = 0; double total = 0;
        while (rounds < 400 && (rounds < 3 || total < 40.0) && total < 3000.0) {
            memcpy(work, data, n * sizeof(int));
            double t0 = now();
            table[k].f(work, n);
            double dt = now() - t0;
            times[rounds++] = dt; total += dt;
        }
        for (size_t i = 1; i < n; ++i) if (work[i - 1] > work[i]) { fprintf(stderr, "UNSORTED %s\n", table[k].name); return 1; }
        qsort(times, rounds, sizeof(double), cmpd);
        printf("%s %zu %.6f\n", table[k].name, n, times[rounds / 2]);
    }
    return 0;
}
'''

MC_BENCH = r'''/* GENERATED by kernels/generate.py - times each raw machine-code image. Prints: name n ms */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <time.h>

static const struct { const char *name; size_t n; } table[] = {
@TABLE@
};

static unsigned long long state = 12345;
static void fill(int *d, size_t n) {
    state = 12345;
    for (size_t i = 0; i < n; ++i) { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; d[i] = (int)((state / 16) % 10000); }
}
static double now(void) { struct timespec t; clock_gettime(CLOCK_MONOTONIC, &t); return t.tv_sec * 1e3 + t.tv_nsec / 1e6; }
static int cmpd(const void *a, const void *b) { double x = *(const double *)a, y = *(const double *)b; return (x > y) - (x < y); }

static void *load(const char *name) {
    char path[256]; snprintf(path, sizeof path, "bin/%s.bin", name);
    FILE *f = fopen(path, "rb"); if (!f) { perror(path); exit(2); }
    fseek(f, 0, SEEK_END); size_t len = (size_t)ftell(f); fseek(f, 0, SEEK_SET);
    void *mem = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (fread(mem, 1, len, f) != len) exit(2);
    fclose(f); mprotect(mem, len, PROT_READ | PROT_EXEC);
    return mem;
}

int main(void) {
    static int data[4096], work[4096];
    for (size_t k = 0; k < sizeof table / sizeof table[0]; ++k) {
        void (*f)(int *, size_t) = load(table[k].name);
        size_t n = table[k].n;
        fill(data, n);
        double times[400]; int rounds = 0; double total = 0;
        while (rounds < 400 && (rounds < 3 || total < 40.0) && total < 3000.0) {
            memcpy(work, data, n * sizeof(int));
            double t0 = now(); f(work, n); double dt = now() - t0;
            times[rounds++] = dt; total += dt;
        }
        for (size_t i = 1; i < n; ++i) if (work[i - 1] > work[i]) { fprintf(stderr, "UNSORTED %s\n", table[k].name); return 1; }
        qsort(times, rounds, sizeof(double), cmpd);
        printf("%s %zu %.6f\n", table[k].name, n, times[rounds / 2]);
    }
    return 0;
}
'''

CPP_BENCH = r'''// GENERATED by kernels/generate.py - times every C++ sort. Prints: name n ms
#include <algorithm>
#include <chrono>
#include <cstdio>
#include <functional>
#include <vector>
@INCLUDES@

struct Case { const char* name; size_t n; std::function<void(std::vector<int>&)> f; };
static const std::vector<Case> table = {
@TABLE@
};

int main() {
    for (const auto& c : table) {
        unsigned long long state = 12345;
        std::vector<int> data(c.n);
        for (auto& x : data) { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; x = (int)((state / 16) % 10000); }
        std::vector<double> times;
        double total = 0;
        std::vector<int> work;
        while (times.size() < 400 && (times.size() < 3 || total < 40.0) && total < 3000.0) {
            work = data;
            auto t0 = std::chrono::steady_clock::now();
            c.f(work);
            double dt = std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now() - t0).count();
            times.push_back(dt); total += dt;
        }
        if (!std::is_sorted(work.begin(), work.end())) { std::fprintf(stderr, "UNSORTED %s\n", c.name); return 1; }
        std::sort(times.begin(), times.end());
        std::printf("%s %zu %.6f\n", c.name, c.n, times[times.size() / 2]);
    }
}
'''

JAVA_BENCH = r'''// GENERATED by kernels/generate.py - times every Java sort (JIT warmed up first). Prints: name n ms
package sorting;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;

public final class Bench {
    private record Case(String name, int n, Consumer<int[]> f) {}
    private static final List<Case> table = new ArrayList<>();
    private static void add(String name, int n, Consumer<int[]> f) { table.add(new Case(name, n, f)); }

    public static void main(String[] args) {
@TABLE@
        for (Case c : table) {
            long state = 12345;
            int[] data = new int[c.n()];
            for (int i = 0; i < data.length; i++) { state = (state * 1103515245L + 12345L) % 2147483648L; data[i] = (int) ((state / 16) % 10000); }
            for (int w = 0; w < 20; w++) c.f().accept(data.clone());      // JIT warm-up (not timed)
            double[] times = new double[400];
            int rounds = 0;
            double total = 0;
            int[] work = null;
            while (rounds < 400 && (rounds < 5 || total < 60.0) && total < 3000.0) {
                work = data.clone();
                long t0 = System.nanoTime();
                c.f().accept(work);
                double dt = (System.nanoTime() - t0) / 1e6;
                times[rounds++] = dt;
                total += dt;
            }
            for (int i = 1; i < work.length; i++) if (work[i - 1] > work[i]) { System.err.println("UNSORTED " + c.name()); System.exit(1); }
            Arrays.sort(times, 0, rounds);
            System.out.printf("%s %d %.6f%n", c.name(), c.n(), times[rounds / 2]);
        }
    }
}
'''

GO_BENCH = r'''// GENERATED by kernels/generate.py - times every Go sort. Prints: name n ms
package main

import (
	"fmt"
	"os"
	"sort"
	"time"

	"github.com/naviNBRuas/SortingAlgorithms/go/algorithms"
)

type bcase struct {
	name string
	n    int
	f    func([]int)
}

func main() {
	table := []bcase{
@TABLE@
	}
	for _, c := range table {
		state := uint64(12345)
		data := make([]int, c.n)
		for i := range data {
			state = (state*1103515245 + 12345) % 2147483648
			data[i] = int((state / 16) % 10000)
		}
		var times []float64
		total := 0.0
		work := make([]int, c.n)
		for len(times) < 400 && (len(times) < 3 || total < 40.0) && total < 3000.0 {
			copy(work, data)
			t0 := time.Now()
			c.f(work)
			dt := float64(time.Since(t0).Nanoseconds()) / 1e6
			times = append(times, dt)
			total += dt
		}
		if !sort.IntsAreSorted(work) {
			fmt.Fprintln(os.Stderr, "UNSORTED", c.name)
			os.Exit(1)
		}
		sort.Float64s(times)
		fmt.Printf("%s %d %.6f\n", c.name, c.n, times[len(times)/2])
	}
}
'''

RUST_BENCH = r'''// GENERATED by kernels/generate.py - times every Rust sort (build with --release). Prints: name n ms
use sorting_algorithms::*;
use std::time::Instant;

type Case = (&'static str, usize, Box<dyn Fn(&mut [i32])>);

fn main() {
    let table: Vec<Case> = vec![
@TABLE@
    ];
    for (name, n, f) in table {
        let mut state: u64 = 12345;
        let data: Vec<i32> = (0..n)
            .map(|_| {
                state = (state * 1103515245 + 12345) % 2147483648;
                ((state / 16) % 10000) as i32
            })
            .collect();
        let mut times: Vec<f64> = Vec::new();
        let mut total = 0.0;
        let mut work = data.clone();
        while times.len() < 400 && (times.len() < 3 || total < 40.0) && total < 3000.0 {
            work.copy_from_slice(&data);
            let t0 = Instant::now();
            f(&mut work);
            let dt = t0.elapsed().as_secs_f64() * 1e3;
            times.push(dt);
            total += dt;
        }
        assert!(work.windows(2).all(|w| w[0] <= w[1]), "UNSORTED {}", name);
        times.sort_by(|a, b| a.partial_cmp(b).unwrap());
        println!("{} {} {:.6}", name, n, times[times.len() / 2]);
    }
}
'''

COBOL_BENCH = r'''>>SOURCE FORMAT FREE
      *> GENERATED by kernels/generate.py - runs ONE algorithm (index from the command line; 0 = data fill only).
      *> The orchestrator times whole processes and subtracts the fill-only baseline.
IDENTIFICATION DIVISION.
PROGRAM-ID. cobol-sort-bench.
DATA DIVISION.
WORKING-STORAGE SECTION.
01 ws-tbl.
    05 ws-tbl-e USAGE BINARY-LONG SIGNED OCCURS 65536 TIMES.
01 ws-arg PIC X(16).
01 ws-algo USAGE BINARY-DOUBLE SIGNED.
01 ws-nsz USAGE BINARY-DOUBLE SIGNED.
01 ws-i USAGE BINARY-DOUBLE SIGNED.
01 ws-state USAGE BINARY-DOUBLE SIGNED.
01 ws-r USAGE BINARY-DOUBLE SIGNED.
PROCEDURE DIVISION.
main-para.
    ACCEPT ws-arg FROM COMMAND-LINE
    MOVE FUNCTION NUMVAL(ws-arg) TO ws-algo
    IF ws-algo = 0
        MOVE 1000 TO ws-nsz
        PERFORM fill-data
        STOP RUN
    END-IF
    EVALUATE ws-algo
@NAMES@
    END-EVALUATE
    DISPLAY " " WITH NO ADVANCING
    EVALUATE ws-algo
@CALLS@
    END-EVALUATE
    STOP RUN.

fill-data.
    MOVE 12345 TO ws-state
    PERFORM VARYING ws-i FROM 1 BY 1 UNTIL ws-i > ws-nsz
        COMPUTE ws-state = FUNCTION MOD(ws-state * 1103515245 + 12345, 2147483648)
        COMPUTE ws-r = FUNCTION INTEGER-PART(ws-state / 16)
        COMPUTE ws-tbl-e(ws-i) = FUNCTION MOD(ws-r, 10000)
    END-PERFORM.

END PROGRAM cobol-sort-bench.
'''


MC_TEST = r'''/* Loads each raw machine-code image into executable memory and runs it against qsort(). */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>

static const struct { const char *name; size_t cap; int extras; } table[] = {
#include "table.h"
};

static int cmp(const void *a, const void *b) { return (*(const int *)a > *(const int *)b) - (*(const int *)a < *(const int *)b); }
static unsigned long long state = 12345;
static long long rnd(void) { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; return (long long)(state / 16); }

static void fill(int *d, size_t n, int mode) {
    for (size_t i = 0; i < n; ++i) {
        switch (mode) {
        case 0: d[i] = (int)(rnd() % 21) - 10; break;
        case 1: d[i] = (int)(rnd() % 2000001) - 1000000; break;
        case 2: d[i] = (int)i; break;
        case 3: d[i] = (int)(n - i); break;
        default: d[i] = 7; break;
        }
    }
}

static void *load(const char *name, size_t *len) {
    char path[256];
    snprintf(path, sizeof path, "bin/%s.bin", name);
    FILE *f = fopen(path, "rb");
    if (!f) { perror(path); exit(2); }
    fseek(f, 0, SEEK_END); *len = (size_t)ftell(f); fseek(f, 0, SEEK_SET);
    void *mem = mmap(NULL, *len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (mem == MAP_FAILED || fread(mem, 1, *len, f) != *len) { perror("load"); exit(2); }
    fclose(f);
    if (mprotect(mem, *len, PROT_READ | PROT_EXEC)) { perror("mprotect"); exit(2); }
    return mem;
}

static int check(const char *name, void *code, int extras, const int *src, size_t n) {
    int *a = malloc(n * sizeof(int) + 4), *w = malloc(n * sizeof(int) + 4);
    memcpy(a, src, n * sizeof(int));
    memcpy(w, src, n * sizeof(int));
    qsort(w, n, sizeof(int), cmp);
    if (extras) ((void (*)(int *, size_t, size_t))code)(a, n, 5000000);
    else ((void (*)(int *, size_t))code)(a, n);
    int ok = memcmp(a, w, n * sizeof(int)) == 0;
    if (!ok) printf("FAIL %s n=%zu\n", name, n);
    free(a); free(w);
    return ok;
}

int main(void) {
    static const size_t sizes[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,25,30,40,64,100,257,1000};
    int failures = 0;
    size_t total = 0;
    int *d = malloc(1100 * sizeof(int));
    for (size_t k = 0; k < sizeof table / sizeof table[0]; ++k) {
        size_t len;
        void *code = load(table[k].name, &len);
        total += len;
        for (size_t s = 0; s < sizeof sizes / sizeof sizes[0]; ++s) {
            size_t n = sizes[s];
            if (table[k].cap && n > table[k].cap) continue;
            for (int mode = 0; mode < 5; ++mode) { fill(d, n, mode); failures += !check(table[k].name, code, table[k].extras, d, n); }
        }
        int e[] = {2147483647, -2147483647 - 1, 0, -1, 2147483647, -2147483647 - 1, 5, 5};
        failures += !check(table[k].name, code, table[k].extras, e, table[k].cap && table[k].cap < 8 ? table[k].cap : 8);
    }
    free(d);
    if (failures) { printf("%d failures\n", failures); return 1; }
    printf("all %zu machine-code images ok (%zu bytes of raw x86-64)\n", sizeof table / sizeof table[0], total);
    return 0;
}
'''

C_TEST = r'''/* GENERATED by kernels/generate.py - exercises every C sort against qsort(). */
#include "sorting_algorithms.h"
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef void (*sort_fn)(int *, size_t);
@WRAPPERS@

static const struct { const char *name; sort_fn f; size_t cap; } table[] = {
@TABLE@
};

static int cmp(const void *a, const void *b) { return (*(const int *)a > *(const int *)b) - (*(const int *)a < *(const int *)b); }
static unsigned long long state = 12345;
static long long rnd(void) { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; return (long long)(state / 16); }

static void fill(int *d, size_t n, int mode) {
    for (size_t i = 0; i < n; ++i) {
        switch (mode) {
        case 0: d[i] = (int)(rnd() % 21) - 10; break;
        case 1: d[i] = (int)(rnd() % 2000001) - 1000000; break;
        case 2: d[i] = (int)i; break;
        case 3: d[i] = (int)(n - i); break;
        default: d[i] = 7; break;
        }
    }
}

static int check(const char *name, sort_fn f, const int *src, size_t n) {
    int *a = malloc(n * sizeof(int) + 4), *w = malloc(n * sizeof(int) + 4);
    memcpy(a, src, n * sizeof(int));
    memcpy(w, src, n * sizeof(int));
    qsort(w, n, sizeof(int), cmp);
    f(a, n);
    int ok = memcmp(a, w, n * sizeof(int)) == 0;
    if (!ok) printf("FAIL %s n=%zu\n", name, n);
    free(a); free(w);
    return ok;
}

int main(void) {
    static const size_t sizes[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,25,30,40,64,100,257,1000};
    int failures = 0;
    int *d = malloc(1100 * sizeof(int));
    for (size_t k = 0; k < sizeof table / sizeof table[0]; ++k) {
        for (size_t s = 0; s < sizeof sizes / sizeof sizes[0]; ++s) {
            size_t n = sizes[s];
            if (table[k].cap && n > table[k].cap) continue;
            for (int mode = 0; mode < 5; ++mode) {
                fill(d, n, mode);
                failures += !check(table[k].name, table[k].f, d, n);
            }
        }
        int e[] = {2147483647, -2147483647 - 1, 0, -1, 2147483647, -2147483647 - 1, 5, 5};
        failures += !check(table[k].name, table[k].f, e, table[k].cap && table[k].cap < 8 ? table[k].cap : 8);
    }
    free(d);
    printf(failures ? "%d failures\n" : "all C sorts ok\n", failures);
    return failures != 0;
}
'''

CPP_TEST = r'''// GENERATED by kernels/generate.py - exercises every C++ sort against std::sort.
#include <algorithm>
#include <functional>
#include <iostream>
#include <string>
#include <vector>
@INCLUDES@

struct Case { const char* name; std::function<void(std::vector<int>&)> f; size_t cap; };
static const std::vector<Case> table = {
@TABLE@
};

static unsigned long long state = 12345;
static long long rnd() { state = (state * 1103515245ULL + 12345ULL) % 2147483648ULL; return (long long)(state / 16); }

static std::vector<int> fill(size_t n, int mode) {
    std::vector<int> d(n);
    for (size_t i = 0; i < n; ++i) {
        switch (mode) {
        case 0: d[i] = (int)(rnd() % 21) - 10; break;
        case 1: d[i] = (int)(rnd() % 2000001) - 1000000; break;
        case 2: d[i] = (int)i; break;
        case 3: d[i] = (int)(n - i); break;
        default: d[i] = 7; break;
        }
    }
    return d;
}

int main() {
    const size_t sizes[] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,25,30,40,64,100,257,1000};
    int failures = 0;
    for (const auto& c : table) {
        auto run = [&](std::vector<int> v) {
            auto want = v;
            std::sort(want.begin(), want.end());
            c.f(v);
            if (v != want) { std::cout << "FAIL " << c.name << " n=" << v.size() << "\n"; ++failures; }
        };
        for (size_t n : sizes) {
            if (c.cap && n > c.cap) continue;
            for (int mode = 0; mode < 5; ++mode) run(fill(n, mode));
        }
        std::vector<int> e = {2147483647, -2147483647 - 1, 0, -1, 2147483647, -2147483647 - 1, 5, 5};
        if (c.cap && c.cap < 8) e.resize(c.cap);
        run(e);
    }
    std::cout << (failures ? std::to_string(failures) + " failures" : std::string("all C++ sorts ok")) << "\n";
    return failures != 0;
}
'''

JAVA_TEST = r'''// GENERATED by kernels/generate.py - exercises every Java sort against java.util.Arrays.sort.
package sorting;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;

public final class Tests {
    private record Case(String name, Consumer<int[]> f, int cap) {}
    private static final List<Case> table = new ArrayList<>();
    private static long state = 12345;

    private static void add(String name, Consumer<int[]> f, int cap) { table.add(new Case(name, f, cap)); }

    private static long rnd() { state = (state * 1103515245L + 12345L) % 2147483648L; return state / 16; }

    private static int[] fill(int n, int mode) {
        int[] d = new int[n];
        for (int i = 0; i < n; i++) {
            switch (mode) {
                case 0 -> d[i] = (int) (rnd() % 21) - 10;
                case 1 -> d[i] = (int) (rnd() % 2000001) - 1000000;
                case 2 -> d[i] = i;
                case 3 -> d[i] = n - i;
                default -> d[i] = 7;
            }
        }
        return d;
    }

    private static int failures = 0;

    private static void run(Case c, int[] src) {
        int[] want = src.clone();
        Arrays.sort(want);
        int[] got = src.clone();
        c.f().accept(got);
        if (!Arrays.equals(got, want)) { System.out.println("FAIL " + c.name() + " n=" + src.length); failures++; }
    }

    public static void main(String[] args) {
@TABLE@
        int[] sizes = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,20,25,30,40,64,100,257,1000};
        for (Case c : table) {
            for (int n : sizes) {
                if (c.cap() != 0 && n > c.cap()) continue;
                for (int mode = 0; mode < 5; mode++) run(c, fill(n, mode));
            }
            int[] e = {Integer.MAX_VALUE, Integer.MIN_VALUE, 0, -1, Integer.MAX_VALUE, Integer.MIN_VALUE, 5, 5};
            if (c.cap() != 0 && c.cap() < 8) e = Arrays.copyOf(e, c.cap());
            run(c, e);
        }
        System.out.println(failures == 0 ? "all Java sorts ok" : failures + " failures");
        System.exit(failures == 0 ? 0 : 1);
    }
}
'''

GO_TEST = r'''// GENERATED by kernels/generate.py
package algorithms

import (
	"sort"
	"testing"
)

type sortCase struct {
	name string
	f    func([]int)
	cap  int
}

var table = []sortCase{
@TABLE@
}

var state uint64 = 12345

func rnd() int64 {
	state = (state*1103515245 + 12345) % 2147483648
	return int64(state / 16)
}

func fill(n, mode int) []int {
	d := make([]int, n)
	for i := range d {
		switch mode {
		case 0:
			d[i] = int(rnd()%21) - 10
		case 1:
			d[i] = int(rnd()%2000001) - 1000000
		case 2:
			d[i] = i
		case 3:
			d[i] = n - i
		default:
			d[i] = 7
		}
	}
	return d
}

func TestAllAlgorithms(t *testing.T) {
	sizes := []int{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 25, 30, 40, 64, 100, 257, 1000}
	run := func(c sortCase, src []int) {
		want := append([]int(nil), src...)
		sort.Ints(want)
		got := append([]int(nil), src...)
		c.f(got)
		for i := range want {
			if got[i] != want[i] {
				t.Fatalf("%s failed (n=%d): got %v", c.name, len(src), got)
			}
		}
	}
	for _, c := range table {
		for _, n := range sizes {
			if c.cap != 0 && n > c.cap {
				continue
			}
			for mode := 0; mode < 5; mode++ {
				run(c, fill(n, mode))
			}
		}
		e := []int{2147483647, -2147483648, 0, -1, 2147483647, -2147483648, 5, 5}
		if c.cap != 0 && c.cap < 8 {
			e = e[:c.cap]
		}
		run(c, e)
	}
}
'''

GO_MAIN = r'''// GENERATED by kernels/generate.py - runs every algorithm on one shuffled array.
package main

import (
	"fmt"
	"sort"

	"github.com/naviNBRuas/SortingAlgorithms/go/algorithms"
)

func main() {
	base := []int{9, 3, 7, 1, 8, 2, 5, 4, 6, 0, 11, 10}
	want := append([]int(nil), base...)
	sort.Ints(want)
	algos := []struct {
		name string
		f    func([]int)
	}{
@TABLE@
	}
	for _, a := range algos {
		d := append([]int(nil), base...)
		a.f(d)
		ok := fmt.Sprint(d) == fmt.Sprint(want)
		fmt.Printf("%-26s %v %v\n", a.name, d, ok)
	}
}
'''

RUST_TEST = r'''// GENERATED by kernels/generate.py
use sorting_algorithms::*;

type Case = (&'static str, Box<dyn Fn(&mut Vec<i32>)>, usize);

fn table() -> Vec<Case> {
    vec![
@TABLE@
    ]
}

fn fill(state: &mut u64, n: usize, mode: u32) -> Vec<i32> {
    let mut rnd = || {
        *state = (*state * 1103515245 + 12345) % 2147483648;
        (*state / 16) as i64
    };
    (0..n)
        .map(|i| match mode {
            0 => (rnd() % 21) as i32 - 10,
            1 => (rnd() % 2000001) as i32 - 1000000,
            2 => i as i32,
            3 => (n - i) as i32,
            _ => 7,
        })
        .collect()
}

#[test]
fn all_algorithms() {
    let sizes = [0usize, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 20, 25, 30, 40, 64, 100, 257, 1000];
    let mut state = 12345u64;
    for (name, f, cap) in table() {
        let run = |src: Vec<i32>| {
            let mut want = src.clone();
            want.sort();
            let mut got = src.clone();
            f(&mut got);
            assert_eq!(got, want, "{} failed (n={})", name, src.len());
        };
        for &n in &sizes {
            if cap != 0 && n > cap {
                continue;
            }
            for mode in 0..5 {
                run(fill(&mut state, n, mode));
            }
        }
        let mut e = vec![i32::MAX, i32::MIN, 0, -1, i32::MAX, i32::MIN, 5, 5];
        if cap != 0 && cap < 8 {
            e.truncate(cap);
        }
        run(e);
    }
}
'''

RUST_MAIN = r'''// GENERATED by kernels/generate.py - runs every algorithm on one array.
use sorting_algorithms::*;

type Case = (&'static str, Box<dyn Fn(&mut Vec<i32>)>, usize);

fn main() {
    let base = vec![9, 3, 7, 1, 8, 2, 5, 4, 6, 0, 11, 10];
    let mut want = base.clone();
    want.sort();
    let table: Vec<Case> = vec![
@TABLE@
    ];
    for (name, f, _) in table {
        let mut d = base.clone();
        f(&mut d);
        println!("{:<26} {:?} {}", name, d, d == want);
    }
}
'''


def main():
    build()
    check = "--check" in sys.argv
    diffs = 0
    for path, text in written.items():
        if not text.endswith("\n"):
            text += "\n"
        if path.endswith(".go"):
            try:
                text = subprocess.run(["gofmt"], input=text, capture_output=True, text=True, check=True).stdout
            except (FileNotFoundError, subprocess.CalledProcessError):
                pass
        written[path] = text
    if not check:
        # remove stale hand-written/generated sources in the generated directories
        cleanup()
    for path, text in written.items():
        if check:
            if not os.path.exists(path) or open(path).read() != text:
                diffs += 1
                print("differs:", path)
            continue
        os.makedirs(os.path.dirname(path), exist_ok=True)
        open(path, "w").write(text)
    print(f"{'checked' if check else 'wrote'} {len(written)} files; {diffs} differ" if check else f"wrote {len(written)} files")
    return 1 if diffs else 0


def cleanup():
    import glob
    keep_go = {"helpers.go", "sort_test.go"}
    pats = ["c/src/*.c", "c/src/*.o", "cpp/include/sorting/*.hpp", "java/src/sorting/*.java", "go/algorithms/*.go", "rust/src/*.rs"]
    for pat in pats:
        for f in glob.glob(os.path.join(ROOT, pat)):
            if f in written:
                continue
            os.remove(f)


def fmt():
    go = os.environ.get("GO", "gofmt")
    try:
        subprocess.run([go, "-w", os.path.join(ROOT, "go")], check=False)
    except FileNotFoundError:
        pass


if __name__ == "__main__":
    sys.exit(main())
