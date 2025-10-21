import pytest
from src.python.searching.binary_search import binary_search

def test_binary_search_found():
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    assert binary_search(arr, 5) == 4
    assert binary_search(arr, 1) == 0
    assert binary_search(arr, 10) == 9

def test_binary_search_not_found():
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    assert binary_search(arr, 11) == -1
    assert binary_search(arr, 0) == -1

def test_binary_search_empty_array():
    arr = []
    assert binary_search(arr, 5) == -1

def test_binary_search_single_element_array():
    arr = [5]
    assert binary_search(arr, 5) == 0
    assert binary_search(arr, 1) == -1

def test_binary_search_duplicates():
    arr = [1, 2, 2, 3, 4, 5]
    assert binary_search(arr, 2) in [1, 2] # Can return either index 1 or 2
