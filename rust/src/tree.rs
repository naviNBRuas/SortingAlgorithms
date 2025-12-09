pub fn tree_sort(arr: &[i32]) -> Vec<i32> {
    let mut root: Option<Box<TreeNode>> = None;
    for &v in arr.iter() {
        root = insert(root, v);
    }
    let mut out = Vec::with_capacity(arr.len());
    inorder(&root, &mut out);
    out
}

struct TreeNode {
    val: i32,
    left: Option<Box<TreeNode>>,
    right: Option<Box<TreeNode>>,
}

fn insert(node: Option<Box<TreeNode>>, v: i32) -> Option<Box<TreeNode>> {
    match node {
        None => Some(Box::new(TreeNode { val: v, left: None, right: None })),
        Some(mut n) => {
            if v < n.val {
                n.left = insert(n.left.take(), v);
            } else {
                n.right = insert(n.right.take(), v);
            }
            Some(n)
        }
    }
}

fn inorder(node: &Option<Box<TreeNode>>, out: &mut Vec<i32>) {
    if let Some(n) = node {
        inorder(&n.left, out);
        out.push(n.val);
        inorder(&n.right, out);
    }
}
