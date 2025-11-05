import sys
sys.path.append('.')
import pytest
from src.python.sorting.flash_sort import flash_sort
import numpy as np

def test_flash_sort_empty():
    arr = []
    assert flash_sort(arr) == []

def test_flash_sort_single_element():
    arr = [42]
    assert flash_sort(arr) == [42]

def test_flash_sort_sorted():
    arr = [1, 2, 3, 4, 5]
    assert np.array_equal(flash_sort(arr), [1, 2, 3, 4, 5])

def test_flash_sort_reverse_sorted():
    arr = [5, 4, 3, 2, 1]
    assert np.array_equal(flash_sort(arr), [1, 2, 3, 4, 5])

def test_flash_sort_duplicates():
    arr = [5, 4, 3, 5, 1]
    assert np.array_equal(flash_sort(arr), [1, 3, 4, 5, 5])

def test_flash_sort_random():
    arr = [64, 34, 25, 12, 22, 11, 90]
    assert np.array_equal(flash_sort(arr), [11, 12, 22, 25, 34, 64, 90])
