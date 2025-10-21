# 0/1 Knapsack Problem

## Description
The 0/1 Knapsack problem is a classic combinatorial optimization problem. Given a set of items, each with a weight and a value, determine the number of each item to include in a collection so that the total weight is less than or equal to a given capacity and the total value is as large as possible. The "0/1" signifies that each item can either be entirely included (1) or not included at all (0); you cannot take a fraction of an item.

## Time Complexity
*   **Worst-case:** O(nW) (where n is the number of items and W is the knapsack capacity)

## Space Complexity
*   **Worst-case:** O(nW) (for the DP table)

## How it works (Dynamic Programming Approach)
1.  **Create a DP table:** Initialize a 2D array, `dp`, of size `(n+1) x (W+1)`, where `n` is the number of items and `W` is the knapsack capacity. `dp[i][w]` will store the maximum value that can be obtained with a knapsack of capacity `w` using items up to index `i-1`.
2.  **Initialization:** The first row and first column of the `dp` table are initialized to 0, as a knapsack with 0 capacity or with 0 items can hold no value.
3.  **Fill the DP table:** Iterate through the items (from `i = 1` to `n`) and for each item, iterate through possible capacities (from `w = 1` to `W`):
    *   **If the weight of the current item (`weights[i-1]`) is less than or equal to the current capacity `w`:**
        *   You have two choices:
            *   **Include the item:** The value would be `values[i-1]` (value of current item) + `dp[i-1][w - weights[i-1]]` (maximum value from previous items with remaining capacity).
            *   **Exclude the item:** The value would be `dp[i-1][w]` (maximum value from previous items without the current item).
        *   `dp[i][w]` is the maximum of these two choices.
    *   **If the weight of the current item is greater than the current capacity `w`:**
        *   You cannot include the item. So, `dp[i][w]` is simply `dp[i-1][w]`.
4.  **Result:** The maximum value that can be put in the knapsack is `dp[n][W]`.
