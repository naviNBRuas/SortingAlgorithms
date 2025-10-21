import pytest
from src.python.sorting.bucket_sort import bucket_sort

def test_bucket_sort_empty():
    assert bucket_sort([]) == []

def test_bucket_sort_single_element():
    assert bucket_sort([1]) == [1]

def test_bucket_sort_sorted_array():
    assert bucket_sort([1, 2, 3, 4, 5]) == [1, 2, 3, 4, 5]

def test_bucket_sort_reverse_sorted_array():
    assert bucket_sort([5, 4, 3, 2, 1]) == [1, 2, 3, 4, 5]

def test_bucket_sort_random_array():
    arr = [0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434]
    assert bucket_sort(arr) == sorted(arr)

def test_bucket_sort_with_duplicates():
    arr = [0.897, 0.565, 0.656, 0.1234, 0.665, 0.3434, 0.565]
    assert bucket_sort(arr) == sorted(arr)

def test_bucket_sort_integers():
    arr = [7, 2, 9, 1, 5, 3, 8, 4, 6]
    assert bucket_sort(arr) == sorted(arr)

def test_bucket_sort_negative_numbers():
    arr = [-5, -2, -8, -1, -5, -3]
    assert bucket_sort(arr) == sorted(arr)

def test_bucket_sort_all_same_elements():
    arr = [3, 3, 3, 3, 3]
    assert bucket_sort(arr) == [3, 3, 3, 3, 3]
