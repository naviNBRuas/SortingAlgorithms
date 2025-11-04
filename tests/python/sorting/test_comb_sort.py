import sys
sys.path.append('.')

from src.python.sorting.comb_sort import comb_sort

def test_comb_sort():
    # Test case 1: Unsorted list
    arr1 = [64, 34, 25, 12, 22, 11, 90]
    sorted_arr1 = sorted(arr1)
    comb_sort(arr1)
    assert arr1 == sorted_arr1

    # Test case 2: Already sorted list
    arr2 = [11, 12, 22, 25, 34, 64, 90]
    sorted_arr2 = sorted(arr2)
    comb_sort(arr2)
    assert arr2 == sorted_arr2

    # Test case 3: Reverse sorted list
    arr3 = [90, 64, 34, 25, 22, 12, 11]
    sorted_arr3 = sorted(arr3)
    comb_sort(arr3)
    assert arr3 == sorted_arr3

    # Test case 4: List with duplicate elements
    arr4 = [64, 34, 25, 12, 22, 11, 90, 34]
    sorted_arr4 = sorted(arr4)
    comb_sort(arr4)
    assert arr4 == sorted_arr4

    # Test case 5: Empty list
    arr5 = []
    sorted_arr5 = sorted(arr5)
    comb_sort(arr5)
    assert arr5 == sorted_arr5

    # Test case 6: List with one element
    arr6 = [42]
    sorted_arr6 = sorted(arr6)
    comb_sort(arr6)
    assert arr6 == sorted_arr6
