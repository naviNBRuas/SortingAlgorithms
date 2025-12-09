"""Aggregate exports for individual sorting algorithm modules."""
from .base import TraceFrame, SortTracer, Number
from .algos.bubble_sort import bubble_sort
from .algos.selection_sort import selection_sort
from .algos.insertion_sort import insertion_sort
from .algos.shell_sort import shell_sort
from .algos.merge_sort import merge_sort
from .algos.quick_sort import quick_sort
from .algos.heap_sort import heap_sort
from .algos.counting_sort import counting_sort
from .algos.radix_sort_lsd import radix_sort_lsd
from .algos.bucket_sort import bucket_sort
from .algos.comb_sort import comb_sort
from .algos.cocktail_shaker_sort import cocktail_shaker_sort
from .algos.odd_even_sort import odd_even_sort
from .algos.pancake_sort import pancake_sort
from .algos.stooge_sort import stooge_sort
from .algos.gnome_sort import gnome_sort
from .algos.cycle_sort import cycle_sort
from .algos.bitonic_sort import bitonic_sort
from .algos.tim_sort import tim_sort
from .algos.introsort import introsort
from .algos.smooth_sort import smooth_sort
from .algos.bogo_sort import bogo_sort
from .algos.tree_sort import tree_sort
from .algos.patience_sort import patience_sort
from .algos.strand_sort import strand_sort
from .algos.bead_sort import bead_sort
from .algos.pigeonhole_sort import pigeonhole_sort
from .algos.binary_insertion_sort import binary_insertion_sort

ALGORITHMS = {
    "bubble_sort": bubble_sort,
    "selection_sort": selection_sort,
    "insertion_sort": insertion_sort,
    "shell_sort": shell_sort,
    "merge_sort": merge_sort,
    "quick_sort": quick_sort,
    "heap_sort": heap_sort,
    "counting_sort": counting_sort,
    "radix_sort_lsd": radix_sort_lsd,
    "bucket_sort": bucket_sort,
    "comb_sort": comb_sort,
    "cocktail_shaker_sort": cocktail_shaker_sort,
    "odd_even_sort": odd_even_sort,
    "pancake_sort": pancake_sort,
    "stooge_sort": stooge_sort,
    "gnome_sort": gnome_sort,
    "cycle_sort": cycle_sort,
    "bitonic_sort": bitonic_sort,
    "tim_sort": tim_sort,
    "introsort": introsort,
    "smooth_sort": smooth_sort,
    "bogo_sort": bogo_sort,
    "tree_sort": tree_sort,
    "patience_sort": patience_sort,
    "strand_sort": strand_sort,
    "bead_sort": bead_sort,
    "pigeonhole_sort": pigeonhole_sort,
    "binary_insertion_sort": binary_insertion_sort,
}
