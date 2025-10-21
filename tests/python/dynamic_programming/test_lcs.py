import pytest
from src.python.dynamic_programming.lcs import longest_common_subsequence

def test_lcs_empty_strings():
    assert longest_common_subsequence("", "") == 0
    assert longest_common_subsequence("abc", "") == 0
    assert longest_common_subsequence("", "def") == 0

def test_lcs_no_common_subsequence():
    assert longest_common_subsequence("abc", "def") == 0
    assert longest_common_subsequence("ace", "bdf") == 0

def test_lcs_full_common_subsequence():
    assert longest_common_subsequence("abc", "abc") == 3
    assert longest_common_subsequence("aaaaa", "aaaaa") == 5

def test_lcs_partial_common_subsequence():
    assert longest_common_subsequence("abcde", "ace") == 3
    assert longest_common_subsequence("abcdef", "acf") == 3
    assert longest_common_subsequence("AGGTAB", "GXTXAYB") == 4 # GTAB or GTYB

def test_lcs_with_duplicates():
    assert longest_common_subsequence("banana", "atana") == 4 # ana

def test_lcs_long_strings():
    s1 = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    s2 = "AXBYCZDWEFUGIHKJLMONPQRSTV"
    assert longest_common_subsequence(s1, s2) == 18
