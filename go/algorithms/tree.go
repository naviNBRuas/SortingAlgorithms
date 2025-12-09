package algorithms

// TreeSort returns a new sorted slice using a binary search tree.
func TreeSort(arr []int) []int {
    var root *treeNode
    for _, v := range arr {
        root = insertNode(root, v)
    }
    out := make([]int, 0, len(arr))
    inorder(root, &out)
    return out
}

type treeNode struct {
    val   int
    left  *treeNode
    right *treeNode
}

func insertNode(n *treeNode, v int) *treeNode {
    if n == nil {
        return &treeNode{val: v}
    }
    if v < n.val {
        n.left = insertNode(n.left, v)
    } else {
        n.right = insertNode(n.right, v)
    }
    return n
}

func inorder(n *treeNode, out *[]int) {
    if n == nil {
        return
    }
    inorder(n.left, out)
    *out = append(*out, n.val)
    inorder(n.right, out)
}
