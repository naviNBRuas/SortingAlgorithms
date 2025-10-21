def dfs(graph, start_node):
    """
    Performs Depth-First Search on a graph.

    Args:
        graph (dict): An adjacency list representation of the graph.
                      e.g., {0: [1, 2], 1: [2], 2: [0, 3], 3: [3]}
        start_node: The node to start the DFS from.

    Returns:
        list: A list of nodes in the order they were visited.
    """
    visited = set()
    traversal_order = []

    def _dfs_recursive(node):
        visited.add(node)
        traversal_order.append(node)
        for neighbor in graph.get(node, []):
            if neighbor not in visited:
                _dfs_recursive(neighbor)

    if start_node in graph:
        _dfs_recursive(start_node)

    return traversal_order
