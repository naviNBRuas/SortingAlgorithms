# Depth-First Search (DFS)

## Description
Depth-First Search (DFS) is an algorithm for traversing or searching tree or graph data structures. The algorithm starts at the root (or some arbitrary node) and explores as far as possible along each branch before backtracking.

## Time Complexity
*   **Worst-case:** O(V + E) (where V is the number of vertices and E is the number of edges)

## Space Complexity
*   **Worst-case:** O(V) (for the recursion stack or explicit stack)

## How it works
1.  Start by pushing the starting node onto a stack and marking it as visited.
2.  While the stack is not empty:
    *   Pop a node from the stack and add it to the traversal list.
    *   For each unvisited neighbor of the popped node:
        *   Mark the neighbor as visited.
        *   Push the neighbor onto the stack.

Alternatively, DFS can be implemented recursively:
1.  Mark the current node as visited and add it to the traversal list.
2.  For each unvisited neighbor of the current node, recursively call DFS on that neighbor.
