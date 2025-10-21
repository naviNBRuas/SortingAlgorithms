import pytest
from src.python.searching.exponential_search import exponential_search

def test_exponential_search_found():
    arr = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
    assert exponential_search(arr, 55) == 10
    assert exponential_search(arr, 0) == 0
    assert exponential_search(arr, 610) == 15
    assert exponential_search(arr, 1) == 1 # First occurrence

def test_exponential_search_not_found():
    arr = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
    assert exponential_search(arr, 4) == -1
    assert exponential_search(arr, 100) == -1
    assert exponential_search(arr, -1) == -1
    assert exponential_search(arr, 700) == -1

def test_exponential_search_empty_array():
    arr = []
    assert exponential_search(arr, 5) == -1

def test_exponential_search_single_element_array():
    arr = [5]
    assert exponential_search(arr, 5) == 0
    assert exponential_search(arr, 1) == -1

def test_exponential_search_duplicates():
    arr = [1, 2, 2, 3, 4, 5]
    assert exponential_search(arr, 2) == 1 # Should find the first occurrence

def test_exponential_search_large_array():
    arr = list(range(10000))
    assert exponential_search(arr, 5000) == 5000
    assert exponential_search(arr, 9999) == 9999
    assert exponential_search(arr, 0) == 0
    assert exponential_search(arr, 10000) == -1
