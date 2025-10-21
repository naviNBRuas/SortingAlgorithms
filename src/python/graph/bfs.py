from collections import deque

def bfs(graph, start_node):
    """
    Performs Breadth-First Search on a graph.

    Args:
        graph (dict): An adjacency list representation of the graph.
                      e.g., {0: [1, 2], 1: [2], 2: [0, 3], 3: [3]}
        start_node: The node to start the BFS from.

    Returns:
        list: A list of nodes in the order they were visited.
    """
    visited = set()
    traversal_order = []

    if start_node not in graph and not graph:
        return []
    if start_node not in graph:
        return []

    queue = deque([start_node])
    visited.add(start_node)

    while queue:
        current_node = queue.popleft()
        traversal_order.append(current_node)

        for neighbor in graph.get(current_node, []):
            if neighbor not in visited:
                visited.add(neighbor)
                queue.append(neighbor)
    return traversal_order
