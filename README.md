# SortingAlgorithms

**An executable, animated atlas of <!--N-->56<!--/N--> sorting algorithms** — from bubble sort to Batcher networks, TimSort, smooth sort and Ford–Johnson merge-insertion — each one instrumented, tested, benchmarked and animated from the *same* code. Every one also ships in **C, C++, Java, Go, Rust, x86-64 assembly, raw machine code and COBOL**.

<p align="center">
  <img src="visualizations/gifs/race.gif" alt="Nine sorting algorithms racing on equal operation budgets" width="720">
</p>

- 🎞️ **<!--N-->56<!--/N--> animated GIFs** (plus a race), rendered from real execution traces: amber = compare, red = write/swap, green = verified sorted.
- 🧪 **Correctness tests** on random, sorted, reversed, duplicate-heavy and tiny inputs, plus *stability* verification, 0-1-principle proofs for the sorting networks, and docs-consistency checks. C, Go, Rust and assembly have their own suites.
- 📊 **[REPORT.md](REPORT.md)**: a benchmark study of comparisons, writes and runtime across sizes and input shapes, with empirical growth exponents.
- 🧬 Registry-driven metadata (complexity, stability, space, history), so the tables below cannot drift from the code.

## Contents

[Quick start](#quick-start) · [How it works](#how-it-works) · [Catalogue](#catalogue) · [Gallery](#gallery) · [Benchmarks at a glance](#benchmarks-at-a-glance) · [Coverage and omissions](#coverage-and-omissions) · [Nine editions](#nine-editions-of-every-algorithm) · [Repository layout](#repository-layout) · [Testing](#testing) · [Contributing](#contributing-a-new-algorithm) · [License](#license--citation)

---

## Quick start

```sh
pip install -r python/requirements.txt          # pillow/matplotlib/numpy only for GIFs & report
cd python && python -m pytest                   # run the test-suite
```

```sh
export PYTHONPATH=$PWD/python
python -m sorting_algorithms --list             # catalogue with complexities
python -m sorting_algorithms --algo quick_sort --size 20 --seed 1 --trace
python -m sorting_algorithms --algo all --size 200
```

```python
import sorting_algorithms as sa

sa.merge_sort([5, 2, 9, 1])                      # -> [1, 2, 5, 9]  (input is never mutated)

result, tracer = sa.heap_sort([5, 2, 9, 1], trace=True)
tracer.frames[3]                                 # TraceFrame(state=..., highlights=(0, 3), note='swap', comparisons=..., writes=...)

result, stats = sa.measure("tim_sort", list(range(1000)))
stats.comparisons, stats.writes                  # deterministic, machine-independent
```

### Regenerate everything

```sh
export PYTHONPATH=$PWD/python
python visualizations/generate_gifs.py           # all GIFs + race.gif (about a minute)
python benchmarks/run_benchmarks.py              # raw measurements -> report/data/benchmarks.json
python benchmarks/generate_report.py             # figures + REPORT.md
python scripts/build_docs.py                     # refresh the tables and gallery below
```

## How it works

Algorithms are written as ordinary, readable code against a `Tracked` array. The array counts comparisons, reads and writes, and — when a tracer is attached — emits an animation frame for every compare, swap and write. There is no tracing boilerplate inside algorithms, so the animated code is exactly the benchmarked code.

Each algorithm is registered with `@algorithm(...)`, which attaches its metadata (family, best/average/worst time, space, stability, history) to a central registry; the README tables, tests and report are all driven from it.

Out-of-place algorithms (merge, counting, tree, patience, …) additionally emit "view" frames showing their auxiliary structure being emptied into the output so the animation tells the true story.

---

## Catalogue

<!-- BEGIN:TABLE -->
| Algorithm | Family | Best | Average | Worst | Extra space | Stable | In-place |
| --- | --- | --- | --- | --- | --- | :-: | :-: |
| [Bubble Sort](#bubble_sort) | Exchange | O(n) | O(n²) | O(n²) | O(1) | ✓ | ✓ |
| [Cocktail Shaker Sort](#cocktail_shaker_sort) | Exchange | O(n) | O(n²) | O(n²) | O(1) | ✓ | ✓ |
| [Odd–Even (Brick) Sort](#odd_even_sort) | Exchange | O(n) | O(n²) | O(n²) | O(1) | ✓ | ✓ |
| [Comb Sort](#comb_sort) | Exchange | O(n log n) | O(n²/2^p) | O(n²) | O(1) | ✗ | ✓ |
| [Gnome Sort](#gnome_sort) | Exchange | O(n) | O(n²) | O(n²) | O(1) | ✓ | ✓ |
| [Exchange Sort](#exchange_sort) | Exchange | O(n²) | O(n²) | O(n²) | O(1) | ✗ | ✓ |
| [Circle Sort](#circle_sort) | Exchange | O(n log n) | O(n log² n) | O(n log² n) | O(log n) | ✗ | ✓ |
| [Quick Sort (Lomuto)](#quick_sort) | Exchange | O(n log n) | O(n log n) | O(n²) | O(log n) | ✗ | ✓ |
| [Quick Sort (Hoare)](#quick_sort_hoare) | Exchange | O(n log n) | O(n log n) | O(n²) | O(log n) | ✗ | ✓ |
| [Quick Sort (3-way)](#quick_sort_3way) | Exchange | O(n) | O(n log n) | O(n²) | O(log n) | ✗ | ✓ |
| [Quick Sort (Dual-Pivot)](#quick_sort_dual_pivot) | Exchange | O(n log n) | O(n log n) | O(n²) | O(log n) | ✗ | ✓ |
| [Stooge Sort](#stooge_sort) | Exchange | O(n^2.71) | O(n^2.71) | O(n^2.71) | O(log n) | ✗ | ✓ |
| [Slow Sort](#slow_sort) | Exchange | Ω(n^(log n / 2+ε)) | super-polynomial | super-polynomial | O(n) | ✗ | ✓ |
| [Pancake Sort](#pancake_sort) | Exchange | O(n) | O(n²) | O(n²) | O(1) | ✗ | ✓ |
| [Permutation Sort](#permutation_sort) | Exchange | O(n) | O(n·n!) | O(n·n!) | O(n) | ✓ | ✗ |
| [Selection Sort](#selection_sort) | Selection | O(n²) | O(n²) | O(n²) | O(1) | ✗ | ✓ |
| [Double Selection Sort](#double_selection_sort) | Selection | O(n²) | O(n²) | O(n²) | O(1) | ✗ | ✓ |
| [Bingo Sort](#bingo_sort) | Selection | O(n + k·n) | O(n·k) | O(n²) | O(1) | ✗ | ✓ |
| [Cycle Sort](#cycle_sort) | Selection | O(n²) | O(n²) | O(n²) | O(1) | ✗ | ✓ |
| [Heap Sort](#heap_sort) | Selection | O(n log n) | O(n log n) | O(n log n) | O(1) | ✗ | ✓ |
| [Smooth Sort](#smooth_sort) | Selection | O(n) | O(n log n) | O(n log n) | O(1) | ✗ | ✓ |
| [Tournament Sort](#tournament_sort) | Selection | O(n log n) | O(n log n) | O(n log n) | O(n) | ✓ | ✗ |
| [Weak Heap Sort](#weak_heap_sort) | Selection | O(n log n) | O(n log n) | O(n log n) | O(n) bits | ✗ | ✓ |
| [Bottom-Up Heap Sort](#bottom_up_heap_sort) | Selection | O(n log n) | O(n log n) | O(n log n) | O(1) | ✗ | ✓ |
| [Ternary Heap Sort](#ternary_heap_sort) | Selection | O(n log n) | O(n log n) | O(n log n) | O(1) | ✗ | ✓ |
| [Enumeration (Rank) Sort](#enumeration_sort) | Selection | O(n²) | O(n²) | O(n²) | O(n) | ✓ | ✗ |
| [Insertion Sort](#insertion_sort) | Insertion | O(n) | O(n²) | O(n²) | O(1) | ✓ | ✓ |
| [Binary Insertion Sort](#binary_insertion_sort) | Insertion | O(n log n) | O(n²) | O(n²) | O(1) | ✓ | ✓ |
| [Shell Sort](#shell_sort) | Insertion | O(n log n) | ~O(n^1.5) | O(n²) | O(1) | ✗ | ✓ |
| [Shell Sort (Ciura gaps)](#shell_sort_ciura) | Insertion | O(n log n) | unknown (≈O(n^1.25)) | O(n²) | O(1) | ✗ | ✓ |
| [Tree Sort (BST)](#tree_sort) | Insertion | O(n log n) | O(n log n) | O(n²) | O(n) | ✓ | ✗ |
| [AVL Tree Sort](#avl_tree_sort) | Insertion | O(n log n) | O(n log n) | O(n log n) | O(n) | ✓ | ✗ |
| [Patience Sort](#patience_sort) | Insertion | O(n log n) | O(n log n) | O(n log n) | O(n) | ✗ | ✗ |
| [Merge-Insertion Sort (Ford–Johnson)](#ford_johnson_sort) | Insertion | O(n log n) | O(n log n) | O(n log n) | O(n) | ✗ | ✗ |
| [Library Sort (Gapped Insertion)](#library_sort) | Insertion | O(n log n) | O(n log n) expected | O(n²) | O(n) | ✓ | ✗ |
| [Cartesian Tree Sort](#cartesian_tree_sort) | Insertion | O(n) | O(n log n) | O(n log n) | O(n) | ✗ | ✗ |
| [Merge Sort](#merge_sort) | Merge | O(n log n) | O(n log n) | O(n log n) | O(n) | ✓ | ✗ |
| [Merge Sort (Bottom-Up)](#merge_sort_bottom_up) | Merge | O(n log n) | O(n log n) | O(n log n) | O(n) | ✓ | ✗ |
| [In-Place Merge Sort](#in_place_merge_sort) | Merge | O(n log n) | O(n log² n) | O(n log² n) | O(log n) | ✓ | ✓ |
| [Strand Sort](#strand_sort) | Merge | O(n) | O(n²) | O(n²) | O(n) | ✓ | ✗ |
| [Tim Sort](#tim_sort) | Hybrid | O(n) | O(n log n) | O(n log n) | O(n) | ✓ | ✗ |
| [Intro Sort](#intro_sort) | Hybrid | O(n log n) | O(n log n) | O(n log n) | O(log n) | ✗ | ✓ |
| [Counting Sort](#counting_sort) | Distribution | O(n + k) | O(n + k) | O(n + k) | O(n + k) | ✓ | ✗ |
| [Pigeonhole Sort](#pigeonhole_sort) | Distribution | O(n + k) | O(n + k) | O(n + k) | O(n + k) | ✓ | ✗ |
| [Radix Sort (LSD)](#radix_sort_lsd) | Distribution | O(d(n + b)) | O(d(n + b)) | O(d(n + b)) | O(n + b) | ✓ | ✗ |
| [Radix Sort (MSD)](#radix_sort_msd) | Distribution | O(n) | O(d·n) | O(d·n) | O(n + b) | ✓ | ✗ |
| [American Flag Sort](#american_flag_sort) | Distribution | O(n) | O(d·n) | O(d·n) | O(b·log n) | ✗ | ✓ |
| [Bucket Sort](#bucket_sort) | Distribution | O(n + k) | O(n + k) | O(n²) | O(n + k) | ✓ | ✗ |
| [Bead (Gravity) Sort](#bead_sort) | Distribution | O(n)–O(S) | O(S) | O(S) | O(n·max) | ✓ | ✗ |
| [Flash Sort](#flash_sort) | Distribution | O(n) | O(n) | O(n²) | O(m) | ✗ | ✓ |
| [Sleep Sort (simulated)](#sleep_sort) | Distribution | O(n + max) | O(n + max) | O(n + max) | O(n) | ✓ | ✗ |
| [Bitonic Sort](#bitonic_sort) | Network | O(n log² n) | O(n log² n) | O(n log² n) | O(1) | ✗ | ✓ |
| [Batcher Odd–Even Merge Sort](#odd_even_merge_sort) | Network | O(n log² n) | O(n log² n) | O(n log² n) | O(1) | ✗ | ✓ |
| [Pairwise Sorting Network](#pairwise_sorting_network) | Network | O(n log² n) | O(n log² n) | O(n log² n) | O(1) | ✗ | ✓ |
| [Bogo Sort](#bogo_sort) | Probabilistic | O(n) | O(n·n!) | unbounded | O(1) | ✗ | ✓ |
| [Bozo Sort](#bozo_sort) | Probabilistic | O(n) | O(n·n!) | unbounded | O(1) | ✗ | ✓ |
<!-- END:TABLE -->

Notes: complexities are for comparison counts or equivalent primitive steps. *n* = length, *k* = key range, *d* = digits, *b* = radix, *S* = sum of keys. "Stable" claims are **verified by the test-suite** for every comparison-based algorithm that claims it.

## Gallery

<!-- BEGIN:GALLERY -->
### Exchange

Fix inversions by swapping elements: the bubble family, the quicksorts, and a few pathological relatives.

<a id="bubble_sort"></a>
#### Bubble Sort

Repeated adjacent swaps float the maximum to the right; stops early when a pass makes no swap.

<img src="visualizations/gifs/bubble_sort.gif" alt="Bubble Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(1) · stable, in-place
- **Origin:** Teaching staple since the 1950s (Friend 1956; named by Iverson 1962).

<a id="cocktail_shaker_sort"></a>
#### Cocktail Shaker Sort

Bidirectional bubble sort: alternating forward and backward passes shrink both ends.

<img src="visualizations/gifs/cocktail_shaker_sort.gif" alt="Cocktail Shaker Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(1) · stable, in-place
- **Origin:** Also called bidirectional bubble sort or shuttle sort.

<a id="odd_even_sort"></a>
#### Odd–Even (Brick) Sort

Alternates compare-exchange phases over odd and even adjacent pairs; every phase is parallelisable.

<img src="visualizations/gifs/odd_even_sort.gif" alt="Odd–Even (Brick) Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(1) · stable, in-place
- **Origin:** Habermann 1972; the basis of mesh-connected parallel sorting.

<a id="comb_sort"></a>
#### Comb Sort

Bubble sort with a shrinking gap (factor 1.3) so small values near the end move quickly.

<img src="visualizations/gifs/comb_sort.gif" alt="Comb Sort animation" width="480">

- **Time:** best O(n log n) · average O(n²/2^p) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Włodzimierz Dobosiewicz 1980; popularised by Lacey & Box, BYTE 1991.

<a id="gnome_sort"></a>
#### Gnome Sort

A garden gnome steps forward when in order and swaps backward when not.

<img src="visualizations/gifs/gnome_sort.gif" alt="Gnome Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(1) · stable, in-place
- **Origin:** Hamid Sarbazi-Azad 2000 ("stupid sort"); renamed by Dick Grune.

<a id="exchange_sort"></a>
#### Exchange Sort

Compares position i with every later position and swaps whenever they are inverted.

<img src="visualizations/gifs/exchange_sort.gif" alt="Exchange Sort animation" width="480">

- **Time:** best O(n²) · average O(n²) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Folklore; the simplest quadratic sort to write down.

<a id="circle_sort"></a>
#### Circle Sort

Compares first with last, second with second-last, …, recurses on halves, repeats until clean.

<img src="visualizations/gifs/circle_sort.gif" alt="Circle Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log² n) · worst O(n log² n)
- **Space:** O(log n) · unstable, in-place
- **Origin:** Described by Gabriel Dabbs, 2014.

<a id="quick_sort"></a>
#### Quick Sort (Lomuto)

Partition around the last element with Lomuto's single-index scheme, then recurse.

<img src="visualizations/gifs/quick_sort.gif" alt="Quick Sort (Lomuto) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n²)
- **Space:** O(log n) · unstable, in-place
- **Origin:** Tony Hoare 1959; Lomuto partition popularised by Bentley's Programming Pearls.

<a id="quick_sort_hoare"></a>
#### Quick Sort (Hoare)

Two indices converge from both ends around a middle pivot; fewer swaps than Lomuto.

<img src="visualizations/gifs/quick_sort_hoare.gif" alt="Quick Sort (Hoare) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n²)
- **Space:** O(log n) · unstable, in-place
- **Origin:** Hoare's original 1961 partition scheme.

<a id="quick_sort_3way"></a>
#### Quick Sort (3-way)

Dutch-national-flag partition into <, =, > pivot; linear time on inputs with few distinct keys.

<img src="visualizations/gifs/quick_sort_3way.gif" alt="Quick Sort (3-way) animation" width="480">

- **Time:** best O(n) · average O(n log n) · worst O(n²)
- **Space:** O(log n) · unstable, in-place
- **Origin:** Dijkstra's Dutch national flag problem (1976); Bentley–McIlroy 1993.

<a id="quick_sort_dual_pivot"></a>
#### Quick Sort (Dual-Pivot)

Two pivots split the range into three parts; the scheme used by Java's Arrays.sort. This version takes the end elements as pivots, so sorted input is quadratic.

<img src="visualizations/gifs/quick_sort_dual_pivot.gif" alt="Quick Sort (Dual-Pivot) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n²)
- **Space:** O(log n) · unstable, in-place
- **Origin:** Vladimir Yaroslavskiy, 2009.

<a id="stooge_sort"></a>
#### Stooge Sort

Sort the first 2/3, the last 2/3, then the first 2/3 again. Correct, and deliberately slow.

<img src="visualizations/gifs/stooge_sort.gif" alt="Stooge Sort animation" width="480">

- **Time:** best O(n^2.71) · average O(n^2.71) · worst O(n^2.71)
- **Space:** O(log n) · unstable, in-place
- **Origin:** Howard, Fine and Howard — a Three Stooges joke, textbook cautionary example (CLRS problem 7-3).

<a id="slow_sort"></a>
#### Slow Sort

'Multiply and surrender': find the max of each half recursively, then sort the rest the same way.

<img src="visualizations/gifs/slow_sort.gif" alt="Slow Sort animation" width="480">

- **Time:** best Ω(n^(log n / 2+ε)) · average super-polynomial · worst super-polynomial
- **Space:** O(n) · unstable, in-place
- **Origin:** Broder & Stolfi, 'Pessimal Algorithms and Simplexity Analysis', 1986.

<a id="pancake_sort"></a>
#### Pancake Sort

Only prefix reversals ('spatula flips') are allowed: bring the max to the front, flip it into place.

<img src="visualizations/gifs/pancake_sort.gif" alt="Pancake Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Gates & Papadimitriou 1979 (their only joint paper; Gates co-founded Microsoft).

<a id="permutation_sort"></a>
#### Permutation Sort

Enumerate permutations in lexicographic order until one is sorted. Deterministic cousin of bogo sort.

<img src="visualizations/gifs/permutation_sort.gif" alt="Permutation Sort animation" width="480">

- **Time:** best O(n) · average O(n·n!) · worst O(n·n!)
- **Space:** O(n) · stable, not in-place
- **Origin:** Folklore ('exhaustive search sort').

### Selection

Repeatedly select an extreme element: selection, the heaps, cycle and tournament sorts.

<a id="selection_sort"></a>
#### Selection Sort

Repeatedly select the minimum of the unsorted suffix and swap it into place: exactly n−1 swaps.

<img src="visualizations/gifs/selection_sort.gif" alt="Selection Sort animation" width="480">

- **Time:** best O(n²) · average O(n²) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Folklore; analysed in Knuth TAOCP vol. 3 §5.2.3.

<a id="double_selection_sort"></a>
#### Double Selection Sort

Each pass picks both the minimum and the maximum, halving the number of passes.

<img src="visualizations/gifs/double_selection_sort.gif" alt="Double Selection Sort animation" width="480">

- **Time:** best O(n²) · average O(n²) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Common optimisation of selection sort (also 'bidirectional selection').

<a id="bingo_sort"></a>
#### Bingo Sort

Selection sort variant that moves every copy of the current maximum at once; fast with many duplicates.

<img src="visualizations/gifs/bingo_sort.gif" alt="Bingo Sort animation" width="480">

- **Time:** best O(n + k·n) · average O(n·k) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Described in the NIST Dictionary of Algorithms and Data Structures.

<a id="cycle_sort"></a>
#### Cycle Sort

Rotates each permutation cycle into place; performs the theoretical minimum number of writes.

<img src="visualizations/gifs/cycle_sort.gif" alt="Cycle Sort animation" width="480">

- **Time:** best O(n²) · average O(n²) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** B. K. Haddon, 1990.

<a id="heap_sort"></a>
#### Heap Sort

Build a max-heap, then repeatedly swap the root to the end and restore the heap.

<img src="visualizations/gifs/heap_sort.gif" alt="Heap Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(1) · unstable, in-place
- **Origin:** J. W. J. Williams 1964; Floyd's linear-time heap construction the same year.

<a id="smooth_sort"></a>
#### Smooth Sort

Heap sort over a forest of Leonardo heaps; approaches O(n) on nearly sorted input.

<img src="visualizations/gifs/smooth_sort.gif" alt="Smooth Sort animation" width="480">

- **Time:** best O(n) · average O(n log n) · worst O(n log n)
- **Space:** O(1) · unstable, in-place
- **Origin:** Edsger Dijkstra 1981 (EWD796a); this follows Orson Peters' formulation.

<a id="tournament_sort"></a>
#### Tournament Sort

Plays a knockout tournament to find the minimum, then replays only the winner's path per extraction.

<img src="visualizations/gifs/tournament_sort.gif" alt="Tournament Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · stable, not in-place
- **Origin:** Knuth TAOCP vol. 3 §5.2.3 (replacement selection / tree selection).

<a id="weak_heap_sort"></a>
#### Weak Heap Sort

Heap sort on a weak heap (a binary tree with a reverse bit per node); near-optimal comparison count.

<img src="visualizations/gifs/weak_heap_sort.gif" alt="Weak Heap Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) bits · unstable, in-place
- **Origin:** Dutton 1993; Edelkamp & Wegener 2002.

<a id="bottom_up_heap_sort"></a>
#### Bottom-Up Heap Sort

Heap sort whose sift-down first descends along larger children to a leaf, then climbs back to the key's slot: ~n log n comparisons instead of 2 n log n.

<img src="visualizations/gifs/bottom_up_heap_sort.gif" alt="Bottom-Up Heap Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(1) · unstable, in-place
- **Origin:** Ingo Wegener, 1993 ('Bottom-up heapsort').

<a id="ternary_heap_sort"></a>
#### Ternary Heap Sort

Heap sort on a 3-ary heap: shallower tree (log₃ n levels), more comparisons per level, better cache locality.

<img src="visualizations/gifs/ternary_heap_sort.gif" alt="Ternary Heap Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(1) · unstable, in-place
- **Origin:** d-ary heaps: Johnson 1975; ternary heaps minimise the comparison cost for d = 3.

<a id="enumeration_sort"></a>
#### Enumeration (Rank) Sort

Compute every element's final rank by counting how many elements precede it, then place it directly.

<img src="visualizations/gifs/enumeration_sort.gif" alt="Enumeration (Rank) Sort animation" width="480">

- **Time:** best O(n²) · average O(n²) · worst O(n²)
- **Space:** O(n) · stable, not in-place
- **Origin:** Folklore; the textbook parallel sort (every rank can be computed independently).

### Insertion

Grow a sorted structure one element at a time: arrays, gapped arrays, trees and piles.

<a id="insertion_sort"></a>
#### Insertion Sort

Grow a sorted prefix by shifting larger elements right and dropping each new key into the gap.

<img src="visualizations/gifs/insertion_sort.gif" alt="Insertion Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(1) · stable, in-place
- **Origin:** Ancient (card-sorting by hand); analysed in Knuth TAOCP vol. 3.

<a id="binary_insertion_sort"></a>
#### Binary Insertion Sort

Insertion sort that binary-searches the sorted prefix: O(n log n) comparisons, same O(n²) moves.

<img src="visualizations/gifs/binary_insertion_sort.gif" alt="Binary Insertion Sort animation" width="480">

- **Time:** best O(n log n) · average O(n²) · worst O(n²)
- **Space:** O(1) · stable, in-place
- **Origin:** Mauchly 1946 described binary insertion; used inside TimSort for short runs.

<a id="shell_sort"></a>
#### Shell Sort

Gapped insertion sorts with gaps n/2, n/4, …, 1 (Shell's original sequence).

<img src="visualizations/gifs/shell_sort.gif" alt="Shell Sort animation" width="480">

- **Time:** best O(n log n) · average ~O(n^1.5) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Donald Shell, 1959 — the first algorithm to break the quadratic barrier.

<a id="shell_sort_ciura"></a>
#### Shell Sort (Ciura gaps)

Shell sort with Marcin Ciura's empirically optimal gap sequence 1, 4, 10, 23, 57, 132, 301, 701.

<img src="visualizations/gifs/shell_sort_ciura.gif" alt="Shell Sort (Ciura gaps) animation" width="480">

- **Time:** best O(n log n) · average unknown (≈O(n^1.25)) · worst O(n²)
- **Space:** O(1) · unstable, in-place
- **Origin:** Ciura 2001, 'Best Increments for the Average Case of Shell Sort'.

<a id="tree_sort"></a>
#### Tree Sort (BST)

Insert every key into an unbalanced binary search tree, then read it back in order.

<img src="visualizations/gifs/tree_sort.gif" alt="Tree Sort (BST) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n²)
- **Space:** O(n) · stable, not in-place
- **Origin:** Floyd 1962 and others; degenerates to a linked list on sorted input.

<a id="avl_tree_sort"></a>
#### AVL Tree Sort

Tree sort on a self-balancing AVL tree, so sorted input no longer degrades it.

<img src="visualizations/gifs/avl_tree_sort.gif" alt="AVL Tree Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · stable, not in-place
- **Origin:** Adelson-Velsky & Landis, 1962.

<a id="patience_sort"></a>
#### Patience Sort

Deal cards onto piles (binary-searching the leftmost legal pile), then merge the piles.

<img src="visualizations/gifs/patience_sort.gif" alt="Patience Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · unstable, not in-place
- **Origin:** Named by Mallows 1960s after the card game; yields the longest increasing subsequence length for free.

<a id="ford_johnson_sort"></a>
#### Merge-Insertion Sort (Ford–Johnson)

Pair up elements, recursively sort the winners, then binary-insert the losers in Jacobsthal order. Uses the fewest comparisons of any known algorithm for small n.

<img src="visualizations/gifs/ford_johnson_sort.gif" alt="Merge-Insertion Sort (Ford–Johnson) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · unstable, not in-place
- **Origin:** Lester Ford Jr. & Selmer Johnson, 1959; optimal for n ≤ 22 (Peczarski 2004).

<a id="library_sort"></a>
#### Library Sort (Gapped Insertion)

Insertion sort into an array that keeps gaps, like a librarian leaving shelf space; rebalanced as it doubles.

<img src="visualizations/gifs/library_sort.gif" alt="Library Sort (Gapped Insertion) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) expected · worst O(n²)
- **Space:** O(n) · stable, not in-place
- **Origin:** Bender, Farach-Colton & Mosteiro 2004, 'Insertion Sort is O(n log n)'.

<a id="cartesian_tree_sort"></a>
#### Cartesian Tree Sort

Build a Cartesian tree in O(n), then emit minima with a priority queue holding only the tree frontier; adaptive to presortedness.

<img src="visualizations/gifs/cartesian_tree_sort.gif" alt="Cartesian Tree Sort animation" width="480">

- **Time:** best O(n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · unstable, not in-place
- **Origin:** Levcopoulos & Petersson, 1989 ('Heapsort — adapted for presorted files').

### Merge

Combine sorted runs: classic merge sorts, in-place variants and run-based strand sort.

<a id="merge_sort"></a>
#### Merge Sort

Split in half, sort each half recursively, merge the two sorted halves.

<img src="visualizations/gifs/merge_sort.gif" alt="Merge Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · stable, not in-place
- **Origin:** John von Neumann, 1945 (EDVAC) — one of the first programs ever written for a stored-program computer.

<a id="merge_sort_bottom_up"></a>
#### Merge Sort (Bottom-Up)

Iterative merge sort: merge runs of width 1, 2, 4, … with no recursion.

<img src="visualizations/gifs/merge_sort_bottom_up.gif" alt="Merge Sort (Bottom-Up) animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · stable, not in-place
- **Origin:** Standard in external sorting and in Knuth's Algorithm S.

<a id="in_place_merge_sort"></a>
#### In-Place Merge Sort

Merges without a buffer by binary-searching a split point and rotating blocks (SymMerge-style).

<img src="visualizations/gifs/in_place_merge_sort.gif" alt="In-Place Merge Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log² n) · worst O(n log² n)
- **Space:** O(log n) · stable, in-place
- **Origin:** Kim & Kutzner 2004 'Stable minimum storage merging by symmetric comparisons'; Go's sort.Stable.

<a id="strand_sort"></a>
#### Strand Sort

Repeatedly pull an increasing 'strand' out of the input and merge it into the output list.

<img src="visualizations/gifs/strand_sort.gif" alt="Strand Sort animation" width="480">

- **Time:** best O(n) · average O(n²) · worst O(n²)
- **Space:** O(n) · stable, not in-place
- **Origin:** Described in Wikipedia/Knuth exercises; natural-merge flavour.

### Hybrid

Production sorts that stitch several strategies together.

<a id="tim_sort"></a>
#### Tim Sort

Detects natural runs, extends short ones with binary insertion, and merges them under stack invariants. (This version omits galloping mode.)

<img src="visualizations/gifs/tim_sort.gif" alt="Tim Sort animation" width="480">

- **Time:** best O(n) · average O(n log n) · worst O(n log n)
- **Space:** O(n) · stable, not in-place
- **Origin:** Tim Peters 2002 for CPython; default sort in Python, Java (objects), Android, Rust (stable).

<a id="intro_sort"></a>
#### Intro Sort

Median-of-three quicksort that switches to heap sort past a depth limit and to insertion sort on tiny ranges.

<img src="visualizations/gifs/intro_sort.gif" alt="Intro Sort animation" width="480">

- **Time:** best O(n log n) · average O(n log n) · worst O(n log n)
- **Space:** O(log n) · unstable, in-place
- **Origin:** David Musser, 1997; basis of C++ std::sort in libstdc++ and libc++.

### Distribution

Look at key values instead of comparing: counting, radix, bucket and friends. Compare counts are 0 because no element comparison is made.

<a id="counting_sort"></a>
#### Counting Sort

Count occurrences of each key, prefix-sum the counts into positions, place elements stably.

<img src="visualizations/gifs/counting_sort.gif" alt="Counting Sort animation" width="480">

- **Time:** best O(n + k) · average O(n + k) · worst O(n + k)
- **Space:** O(n + k) · stable, not in-place
- **Origin:** Harold Seward, MIT 1954.

<a id="pigeonhole_sort"></a>
#### Pigeonhole Sort

Drop each element into the hole for its key, then read the holes back in order.

<img src="visualizations/gifs/pigeonhole_sort.gif" alt="Pigeonhole Sort animation" width="480">

- **Time:** best O(n + k) · average O(n + k) · worst O(n + k)
- **Space:** O(n + k) · stable, not in-place
- **Origin:** Folklore variant of counting sort for keys with few gaps.

<a id="radix_sort_lsd"></a>
#### Radix Sort (LSD)

Stable counting-sort passes on each decimal digit, least significant first; negatives handled by offset.

<img src="visualizations/gifs/radix_sort_lsd.gif" alt="Radix Sort (LSD) animation" width="480">

- **Time:** best O(d(n + b)) · average O(d(n + b)) · worst O(d(n + b))
- **Space:** O(n + b) · stable, not in-place
- **Origin:** Herman Hollerith's tabulating machine, 1887; Seward's computer version 1954.

<a id="radix_sort_msd"></a>
#### Radix Sort (MSD)

Bucket by the most significant decimal digit, then recurse into each bucket on the next digit.

<img src="visualizations/gifs/radix_sort_msd.gif" alt="Radix Sort (MSD) animation" width="480">

- **Time:** best O(n) · average O(d·n) · worst O(d·n)
- **Space:** O(n + b) · stable, not in-place
- **Origin:** Classic top-down radix sort; basis of burst/trie sorts for strings.

<a id="american_flag_sort"></a>
#### American Flag Sort

In-place MSD radix sort: count digits, then permute elements into their buckets by cycle-leader swaps.

<img src="visualizations/gifs/american_flag_sort.gif" alt="American Flag Sort animation" width="480">

- **Time:** best O(n) · average O(d·n) · worst O(d·n)
- **Space:** O(b·log n) · unstable, in-place
- **Origin:** McIlroy, Bostic & McIlroy 1993, 'Engineering Radix Sort'.

<a id="bucket_sort"></a>
#### Bucket Sort

Scatter keys into n equal-width buckets over [min, max], insertion-sort each bucket, concatenate.

<img src="visualizations/gifs/bucket_sort.gif" alt="Bucket Sort animation" width="480">

- **Time:** best O(n + k) · average O(n + k) · worst O(n²)
- **Space:** O(n + k) · stable, not in-place
- **Origin:** Isaac & Singleton 1956; Knuth TAOCP vol. 3 §5.2.1.

<a id="bead_sort"></a>
#### Bead (Gravity) Sort

Beads on rods fall under gravity; each row of beads is a number. S = sum of the inputs.

<img src="visualizations/gifs/bead_sort.gif" alt="Bead (Gravity) Sort animation" width="480">

- **Time:** best O(n)–O(S) · average O(S) · worst O(S)
- **Space:** O(n·max) · stable, not in-place
- **Origin:** Joshua Arulanandham, Cristian Calude & Michael Dinneen, 2002.

<a id="flash_sort"></a>
#### Flash Sort

Classify keys into ~0.43n classes by linear interpolation, permute in place, finish with insertion sort.

<img src="visualizations/gifs/flash_sort.gif" alt="Flash Sort animation" width="480">

- **Time:** best O(n) · average O(n) · worst O(n²)
- **Space:** O(m) · unstable, in-place
- **Origin:** Karl-Dietrich Neubert, 1998 (Dr. Dobb's).

<a id="sleep_sort"></a>
#### Sleep Sort (simulated)

Each element 'sleeps' for its value and is emitted on waking; here the clock is simulated tick by tick.

<img src="visualizations/gifs/sleep_sort.gif" alt="Sleep Sort (simulated) animation" width="480">

- **Time:** best O(n + max) · average O(n + max) · worst O(n + max)
- **Space:** O(n) · stable, not in-place
- **Origin:** Anonymous 4chan post, 2011 — a joke that is secretly a counting sort over time.

### Network

Data-independent comparator schedules, ideal for hardware and GPUs.

<a id="bitonic_sort"></a>
#### Bitonic Sort

Batcher's bitonic network: build ever-longer bitonic sequences, then merge them with half-cleaners.

<img src="visualizations/gifs/bitonic_sort.gif" alt="Bitonic Sort animation" width="480">

- **Time:** best O(n log² n) · average O(n log² n) · worst O(n log² n)
- **Space:** O(1) · unstable, in-place
- **Origin:** Ken Batcher, 1968; the workhorse of GPU sorting. Arbitrary n handled by skipping out-of-range comparators.

<a id="odd_even_merge_sort"></a>
#### Batcher Odd–Even Merge Sort

Batcher's other network: recursively merge sorted halves with an odd–even merge.

<img src="visualizations/gifs/odd_even_merge_sort.gif" alt="Batcher Odd–Even Merge Sort animation" width="480">

- **Time:** best O(n log² n) · average O(n log² n) · worst O(n log² n)
- **Space:** O(1) · unstable, in-place
- **Origin:** Ken Batcher, 1968; Knuth TAOCP vol. 3 §5.3.4.

<a id="pairwise_sorting_network"></a>
#### Pairwise Sorting Network

Compare pairs, then pairs of pairs, in a pattern with the same size as Batcher's networks but a simpler structure.

<img src="visualizations/gifs/pairwise_sorting_network.gif" alt="Pairwise Sorting Network animation" width="480">

- **Time:** best O(n log² n) · average O(n log² n) · worst O(n log² n)
- **Space:** O(1) · unstable, in-place
- **Origin:** Ian Parberry, 1992 ('The pairwise sorting network').

### Probabilistic

Randomised sorts with no worst-case bound. Included as cautionary tales.

<a id="bogo_sort"></a>
#### Bogo Sort

Shuffle until sorted. Guarded by max_shuffles so it always terminates.

<img src="visualizations/gifs/bogo_sort.gif" alt="Bogo Sort animation" width="480">

- **Time:** best O(n) · average O(n·n!) · worst unbounded
- **Space:** O(1) · unstable, in-place
- **Origin:** Jargon-file folklore ('permutation sort', 'stupid sort').

<a id="bozo_sort"></a>
#### Bozo Sort

Swap two random elements, check, repeat. Even less strategic than bogo sort.

<img src="visualizations/gifs/bozo_sort.gif" alt="Bozo Sort animation" width="480">

- **Time:** best O(n) · average O(n·n!) · worst unbounded
- **Space:** O(1) · unstable, in-place
- **Origin:** Jargon-file folklore.

<!-- END:GALLERY -->

---

## Benchmarks at a glance

Operations per element relative to n·log₂n at n = 1024, for every algorithm and five input shapes (lower is better; see [REPORT.md](REPORT.md) for the full study, scaling curves and fitted exponents):

<p align="center"><img src="report/figures/heatmap.png" alt="Heatmap of operations per n log n for every algorithm and input shape" width="560"></p>

Highlights: binary insertion sort, Ford–Johnson and merge-style sorts come within a few percent of the information-theoretic comparison minimum; Lomuto and dual-pivot quicksort with end pivots degrade ~20–40× on already-sorted input; 3-way quicksort and bingo sort collapse on few-unique-key inputs; adaptive sorts (insertion, TimSort, smooth, Cartesian-tree) approach linear on nearly sorted data.

## Coverage and omissions

The catalogue covers every major family: exchange, selection/heap, insertion/tree, merge, hybrid, distribution, sorting networks and the pathological/probabilistic sorts. "Every sorting algorithm" is not a finite list, so here is what is deliberately **not** included and why:

| Not implemented | Reason |
| --- | --- |
| Block / WikiSort, GrailSort, pdqsort, ips⁴o, Spreadsort, Burstsort, Cubesort | Highly engineered production algorithms (thousands of lines, many tuning constants) that do not animate or explain cleanly. Their ideas appear here through TimSort, intro sort, MSD radix and American flag sort. |
| Shear sort, Rotatesort, other 2-D mesh sorts | Need a rectangular grid; this framework sorts a 1-D array. |
| Stalin sort and similar "delete the unsorted" jokes | Not actually sorting (they discard data). |
| Spaghetti sort | A physical analogue computer; the closest honest simulation is bead/selection sort. |
| Bogobogosort, quantum bogosort | Variants with no new idea over bogo sort. |
| External / disk sorts (k-way merge, replacement selection) | Out of scope for an in-memory array visualiser; tournament and strand sort show the core ideas. |

Contributions of any of these are welcome; see [Contributing](#contributing-a-new-algorithm).

## Nine editions of every algorithm

All 56 algorithms exist in every language below. Each non-Python edition is generated from one verified source of truth, the
**kernels** in [`kernels/`](kernels/README.md) (a restricted executable Python subset), so they all run the same algorithm.

| Language | Location | How to test | Status |
| --- | --- | --- | --- |
| Python | `python/` | `cd python && python -m pytest` | **Reference** edition: tracing, animation, stability checks, benchmarks. |
| C | `c/` | `cd c && make test` | 56 algorithms → `libsort.a`; warning-free, ASan-clean. |
| C++ | `cpp/` | `cd cpp && make test` | Header-only C++17 (`sorting/all.hpp`). |
| Java | `java/` | `cd java && make test` | One class per algorithm, JDK 17+. |
| Go | `go/` | `cd go && go test ./...` | Package `algorithms`. |
| Rust | `rust/` | `cd rust && cargo test` | Bounds-checked, no `unsafe`. |
| x86-64 assembly | `assembly/` | `cd assembly && make test freestanding` | **28 hand-written** + 28 compiled from kernels; no libc (see below). |
| Machine code | `machine-code/` | `cd machine-code && make test` | **56 raw x86-64 images** (about 37 KB), loaded into executable memory and run. |
| COBOL | `cobol/` | `cd cobol && make test` | 56 GnuCOBOL programs, verified with GnuCOBOL 3.2.0 (see [cobol/README.md](cobol/README.md)). |

* **Assembly** is GNU `as` Intel syntax with no C and no libc: only two raw `mmap`/`munmap` system calls. The 28 original
  algorithms are hand-written; the other 28 are output of the kernel compiler (`kernels/backends/x86.py`) and are labelled as such.
  All 56 pass the harness, are Valgrind-clean, and link and run in a `-nostdlib -static` binary.
* **Machine code** is the assembled bytes of those 56 routines, one self-contained, position-independent file each.
* Every edition is tested against the language's own sort on random, sorted, reversed, all-equal and `INT_MIN`/`INT_MAX` inputs of many lengths.
* The super-polynomial algorithms (stooge, slow, bogo, bozo, permutation) are tested on small sizes only.

## Repository layout

```
python/sorting_algorithms/   reference: base.py (tracking array + registry) and algos/<family>.py
python/tests/                correctness, stability, networks, docs consistency
kernels/                     algos/<name>.py: the single source of truth for all other languages
                             generate.py + backends/: transpilers to C, C++, Java, Go, Rust, COBOL, x86-64
c/ cpp/ java/ go/ rust/      generated editions + tests
assembly/                    28 hand-written + 28 compiled assembly sorts, libc-free
machine-code/                raw x86-64 images assembled from assembly/
cobol/                       generated GnuCOBOL programs
visualizations/              GIF renderer and generated gifs/
benchmarks/  report/         measurement + report generator, data, figures
```

## Testing

```sh
cd python    && python -m pytest        # reference: correctness, stability, networks, docs consistency
python kernels/test_kernels.py          # every kernel, natively
python kernels/generate.py --check      # generated files are up to date
cd c         && make test               # C           (also: cpp, java, go, rust, assembly, machine-code, cobol)
cd cpp       && make test
cd java      && make test
cd go        && go test ./...
cd rust      && cargo test
cd assembly  && make test freestanding  # add `make memcheck` for Valgrind
cd machine-code && make test
cd cobol     && make test               # needs GnuCOBOL
```

CI runs all of them (see `.github/workflows/ci.yml`).

## Contributing a new algorithm

1. Write the kernel `kernels/algos/<name>.py` (see [kernels/README.md](kernels/README.md)) and test it with `python kernels/test_kernels.py <name>`.
2. Add a function decorated with `@algorithm(...)` in the right `python/sorting_algorithms/algos/<family>.py`, written against the `Tracked` API (`a[i]`, `a[i] = v`, `a.swap(i, j)`, `a.show(...)`, `a.commit(...)`).
3. `python kernels/generate.py`, `python -m pytest`, regenerate its GIF, then `python scripts/build_docs.py`.

## License & citation

MIT — see [LICENSE](LICENSE). Citation metadata is in [CITATION.cff](CITATION.cff).
