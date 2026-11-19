"""Teaching notes for every algorithm: the key idea / invariant ('how') and practical advice ('use').

Consumed by scripts/build_docs.py to generate the README gallery, and checked by the test-suite for completeness.
"""

NOTES = {
    # ------------------------------------------------------------------ exchange
    "bubble_sort": (
        "Invariant: after pass *i* the *i* largest elements sit in their final places at the right end. Each pass bubbles the current maximum rightward by swapping adjacent inversions; a pass with no swap proves the array is sorted.",
        "Teaching and tiny inputs only. The early exit makes it linear on already-sorted data, but even insertion sort beats it on nearly everything else because bubble sort performs far more writes."),
    "cocktail_shaker_sort": (
        "Alternates a left-to-right pass (pushing the maximum to the right) with a right-to-left pass (pulling the minimum to the left), shrinking the unsorted window from both ends.",
        "Better than bubble sort when small elements start near the end ('turtles'), but still quadratic. A teaching example of a simple optimisation."),
    "odd_even_sort": (
        "Alternately compare-exchanges all (odd, even) neighbour pairs and then all (even, odd) pairs. Inside one phase every pair is independent, so the phase can run in parallel.",
        "Interesting on parallel hardware (mesh processors, SIMD) where each phase is one step; sequentially it is just a slow bubble-sort variant."),
    "comb_sort": (
        "Bubble sort that compares elements a *gap* apart, shrinking the gap by a factor of about 1.3 each pass. Large gaps move small values near the end ('turtles') quickly, so the final gap-1 passes have little left to do.",
        "A surprisingly good O(n log n)-ish sort for a dozen lines of code. Not stable and with no worst-case guarantee better than O(n²), so prefer a real library sort in production."),
    "gnome_sort": (
        "A single pointer walks right while neighbours are in order; on an inversion it swaps and steps back, exactly like a garden gnome sorting flower pots. It is insertion sort expressed as one loop.",
        "Teaching and code golf. Quadratic, but the simplest correct sorting loop there is."),
    "exchange_sort": (
        "For each position *i*, compare with every later position and swap whenever the pair is inverted, so position *i* ends up holding the minimum of the suffix.",
        "A simpler (and slower) cousin of selection sort that swaps far more often. Only useful as a baseline."),
    "circle_sort": (
        "Compare the first element with the last, the second with the second-last, and so on, then recurse on both halves; repeat the whole procedure until a pass makes no swap.",
        "A curiosity with a neat recursive structure and O(n log² n) behaviour; not competitive with merge or quick sort."),
    "quick_sort": (
        "Pick the last element as pivot; Lomuto's scan keeps `[lo, i)` ≤ pivot and `[i, j)` > pivot, then drops the pivot between them. The pivot is now final; recurse on both sides.",
        "The default O(n log n) workhorse, but with an end pivot it degrades to O(n²) on sorted input (see the benchmark report). Use a median-of-three/random pivot or intro sort for real data."),
    "quick_sort_hoare": (
        "Two indices walk toward each other from both ends around a middle pivot, swapping out-of-place pairs where they stop. Hoare's scheme does about a third of Lomuto's swaps and is not hurt by sorted input (the middle element is a good pivot).",
        "The better classic quicksort partition. Still O(n²) in contrived worst cases and unstable."),
    "quick_sort_3way": (
        "Dutch-national-flag partition into `< pivot`, `= pivot`, `> pivot`. All keys equal to the pivot are finished at once, so inputs with few distinct keys become linear.",
        "Use when there are many duplicates (log levels, grades, categories). It does slightly more work than 2-way quicksort on distinct keys."),
    "quick_sort_dual_pivot": (
        "Two pivots p ≤ q split the range into `< p`, `p..q`, `> q`; three recursive calls follow. The scheme behind Java's `Arrays.sort` for primitives, which sample five elements to choose pivots.",
        "Often faster than single-pivot quicksort thanks to fewer cache misses. This version takes the end elements as pivots, so sorted input is quadratic: pick pivots by sampling in real code."),
    "stooge_sort": (
        "Sort the first two thirds, then the last two thirds, then the first two thirds again. Correctness: after the first two steps the largest third is at the end; the third step fixes the rest.",
        "Never use it. It is a classic example of a *correct but absurdly slow* recursion (Θ(n^2.71)) used to teach recurrence analysis."),
    "slow_sort": (
        "'Multiply and surrender': recursively sort both halves, move the maximum to the end, then recurse on everything but the last element. It deliberately wastes work.",
        "A joke algorithm from the paper on *pessimal* algorithms; its running time is super-polynomial. Included to show how bad correct can be."),
    "pancake_sort": (
        "The only allowed operation is reversing a prefix (a spatula flip). Bring the largest unsorted pancake to the top with one flip, then flip it down to its place with another.",
        "A theoretical puzzle (burnt pancake problem, prefix reversals in genomes and interconnection networks). Uses at most 2n − 3 flips."),
    "bogo_sort": (
        "Shuffle the array; if it is sorted, stop; otherwise shuffle again. Expected n! attempts.",
        "Pure comedy and a vivid illustration of probabilistic algorithms. Capped by `max_shuffles` here so it always terminates."),
    "bozo_sort": (
        "Pick two random positions, swap them, check whether the array is sorted, repeat. Even less strategic than bogo sort.",
        "As above: a humorous baseline. Expected running time is still factorial."),
    "permutation_sort": (
        "Walks through all permutations in lexicographic order and stops at the first sorted one. Because the permutations are of *positions*, equal keys keep their original order, which makes it stable.",
        "Only for n ≤ 8 or so: O(n·n!). Useful for explaining brute-force search over the permutation space."),
    # ------------------------------------------------------------------ selection
    "selection_sort": (
        "Repeatedly select the minimum of the unsorted suffix and swap it to the front. Exactly n − 1 swaps, however the data is arranged.",
        "The right choice when *writes* are expensive (flash, EEPROM) and n is small, because it performs the fewest swaps of the simple sorts. Quadratic comparisons always."),
    "double_selection_sort": (
        "Each pass finds both the minimum and the maximum of the unsorted window and places them at the two ends, halving the number of passes.",
        "A constant-factor improvement on selection sort; same asymptotics."),
    "bingo_sort": (
        "Like selection sort, but each pass moves *every* copy of the current maximum to the end, then the next-largest value ('bingo!') becomes the target. Few distinct values means few passes.",
        "A fine fit for inputs with a small number of distinct keys (O(n·k)), but 3-way quicksort or counting sort are usually better."),
    "cycle_sort": (
        "Permutation theory: every permutation decomposes into cycles. Count how many elements are smaller than the cycle's first item to find where it belongs, drop it there, pick up the displaced item, and repeat until the cycle closes. Each element is written at most once.",
        "Optimal when the *number of writes* matters (EEPROM, flash with limited erase cycles). Its O(n²) comparisons make it slow otherwise."),
    "heap_sort": (
        "Build a max-heap in place (a binary tree stored in the array where every parent ≥ its children), then repeatedly swap the root with the last element of the heap and sift it down.",
        "In-place O(n log n) with a guaranteed worst case and no extra memory, which is why it is the fallback inside intro sort. Poor cache behaviour makes it slower than quicksort in practice and it is unstable."),
    "smooth_sort": (
        "Dijkstra's heap sort over a *forest of Leonardo heaps* (trees whose sizes are Leonardo numbers). The forest's shape adapts to presortedness, so sorted input costs only O(n) while the worst case stays O(n log n).",
        "The in-place sort to pick when data is often nearly sorted *and* a worst-case bound matters. Complex to implement correctly; the bookkeeping is the whole difficulty."),
    "tournament_sort": (
        "Play a knockout tournament over all elements (winner tree). The overall winner is the minimum; remove it and replay only its leaf-to-root path (O(log n)) to find the next.",
        "The idea behind *replacement selection*, used to build the initial sorted runs for external merge sort."),
    "weak_heap_sort": (
        "A weak heap relaxes the heap condition (only the right subtree must be ≤ the root) and uses one extra bit per node to decide which child is 'right'. Merging two weak heaps takes exactly one comparison.",
        "Nearly optimal comparison counts for a heap-based in-place sort; a good fit when comparisons are expensive."),
    "bottom_up_heap_sort": (
        "Standard heap sort spends two comparisons per level on sift-down. Wegener's variant first walks down along the larger children to a leaf (one comparison per level), then climbs back up to find the key's slot.",
        "Saves roughly half the comparisons of ordinary heap sort — a real win when comparing is costly (strings, objects)."),
    "ternary_heap_sort": (
        "Uses a 3-ary heap: each node has three children, so the tree is log₃ n levels deep. Fewer levels, but more comparisons to pick the best child at each.",
        "Illustrates the d-ary heap trade-off between depth and fan-out; 3-ary and 4-ary heaps often beat binary ones in practice thanks to cache locality."),
    "enumeration_sort": (
        "Compute each element's final *rank* by counting how many elements precede it (ties broken by index), then place it directly at that position.",
        "The classic parallel sort: every rank can be computed independently, so n² processors sort in O(1) steps. Sequentially it is plain O(n²)."),
    # ------------------------------------------------------------------ insertion
    "insertion_sort": (
        "Maintain a sorted prefix. Take the next element, shift larger prefix elements one place right, and drop it into the gap. Its cost is proportional to the number of *inversions* in the input.",
        "The best simple sort: tiny constant factors, stable, in-place, adaptive. Use it for small arrays (< ~16 elements) and for finishing nearly-sorted data; every serious hybrid sort calls it for small ranges."),
    "binary_insertion_sort": (
        "Same as insertion sort, but binary-search the sorted prefix for the insertion point. That cuts comparisons to O(n log n), though shifting elements is still O(n²).",
        "Worth it when comparisons are expensive and moves are cheap. TimSort uses it to extend short runs."),
    "shell_sort": (
        "Run insertion sort on elements *g* apart for a decreasing sequence of gaps (here n/2, n/4, …, 1). Early large-gap passes move elements long distances cheaply, so the final gap-1 pass finds the array almost sorted.",
        "A compact in-place sort with O(n^1.5)-ish behaviour; very popular in embedded code because it needs no recursion or extra memory."),
    "shell_sort_ciura": (
        "Shell sort with Ciura's empirically derived gap sequence 1, 4, 10, 23, 57, 132, 301, 701 (extended by ×2.25). The gap sequence is the whole game: well-chosen gaps give the best known average-case performance.",
        "The fastest practical Shell sort; the gap sequence has never been proven optimal."),
    "tree_sort": (
        "Insert every element into a binary search tree, then read the tree out with an in-order traversal. Equal keys go right, so it is stable.",
        "Illustrates how a data structure *is* a sorting algorithm. Without balancing it degrades to O(n²) on sorted input (compare AVL tree sort)."),
    "avl_tree_sort": (
        "Tree sort on a self-balancing AVL tree: after each insert, rotations keep the subtree heights within 1 of each other, guaranteeing O(log n) inserts.",
        "A guaranteed O(n log n), stable tree sort. Allocation-heavy, so it loses to array-based sorts, but it also supports *online* insertion."),
    "patience_sort": (
        "Deal elements onto piles as in the card game Patience: put each on the leftmost pile whose top is ≥ it (binary search), or start a new pile. The number of piles equals the length of the longest increasing subsequence; merging the piles yields the sorted order.",
        "Beyond sorting, it computes the LIS in O(n log n); it is also the basis of the merge phase in external sorting."),
    "ford_johnson_sort": (
        "Merge-insertion: pair up elements, recursively sort the winners, then binary-insert the losers in an order given by Jacobsthal numbers so that each binary search covers at most 2^k − 1 candidates.",
        "Uses the fewest comparisons of any known comparison sort for small n (optimal up to n = 22). Wildly impractical otherwise because of the data movement."),
    "library_sort": (
        "Insertion sort into an array with *gaps* (like a librarian leaving shelf space). Binary-search for the position, insert into a nearby gap, and re-spread the elements whenever the filled portion doubles.",
        "Shows how leaving slack turns O(n²) insertion into expected O(n log n). Complicated, so rarely used in practice."),
    "cartesian_tree_sort": (
        "Build a Cartesian tree (a heap-ordered binary tree whose in-order traversal is the input) in O(n) with a stack, then emit elements by popping from a priority queue that holds only the current frontier of the tree.",
        "An *adaptive* sort: the fewer 'ups and downs' in the input, the smaller the queue stays, down to O(n) for sorted data."),
    # ------------------------------------------------------------------ merge
    "merge_sort": (
        "Split in half, sort each half recursively, then merge the two sorted halves by repeatedly taking the smaller front element. The merge is linear and stable.",
        "The reference stable O(n log n) sort with guaranteed worst case; ideal for linked lists and external (disk) sorting. Needs O(n) extra memory for arrays."),
    "merge_sort_bottom_up": (
        "Iterative merge sort: merge adjacent runs of width 1, then 2, 4, 8, … until one run remains. No recursion at all.",
        "Same guarantees as top-down merge sort with a loop-only structure that suits embedded code and parallel scheduling."),
    "in_place_merge_sort": (
        "Merges without a buffer: pick the middle of the larger run, binary-search its position in the other run, *rotate* the blocks (three reversals) so they swap places, then recurse on both sides.",
        "Use when stable sorting is required but extra memory is not available; costs an extra log n factor (O(n log² n)). Go's `sort.Stable` uses this idea."),
    "strand_sort": (
        "Repeatedly pull an ascending *strand* out of the input (the first element plus every later element that extends it) and merge the strand into the output list.",
        "Adaptive: a nearly sorted input yields a few very long strands. Natural fit for linked lists."),
    "tim_sort": (
        "Find *natural runs* (ascending or strictly descending stretches), extend short ones to a minimum length with binary insertion, and merge runs on a stack whose invariants keep merges balanced. (Galloping mode is omitted here.)",
        "What you almost certainly run: Python's `sorted`, Java's object sort, Android and Rust's stable sort. Linear on presorted data, stable, O(n log n) worst case."),
    "intro_sort": (
        "Quicksort with a median-of-three pivot that counts recursion depth. If the depth exceeds 2·log₂ n it switches to heap sort (guaranteeing O(n log n)), and small ranges are finished with insertion sort.",
        "The engine of C++'s `std::sort`. Fast on average like quicksort but without its worst case; not stable."),
    # ------------------------------------------------------------------ distribution
    "counting_sort": (
        "Count how often each key occurs, turn the counts into starting positions with a prefix sum, then place every element at its key's next free slot. Never compares two elements.",
        "Unbeatable for integers in a small range (O(n + k)). It is also the stable subroutine inside radix sort. Useless when k ≫ n."),
    "pigeonhole_sort": (
        "One 'hole' per possible key value: drop each element into its hole, then read the holes back in order.",
        "Counting sort's simpler cousin for when keys are dense; as with counting sort, the key range must be small."),
    "radix_sort_lsd": (
        "Sort by the least significant digit first using a *stable* counting sort per digit, then the next digit, and so on. Stability makes later passes preserve earlier work, so after the last pass the keys are sorted.",
        "Excellent for fixed-width integers and strings: d passes of O(n + b). Needs extra memory and is typically cache-hostile on huge arrays."),
    "radix_sort_msd": (
        "Bucket by the most significant digit, then recursively sort each bucket by the next digit. Buckets are independent, so small ones can switch to insertion sort.",
        "Great for variable-length keys such as strings, where it can stop as soon as buckets are unique (the idea behind burst sort and trie-based sorting)."),
    "american_flag_sort": (
        "An in-place MSD radix sort: count digit frequencies to learn each bucket's boundaries, then permute elements into place with *cycle-leader* swaps (as in the Dutch national flag problem).",
        "A memory-lean radix sort (O(1)-ish extra space per level) used for sorting strings in place. Unstable."),
    "bucket_sort": (
        "Scatter elements into *n* equal-width buckets over [min, max]; with uniformly spread keys each bucket holds about one element. Sort each bucket (insertion sort) and concatenate.",
        "Linear expected time for uniformly distributed real numbers; degrades to O(n²) if everything lands in one bucket."),
    "bead_sort": (
        "Each number is a row of beads on vertical rods; let gravity pull the beads down. The rows that appear are the numbers in sorted order. The simulation counts beads per level.",
        "A beautiful analogue-computing idea that is O(n) on a physical device; in software it costs O(S) (the sum of the inputs), so it is only a demonstration."),
    "flash_sort": (
        "Estimate each key's final position by linear interpolation between min and max, count how many keys fall in each of ~0.43n classes, permute elements into their classes in place, then finish with a cheap insertion sort.",
        "Close to linear on uniformly distributed data with very little extra memory. Sensitive to skewed distributions."),
    "sleep_sort": (
        "Each element 'sleeps' for a time proportional to its value and is output on waking, so smaller values wake first. Here the clock is simulated tick by tick.",
        "A famous joke: it works only if timing is exact, and it is secretly a counting sort over time. Here to illustrate the idea, not to use."),
    # ------------------------------------------------------------------ networks
    "bitonic_sort": (
        "A sorting *network*: a fixed schedule of compare-exchange operations that does not depend on the data. It builds ever-longer bitonic (up-then-down) sequences, then merges them with half-cleaner stages.",
        "The sort of choice for GPUs, FPGAs and SIMD, where a data-independent schedule maps directly to parallel hardware. O(log² n) parallel depth."),
    "odd_even_merge_sort": (
        "Batcher's other classic network: recursively merge sorted halves with an *odd–even merge* (merge the odd-indexed and even-indexed elements separately, then fix up neighbours with one comparator layer).",
        "Fewer comparators than bitonic sort for the same size; used in hardware sorters and as the basis of many parallel sorts."),
    "pairwise_sorting_network": (
        "Parberry's pairwise network first compares elements 1, 2, 4, … apart to build sorted pairs of pairs, then merges them with a second, regular pattern of comparators.",
        "Same O(n log² n) size as Batcher's networks but with a simpler, more regular structure that is easy to lay out in hardware."),
}
