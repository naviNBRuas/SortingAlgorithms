import sys
sys.path.append('.')
import pytest
from src.python.sorting.american_flag_sort import american_flag_sort
import numpy as np

def test_american_flag_sort_empty():
    arr = []
    assert american_flag_sort(arr) == []

def test_american_flag_sort_single_element():
    arr = [42]
    assert american_flag_sort(arr) == [42]

def test_american_flag_sort_sorted():
    arr = [1, 2, 3, 4, 5]
    assert np.array_equal(american_flag_sort(arr), [1, 2, 3, 4, 5])

def test_american_flag_sort_reverse_sorted():
    arr = [5, 4, 3, 2, 1]
    assert np.array_equal(american_flag_sort(arr), [1, 2, 3, 4, 5])

def test_american_flag_sort_duplicates():
    arr = [5, 4, 3, 5, 1]
    assert np.array_equal(american_flag_sort(arr), [1, 3, 4, 5, 5])

def test_american_flag_sort_random():
    arr = [64, 34, 25, 12, 22, 11, 90]
    assert np.array_equal(american_flag_sort(arr), [11, 12, 22, 25, 34, 64, 90])

def test_american_flag_sort_large_numbers():
    arr = [12345, 67890, 123, 4567, 89012, 3456]
    assert np.array_equal(american_flag_sort(arr), [123, 3456, 4567, 12345, 67890, 89012])
