def knapsack_01(weights, values, capacity):
    """
    Solves the 0/1 Knapsack problem using dynamic programming.

    Args:
        weights (list): A list of weights of items.
        values (list): A list of values of items.
        capacity (int): The maximum capacity of the knapsack.

    Returns:
        int: The maximum value that can be put in the knapsack.
    """
    n = len(weights)
    # dp[i][w] will store the maximum value that can be obtained with a knapsack
    # of capacity w and considering items up to index i-1.
    dp = [[0 for _ in range(capacity + 1)] for _ in range(n + 1)]

    for i in range(1, n + 1):
        for w in range(1, capacity + 1):
            # If current item's weight is less than or equal to current knapsack capacity
            if weights[i - 1] <= w:
                # Option 1: Include the current item
                # value of current item + max value of remaining capacity with previous items
                include_item = values[i - 1] + dp[i - 1][w - weights[i - 1]]
                # Option 2: Exclude the current item
                exclude_item = dp[i - 1][w]
                dp[i][w] = max(include_item, exclude_item)
            else:
                # If current item's weight is more than current knapsack capacity, exclude it
                dp[i][w] = dp[i - 1][w]

    return dp[n][capacity]
