# Raw x86-64 machine code

`bin/<algorithm>.bin` is **raw machine code**: the exact bytes of one sorting algorithm, ready to be copied into an
executable page and called. One file per algorithm (56 files, about 37 KB in total); `hex/<algorithm>.hex` holds the same bytes
as hex text and `MANIFEST.txt` lists each image's size, checksum and which routines were linked in.

* **Self-contained:** the image holds the algorithm plus everything it calls (`util` mmap helpers, insertion/heap sort, …).
* **Position independent:** only relative calls and jumps, so it runs at any address.
* **Entry point at offset 0**, System V AMD64 ABI: `void entry(int *arr, size_t n)` sorts signed 32-bit integers ascending in
  place (`bogo_sort` and `bozo_sort` take a third `size_t` argument, the attempt budget).
* **No libc, no dynamic loader:** the images only make `mmap`/`munmap` system calls for scratch memory.

The images are the assembled output of `assembly/` (28 hand-written + 28 compiled from kernels), linked with `ld` using
`link.ld` and stripped to raw bytes by `build.py`. Nothing here is hand-edited binary: rebuild with `make`, run with `make test`.

```sh
cd machine-code
make test          # builds bin/ and hex/, then mmaps each image executable and checks it against qsort()
xxd bin/bubble_sort.bin | head      # look at the actual bytes
```

Minimal loader:

```c
void *code = mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
fread(code, 1, len, fopen("bin/quick_sort.bin", "rb"));
mprotect(code, len, PROT_READ | PROT_EXEC);
((void (*)(int *, size_t))code)(data, n);
```
