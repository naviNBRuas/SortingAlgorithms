import sys
sys.path.append('.')
import pytest
from src.python.sorting.bogo_sort import bogo_sort
import numpy as np

def test_bogo_sort_empty():
    arr = []
    assert bogo_sort(arr) == []

def test_bogo_sort_single_element():
    arr = [42]
    assert bogo_sort(arr) == [42]

def test_bogo_sort_two_elements_sorted():
    arr = [1, 2]
    assert np.array_equal(bogo_sort(arr), [1, 2])

def test_bogo_sort_two_elements_reverse_sorted():
    arr = [2, 1]
    assert np.array_equal(bogo_sort(arr), [1, 2])

def test_bogo_sort_small_random():
    arr = [3, 1, 2]
    assert np.array_equal(bogo_sort(arr), [1, 2, 3])

# Caution: Do not add larger arrays for Bogo Sort, as it is extremely inefficient.
