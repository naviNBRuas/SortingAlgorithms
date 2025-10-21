# Fibonacci (Dynamic Programming)

## Description
The Fibonacci sequence is a series of numbers where each number is the sum of the two preceding ones, usually starting with 0 and 1. Dynamic programming is an optimization technique used to solve complex problems by breaking them down into simpler subproblems and storing the results of these subproblems to avoid recomputing them.

## Time Complexity
*   **Worst-case:** O(n)
*   **Average-case:** O(n)
*   **Best-case:** O(n)

## Space Complexity
*   **Worst-case:** O(n) (for storing the DP table)

## How it works
1.  Initialize a DP table (an array) of size `n + 1`.
2.  Set the base cases: `dp[0] = 0` and `dp[1] = 1`.
3.  Iterate from `i = 2` to `n`:
    *   Calculate `dp[i] = dp[i - 1] + dp[i - 2]`.
4.  The `n`th Fibonacci number is `dp[n]`.
