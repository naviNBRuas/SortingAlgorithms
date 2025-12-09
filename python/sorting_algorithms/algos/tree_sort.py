from typing import Optional, Sequence
from ..base import _setup_tracer, _finalize, SortTracer, Number


class _Node:
    __slots__ = ("value", "left", "right")

    def __init__(self, value: Number):
        self.value = value
        self.left: Optional["_Node"] = None
        self.right: Optional["_Node"] = None


def tree_sort(data: Sequence[Number], *, trace: bool = False, tracer: Optional[SortTracer] = None):
    arr = list(data)
    tracer, ret_trace = _setup_tracer("tree_sort", trace, tracer)
    if not arr:
        return _finalize(arr, tracer, ret_trace)

    root = _Node(arr[0])
    if tracer:
        tracer.record([root.value], (), "root")

    def insert(node: _Node, value: Number):
        if value <= node.value:
            if node.left is None:
                node.left = _Node(value)
            else:
                insert(node.left, value)
        else:
            if node.right is None:
                node.right = _Node(value)
            else:
                insert(node.right, value)

    for v in arr[1:]:
        insert(root, v)
        if tracer:
            tracer.record(arr, (), f"insert {v}")

    output: list[Number] = []

    def inorder(node: Optional[_Node]):
        if node is None:
            return
        inorder(node.left)
        output.append(node.value)
        if tracer:
            tracer.record(output + [node.value], (), "inorder append")
        inorder(node.right)

    inorder(root)
    return _finalize(output, tracer, ret_trace)
