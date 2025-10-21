import pytest
from src.python.graph.bfs import bfs

def test_bfs_simple_graph():
    graph = {
        'A': ['B', 'C'],
        'B': ['D', 'E'],
        'C': ['F'],
        'D': [],
        'E': ['F'],
        'F': []
    }
    assert bfs(graph, 'A') == ['A', 'B', 'C', 'D', 'E', 'F']

def test_bfs_disconnected_graph():
    graph = {
        'A': ['B'],
        'B': ['A'],
        'C': ['D'],
        'D': ['C']
    }
    assert bfs(graph, 'A') == ['A', 'B']
    assert bfs(graph, 'C') == ['C', 'D']

def test_bfs_graph_with_cycle():
    graph = {
        0: [1, 2],
        1: [2],
        2: [0, 3],
        3: [3]
    }
    assert bfs(graph, 2) == [2, 0, 3, 1]

def test_bfs_single_node_graph():
    graph = {'A': []}
    assert bfs(graph, 'A') == ['A']

def test_bfs_empty_graph():
    graph = {}
    assert bfs(graph, 'A') == []

def test_bfs_start_node_not_in_graph():
    graph = {'A': ['B']}
    assert bfs(graph, 'C') == []
