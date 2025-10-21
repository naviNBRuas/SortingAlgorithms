import pytest
from src.python.dynamic_programming.knapsack_01 import knapsack_01

def test_knapsack_01_basic():
    weights = [1, 2, 3]
    values = [6, 10, 12]
    capacity = 5
    assert knapsack_01(weights, values, capacity) == 22  # Items 2 and 3 (weights 2+3=5, values 10+12=22)

def test_knapsack_01_empty_items():
    weights = []
    values = []
    capacity = 10
    assert knapsack_01(weights, values, capacity) == 0

def test_knapsack_01_zero_capacity():
    weights = [1, 2, 3]
    values = [6, 10, 12]
    capacity = 0
    assert knapsack_01(weights, values, capacity) == 0

def test_knapsack_01_no_items_fit():
    weights = [10, 20, 30]
    values = [60, 100, 120]
    capacity = 5
    assert knapsack_01(weights, values, capacity) == 0

def test_knapsack_01_all_items_fit():
    weights = [1, 2, 3]
    values = [6, 10, 12]
    capacity = 6
    assert knapsack_01(weights, values, capacity) == 28  # Items 1, 2, 3 (weights 1+2+3=6, values 6+10+12=28)

def test_knapsack_01_complex():
    weights = [2, 3, 4, 5]
    values = [3, 4, 5, 6]
    capacity = 5
    assert knapsack_01(weights, values, capacity) == 7  # Items 2 and 3 (weights 2+3=5, values 3+4=7)

def test_knapsack_01_another_complex():
    weights = [10, 20, 30]
    values = [60, 100, 120]
    capacity = 50
    assert knapsack_01(weights, values, capacity) == 220 # Items 20 and 30 (weights 20+30=50, values 100+120=220)

def test_knapsack_01_single_item_fits():
    weights = [10, 20, 30]
    values = [60, 100, 120]
    capacity = 15
    assert knapsack_01(weights, values, capacity) == 60 # Item 10 (weight 10, value 60)
