import pytest
from sorting_algorithms import (
    bubble_sort, selection_sort, insertion_sort, shell_sort, merge_sort,
    quick_sort, heap_sort, counting_sort, radix_sort_lsd, bucket_sort,
    comb_sort, cocktail_shaker_sort, odd_even_sort, pancake_sort, stooge_sort,
    gnome_sort, cycle_sort, bitonic_sort,
    tim_sort, introsort, smooth_sort, bogo_sort,
    tree_sort, patience_sort, strand_sort, bead_sort, pigeonhole_sort,
    binary_insertion_sort
)

ALL_FUNCS = [
    bubble_sort, selection_sort, insertion_sort, shell_sort, merge_sort,
    quick_sort, heap_sort, counting_sort, radix_sort_lsd, bucket_sort,
    comb_sort, cocktail_shaker_sort, odd_even_sort, pancake_sort, stooge_sort,
    gnome_sort, cycle_sort, bitonic_sort,
    tim_sort, introsort, smooth_sort,
    tree_sort, patience_sort, strand_sort, bead_sort, pigeonhole_sort,
    binary_insertion_sort,
]

def check_sorted(func):
    data = [5, 3, 8, 1, 2, 9, 5, 0, -1]
    result = func(data)
    assert result == sorted(data)

@pytest.mark.parametrize("func", ALL_FUNCS)
def test_sorts(func):
    check_sorted(func)

def test_bogo_sort_max_shuffles():
    with pytest.raises(RuntimeError):
        bogo_sort([3, 2, 1], max_shuffles=5)
