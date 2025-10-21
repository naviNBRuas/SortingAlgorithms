# Longest Common Subsequence (LCS)

## Description
The Longest Common Subsequence (LCS) problem is a classic problem in computer science, often used to illustrate the power of dynamic programming. Given two sequences, find the length of the longest subsequence present in both of them. A subsequence is a sequence that can be derived from another sequence by deleting some or no elements without changing the order of the remaining elements.

## Time Complexity
*   **Worst-case:** O(mn) (where m and n are the lengths of the two sequences)

## Space Complexity
*   **Worst-case:** O(mn) (for the DP table)

## How it works
1.  Create a 2D DP table, `dp`, where `dp[i][j]` will store the length of the LCS of `text1[0...i-1]` and `text2[0...j-1]`.
2.  Initialize the first row and first column of the `dp` table to 0, as an empty string has no common subsequence with any other string.
3.  Iterate through the strings:
    *   If `text1[i-1]` (current character in `text1`) is equal to `text2[j-1]` (current character in `text2`):
        *   `dp[i][j] = 1 + dp[i-1][j-1]` (the LCS length increases by 1, including the current matching character).
    *   If `text1[i-1]` is not equal to `text2[j-1]`:
        *   `dp[i][j] = max(dp[i-1][j], dp[i][j-1])` (take the maximum LCS length obtained by excluding either the current character from `text1` or `text2`).
4.  The value `dp[m][n]` (where m and n are the lengths of `text1` and `text2` respectively) will contain the length of the LCS of the two strings.
