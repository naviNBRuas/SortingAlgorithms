# Dijkstra's Algorithm

## Description
Dijkstra's algorithm is an algorithm for finding the shortest paths between nodes in a graph, which may represent, for example, road networks. It was conceived by computer scientist Edsger W. Dijkstra in 1956 and published three years later. For a given source node in the graph, the algorithm finds the shortest path between that source and every other node. It works for graphs with non-negative edge weights.

## Time Complexity
*   **Worst-case:** O(E log V) or O(E + V log V) with a Fibonacci heap, O(V²) with an adjacency matrix and simple array.

## Space Complexity
*   **Worst-case:** O(V + E)

## How it works
1.  **Initialization:**
    *   Assign a distance value to every node: 0 for the starting node and infinity for all other nodes.
    *   Create a priority queue (min-heap) and add the starting node with its distance (0).
    *   Maintain a set of visited nodes.
2.  **Iteration:** While the priority queue is not empty:
    *   Extract the node `u` with the smallest distance from the priority queue.
    *   If `u` has already been visited, continue.
    *   Mark `u` as visited.
    *   For each unvisited neighbor `v` of `u`:
        *   Calculate the distance from the start node to `v` through `u` (`distance[u] + weight(u, v)`).
        *   If this calculated distance is less than the current `distance[v]`, update `distance[v]` and add `v` to the priority queue with its new distance.
3.  **Result:** Once the priority queue is empty, the `distances` dictionary will contain the shortest path distances from the start node to all other reachable nodes.
