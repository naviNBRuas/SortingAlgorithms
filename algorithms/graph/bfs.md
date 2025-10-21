# Breadth-First Search (BFS)

## Description
Breadth-First Search (BFS) is an algorithm for traversing or searching tree or graph data structures. It starts at the tree root (or some arbitrary node of a graph, sometimes referred to as a 'search key'), and explores all of the neighbor nodes at the present depth prior to moving on to the nodes at the next depth level.

## Time Complexity
*   **Worst-case:** O(V + E) (where V is the number of vertices and E is the number of edges)

## Space Complexity
*   **Worst-case:** O(V) (to store the queue and visited set)

## How it works
1.  Start by putting any one of the graph's vertices at the back of a queue and marking it as visited.
2.  Take the front element of the queue and add it to the traversal list.
3.  Visit all the neighbors of the dequeued element that are not yet visited and add them to the back of the queue.
4.  Repeat steps 2 and 3 until the queue is empty.
