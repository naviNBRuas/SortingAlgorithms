#!/usr/bin/env python3
"""Assemble every sort into a self-contained flat x86-64 machine-code image.

For each algorithm NAME the image bin/NAME.bin contains the raw bytes of NAME_asm plus every routine
it (transitively) calls (util.s mmap helpers, insertion/heap sort, ...), linked at address 0 with the
entry point at offset 0. The code is position independent (relative calls/jumps only), so it can be
copied anywhere executable and called as   void entry(int *arr, size_t n [, size_t extra]).

    python3 machine-code/build.py        # writes bin/*.bin, hex/*.hex, MANIFEST.txt
"""
import hashlib
import os
import subprocess
import sys
import tempfile

HERE = os.path.dirname(os.path.abspath(__file__))
ASM = os.path.join(os.path.dirname(HERE), "assembly")


def run(*cmd):
    return subprocess.run(cmd, check=True, capture_output=True, text=True).stdout


def main():
    sources = {}
    for d in (ASM, os.path.join(ASM, "generated")):
        for f in sorted(os.listdir(d)):
            if f.endswith(".s"):
                sources[f[:-2]] = os.path.join(d, f)
    tmp = tempfile.mkdtemp()
    objs, defines, needs = {}, {}, {}
    for name, path in sources.items():
        obj = os.path.join(tmp, name + ".o")
        run("as", "--64", "-o", obj, path)
        objs[name] = obj
        syms = run("nm", obj).splitlines()
        defines[name] = {l.split()[-1] for l in syms if " T " in l}
        needs[name] = {l.split()[-1] for l in syms if l.strip().startswith("U ")}
    provider = {sym: n for n, ss in defines.items() for sym in ss}
    os.makedirs(os.path.join(HERE, "bin"), exist_ok=True)
    os.makedirs(os.path.join(HERE, "hex"), exist_ok=True)
    manifest = []
    for name in sorted(sources):
        if name == "util":
            continue
        order, todo = [name], [name]
        while todo:
            cur = todo.pop()
            for sym in sorted(needs[cur]):
                dep = provider[sym]
                if dep not in order:
                    order.append(dep)
                    todo.append(dep)
        out = os.path.join(HERE, "bin", name + ".bin")
        run("ld", "-T", os.path.join(HERE, "link.ld"), "--oformat", "binary", "-o", out, *[objs[o] for o in order])
        data = open(out, "rb").read()
        elf = os.path.join(tmp, name + ".elf")
        run("ld", "-T", os.path.join(HERE, "link.ld"), "-o", elf, *[objs[o] for o in order])
        entry = [l.split()[0] for l in run("nm", elf).splitlines() if l.split()[-1] == f"{name}_asm"]
        assert entry and int(entry[0], 16) == 0, f"{name}: entry point not at offset 0"
        with open(os.path.join(HERE, "hex", name + ".hex"), "w") as h:
            hexs = data.hex()
            h.write("\n".join(hexs[i:i + 64] for i in range(0, len(hexs), 64)) + "\n")
        manifest.append((name, len(data), hashlib.sha256(data).hexdigest()[:16], "+".join(o for o in order[1:]) or "-"))
    with open(os.path.join(HERE, "MANIFEST.txt"), "w") as m:
        m.write(f"{'algorithm':28s} {'bytes':>6s}  sha256[:16]       links\n")
        for n, size, h, deps in manifest:
            m.write(f"{n:28s} {size:6d}  {h}  {deps}\n")
    print(f"built {len(manifest)} images, {sum(s for _, s, _, _ in manifest)} bytes of machine code")


if __name__ == "__main__":
    sys.exit(main())
