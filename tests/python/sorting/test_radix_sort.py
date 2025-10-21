import pytest
from src.python.sorting.radix_sort import radix_sort

def test_radix_sort_empty():
    assert radix_sort([]) == []

def test_radix_sort_single_element():
    assert radix_sort([1]) == [1]

def test_radix_sort_sorted_array():
    assert radix_sort([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]

def test_radix_sort_reverse_sorted_array():
    assert radix_sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]

def test_radix_sort_random_array():
    arr = [170, 45, 75, 90, 802, 24, 2, 66]
    assert radix_sort(arr) == [2, 24, 45, 66, 75, 90, 170, 802]

def test_radix_sort_with_duplicates():
    arr = [170, 45, 75, 90, 802, 24, 2, 66, 45, 2]
    assert radix_sort(arr) == [2, 2, 24, 45, 45, 66, 75, 90, 170, 802]

def test_radix_sort_different_number_of_digits():
    arr = [1, 10, 100, 1000, 0]
    assert radix_sort(arr) == [0, 1, 10, 100, 1000]

def test_radix_sort_all_zeros():
    assert radix_sort([0, 0, 0]) == [0, 0, 0]
