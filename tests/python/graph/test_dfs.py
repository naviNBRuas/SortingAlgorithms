import pytest
from src.python.graph.dfs import dfs

def test_dfs_simple_graph():
    graph = {
        'A': ['B', 'C'],
        'B': ['D', 'E'],
        'C': ['F'],
        'D': [],
        'E': ['F'],
        'F': []
    }
    # DFS can have multiple valid traversal orders depending on neighbor order
    # We'll check if the start node is first and all nodes are visited
    result = dfs(graph, 'A')
    assert result[0] == 'A'
    assert len(result) == 6
    assert set(result) == set(['A', 'B', 'C', 'D', 'E', 'F'])

def test_dfs_disconnected_graph():
    graph = {
        'A': ['B'],
        'B': ['A'],
        'C': ['D'],
        'D': ['C']
    }
    result_a = dfs(graph, 'A')
    assert result_a[0] == 'A'
    assert len(result_a) == 2
    assert set(result_a) == set(['A', 'B'])

    result_c = dfs(graph, 'C')
    assert result_c[0] == 'C'
    assert len(result_c) == 2
    assert set(result_c) == set(['C', 'D'])

def test_dfs_graph_with_cycle():
    graph = {
        0: [1, 2],
        1: [2],
        2: [0, 3],
        3: [3]
    }
    result = dfs(graph, 2)
    assert result[0] == 2
    assert len(result) == 4
    assert set(result) == set([0, 1, 2, 3])

def test_dfs_single_node_graph():
    graph = {'A': []}
    assert dfs(graph, 'A') == ['A']

def test_dfs_empty_graph():
    graph = {}
    assert dfs(graph, 'A') == []

def test_dfs_start_node_not_in_graph():
    graph = {'A': ['B']}
    assert dfs(graph, 'C') == []
