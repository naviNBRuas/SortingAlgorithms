import sys
sys.path.append('.')
import pytest
from src.python.sorting.patience_sort import patience_sort
import numpy as np

def test_patience_sort_empty():
    arr = []
    assert patience_sort(arr) == []

def test_patience_sort_single_element():
    arr = [42]
    assert patience_sort(arr) == [42]

def test_patience_sort_sorted():
    arr = [1, 2, 3, 4, 5]
    assert np.array_equal(patience_sort(arr), [1, 2, 3, 4, 5])

def test_patience_sort_reverse_sorted():
    arr = [5, 4, 3, 2, 1]
    assert np.array_equal(patience_sort(arr), [1, 2, 3, 4, 5])

def test_patience_sort_duplicates():
    arr = [5, 4, 3, 5, 1]
    assert np.array_equal(patience_sort(arr), [1, 3, 4, 5, 5])

def test_patience_sort_random():
    arr = [64, 34, 25, 12, 22, 11, 90]
    assert np.array_equal(patience_sort(arr), [11, 12, 22, 25, 34, 64, 90])
