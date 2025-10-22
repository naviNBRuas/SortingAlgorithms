import pytest
from src.python.searching.fibonacci_search import fibonacci_search

def test_fibonacci_search_found():
    arr = [10, 22, 35, 40, 45, 50, 80, 82, 85, 90, 100]
    assert fibonacci_search(arr, 35) == 2
    assert fibonacci_search(arr, 10) == 0
    assert fibonacci_search(arr, 100) == 10
    assert fibonacci_search(arr, 82) == 7

def test_fibonacci_search_not_found():
    arr = [10, 22, 35, 40, 45, 50, 80, 82, 85, 90, 100]
    assert fibonacci_search(arr, 1) == -1
    assert fibonacci_search(arr, 101) == -1
    assert fibonacci_search(arr, 70) == -1

def test_fibonacci_search_empty_array():
    arr = []
    assert fibonacci_search(arr, 5) == -1

def test_fibonacci_search_single_element_array():
    arr = [5]
    assert fibonacci_search(arr, 5) == 0
    assert fibonacci_search(arr, 1) == -1

def test_fibonacci_search_duplicates():
    arr = [10, 20, 20, 30, 40, 50]
    # Fibonacci search might not always return the first occurrence for duplicates
    # We just need to ensure it returns a valid index if found.
    result = fibonacci_search(arr, 20)
    assert result == 1 or result == 2

def test_fibonacci_search_large_array():
    arr = list(range(10000))
    assert fibonacci_search(arr, 5000) == 5000
    assert fibonacci_search(arr, 9999) == 9999
    assert fibonacci_search(arr, 0) == 0
    assert fibonacci_search(arr, 10000) == -1
