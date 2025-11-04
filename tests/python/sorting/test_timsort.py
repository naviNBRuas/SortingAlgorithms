import pytest
from src.python.sorting.timsort import timsort

def test_timsort_empty():
    assert timsort([]) == []

def test_timsort_single_element():
    assert timsort([1]) == [1]

def test_timsort_sorted_array():
    assert timsort([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]

def test_timsort_reverse_sorted_array():
    assert timsort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]

def test_timsort_random_array():
    arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    assert timsort(arr) == [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

def test_timsort_with_duplicates():
    assert timsort([5, 2, 8, 2, 5, 1]) == [1, 2, 2, 5, 5, 8]

def test_timsort_negative_numbers():
    assert timsort([-5, -2, -8, -2, -5, -1]) == [-8, -5, -5, -2, -2, -1]

def test_timsort_large_array():
    arr = [i for i in range(1000, 0, -1)] # Reverse sorted large array
    assert timsort(arr) == [i for i in range(1, 1001)]

def test_timsort_already_sorted_large_array():
    arr = [i for i in range(1, 1001)]
    assert timsort(arr) == [i for i in range(1, 1001)]

def test_timsort_with_zeros():
    assert timsort([0, 0, 0, 0, 0]) == [0, 0, 0, 0, 0]

def test_timsort_mixed_numbers():
    assert timsort([-3, 0, 5, -1, 2, -2, 4]) == [-3, -2, -1, 0, 2, 4, 5]
