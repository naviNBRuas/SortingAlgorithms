import sys
sys.path.append('.')
import pytest
from src.python.sorting.introsort import introsort
import numpy as np

def test_introsort_empty():
    arr = []
    assert introsort(arr) == []

def test_introsort_single_element():
    arr = [42]
    assert introsort(arr) == [42]

def test_introsort_sorted():
    arr = [1, 2, 3, 4, 5]
    assert np.array_equal(introsort(arr), [1, 2, 3, 4, 5])

def test_introsort_reverse_sorted():
    arr = [5, 4, 3, 2, 1]
    assert np.array_equal(introsort(arr), [1, 2, 3, 4, 5])

def test_introsort_duplicates():
    arr = [5, 4, 3, 5, 1]
    assert np.array_equal(introsort(arr), [1, 3, 4, 5, 5])

def test_introsort_random():
    arr = [64, 34, 25, 12, 22, 11, 90]
    assert np.array_equal(introsort(arr), [11, 12, 22, 25, 34, 64, 90])
