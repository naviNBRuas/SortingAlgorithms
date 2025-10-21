import pytest
from src.python.dynamic_programming.fibonacci import fibonacci_dp

def test_fibonacci_dp_base_cases():
    assert fibonacci_dp(0) == 0
    assert fibonacci_dp(1) == 1

def test_fibonacci_dp_small_numbers():
    assert fibonacci_dp(2) == 1
    assert fibonacci_dp(3) == 2
    assert fibonacci_dp(4) == 3
    assert fibonacci_dp(5) == 5

def test_fibonacci_dp_larger_numbers():
    assert fibonacci_dp(10) == 55
    assert fibonacci_dp(15) == 610
    assert fibonacci_dp(20) == 6765

def test_fibonacci_dp_invalid_input():
    with pytest.raises(ValueError):
        fibonacci_dp(-1)
    with pytest.raises(ValueError):
        fibonacci_dp(-5)
