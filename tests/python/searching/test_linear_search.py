import pytest
from src.python.searching.linear_search import linear_search

def test_linear_search_found():
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    assert linear_search(arr, 5) == 4
    assert linear_search(arr, 1) == 0
    assert linear_search(arr, 10) == 9

def test_linear_search_not_found():
    arr = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    assert linear_search(arr, 11) == -1
    assert linear_search(arr, 0) == -1

def test_linear_search_empty_array():
    arr = []
    assert linear_search(arr, 5) == -1

def test_linear_search_single_element_array():
    arr = [5]
    assert linear_search(arr, 5) == 0
    assert linear_search(arr, 1) == -1

def test_linear_search_duplicates():
    arr = [1, 2, 2, 3, 4, 5]
    assert linear_search(arr, 2) == 1 # Linear search returns the first occurrence
