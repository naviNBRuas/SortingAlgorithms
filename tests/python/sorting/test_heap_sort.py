import pytest
from src.python.sorting.heap_sort import heap_sort

def test_heap_sort_empty():
    assert heap_sort([]) == []

def test_heap_sort_single_element():
    assert heap_sort([1]) == [1]

def test_heap_sort_sorted_array():
    assert heap_sort([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]

def test_heap_sort_reverse_sorted_array():
    assert heap_sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]

def test_heap_sort_random_array():
    arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    assert heap_sort(arr) == [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

def test_heap_sort_with_duplicates():
    assert heap_sort([5, 2, 8, 2, 5, 1]) == [1, 2, 2, 5, 5, 8]

def test_heap_sort_negative_numbers():
    assert heap_sort([-5, -2, -8, -2, -5, -1]) == [-8, -5, -5, -2, -2, -1]
