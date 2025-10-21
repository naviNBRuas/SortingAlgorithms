def longest_common_subsequence(text1, text2):
    """
    Finds the length of the longest common subsequence of two strings.

    Args:
        text1 (str): The first string.
        text2 (str): The second string.

    Returns:
        int: The length of the longest common subsequence.
    """
    m = len(text1)
    n = len(text2)

    # dp[i][j] stores the length of LCS of text1[0...i-1] and text2[0...j-1]
    dp = [[0] * (n + 1) for _ in range(m + 1)]

    for i in range(1, m + 1):
        for j in range(1, n + 1):
            if text1[i - 1] == text2[j - 1]:
                dp[i][j] = 1 + dp[i - 1][j - 1]
            else:
                dp[i][j] = max(dp[i - 1][j], dp[i][j - 1])

    return dp[m][n]
