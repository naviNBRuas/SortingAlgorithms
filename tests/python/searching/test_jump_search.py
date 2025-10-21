import pytest
from src.python.searching.jump_search import jump_search

def test_jump_search_found():
    arr = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
    assert jump_search(arr, 55) == 10
    assert jump_search(arr, 0) == 0
    assert jump_search(arr, 610) == 15
    assert jump_search(arr, 1) == 1 # First occurrence

def test_jump_search_not_found():
    arr = [0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 233, 377, 610]
    assert jump_search(arr, 4) == -1
    assert jump_search(arr, 100) == -1
    assert jump_search(arr, -1) == -1
    assert jump_search(arr, 700) == -1

def test_jump_search_empty_array():
    arr = []
    assert jump_search(arr, 5) == -1

def test_jump_search_single_element_array():
    arr = [5]
    assert jump_search(arr, 5) == 0
    assert jump_search(arr, 1) == -1

def test_jump_search_duplicates():
    arr = [1, 2, 2, 3, 4, 5]
    assert jump_search(arr, 2) == 1 # Should find the first occurrence

def test_jump_search_large_array():
    arr = list(range(10000))
    assert jump_search(arr, 5000) == 5000
    assert jump_search(arr, 9999) == 9999
    assert jump_search(arr, 0) == 0
    assert jump_search(arr, 10000) == -1
