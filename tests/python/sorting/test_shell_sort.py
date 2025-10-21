import pytest
from src.python.sorting.shell_sort import shell_sort

def test_shell_sort_empty():
    assert shell_sort([]) == []

def test_shell_sort_single_element():
    assert shell_sort([1]) == [1]

def test_shell_sort_sorted_array():
    assert shell_sort([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]

def test_shell_sort_reverse_sorted_array():
    assert shell_sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]

def test_shell_sort_random_array():
    arr = [3, 1, 4, 1, 5, 9, 2, 6, 5, 3, 5]
    assert shell_sort(arr) == [1, 1, 2, 3, 3, 4, 5, 5, 5, 6, 9]

def test_shell_sort_with_duplicates():
    assert shell_sort([5, 2, 8, 2, 5, 1]) == [1, 2, 2, 5, 5, 8]

def test_shell_sort_negative_numbers():
    assert shell_sort([-5, -2, -8, -2, -5, -1]) == [-8, -5, -5, -2, -2, -1]

def test_shell_sort_large_array():
    arr = [i for i in range(1000, 0, -1)] # Reverse sorted large array
    assert shell_sort(arr) == [i for i in range(1, 1001)]
