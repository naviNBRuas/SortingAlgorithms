import heapq

def dijkstra(graph, start_node):
    """
    Finds the shortest paths from a start node to all other nodes in a weighted graph
    with non-negative edge weights using Dijkstra's algorithm.

    Args:
        graph (dict): An adjacency list representation of the graph where each node
                      maps to a list of (neighbor, weight) tuples.
                      e.g., {'A': [('B', 1), ('C', 4)], 'B': [('C', 2), ('D', 5)], ...}
        start_node: The node to start the algorithm from.

    Returns:
        dict: A dictionary where keys are nodes and values are their shortest distances
              from the start_node. Returns an empty dictionary if start_node is not in graph.
    """
    if start_node not in graph and graph:
        return {}
    if not graph:
        return {}

    distances = {node: float('infinity') for node in graph}
    distances[start_node] = 0
    priority_queue = [(0, start_node)]  # (distance, node)

    while priority_queue:
        current_distance, current_node = heapq.heappop(priority_queue)

        # If we found a shorter path to current_node already, skip
        if current_distance > distances[current_node]:
            continue

        for neighbor, weight in graph.get(current_node, []):
            distance = current_distance + weight

            # If a shorter path is found to the neighbor
            if distance < distances[neighbor]:
                distances[neighbor] = distance
                heapq.heappush(priority_queue, (distance, neighbor))

    return distances
