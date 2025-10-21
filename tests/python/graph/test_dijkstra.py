import pytest
from src.python.graph.dijkstra import dijkstra

def test_dijkstra_simple_graph():
    graph = {
        'A': [('B', 1), ('C', 4)],
        'B': [('C', 2), ('D', 5)],
        'C': [('D', 1)],
        'D': []
    }
    expected_distances = {'A': 0, 'B': 1, 'C': 3, 'D': 4}
    assert dijkstra(graph, 'A') == expected_distances

def test_dijkstra_disconnected_graph():
    graph = {
        'A': [('B', 1)],
        'B': [],
        'C': [('D', 1)],
        'D': []
    }
    expected_distances_a = {'A': 0, 'B': 1, 'C': float('infinity'), 'D': float('infinity')}
    assert dijkstra(graph, 'A') == expected_distances_a

    expected_distances_c = {'A': float('infinity'), 'B': float('infinity'), 'C': 0, 'D': 1}
    assert dijkstra(graph, 'C') == expected_distances_c

def test_dijkstra_graph_with_loops():
    graph = {
        'A': [('B', 1)],
        'B': [('A', 1), ('C', 1)],
        'C': [('B', 1)]
    }
    expected_distances = {'A': 0, 'B': 1, 'C': 2}
    assert dijkstra(graph, 'A') == expected_distances

def test_dijkstra_single_node_graph():
    graph = {'A': []}
    assert dijkstra(graph, 'A') == {'A': 0}

def test_dijkstra_empty_graph():
    graph = {}
    assert dijkstra(graph, 'A') == {}

def test_dijkstra_start_node_not_in_graph():
    graph = {'A': [('B', 1)]}
    assert dijkstra(graph, 'C') == {}

def test_dijkstra_complex_graph():
    graph = {
        'A': [('B', 4), ('C', 2)],
        'B': [('E', 3)],
        'C': [('D', 2), ('F', 4)],
        'D': [('E', 3)],
        'E': [('G', 1)],
        'F': [('G', 1)],
        'G': []
    }
    expected_distances = {'A': 0, 'B': 4, 'C': 2, 'D': 4, 'E': 7, 'F': 6, 'G': 7}
    assert dijkstra(graph, 'A') == expected_distances
