def fibonacci_dp(n):
    """
    Calculates the nth Fibonacci number using dynamic programming.

    Args:
        n (int): The index of the Fibonacci number to calculate (n >= 0).

    Returns:
        int: The nth Fibonacci number.
    """
    if n < 0:
        raise ValueError("Input must be a non-negative integer.")
    elif n <= 1:
        return n

    dp = [0] * (n + 1)
    dp[1] = 1

    for i in range(2, n + 1):
        dp[i] = dp[i - 1] + dp[i - 2]

    return dp[n]
