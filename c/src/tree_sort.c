#include "../sorting_algorithms.h"
#include <stdlib.h>

typedef struct TreeNode {
    int value;
    struct TreeNode *left;
    struct TreeNode *right;
} TreeNode;

static TreeNode *insert(TreeNode *root, int value) {
    if (!root) {
        TreeNode *node = (TreeNode *)malloc(sizeof(TreeNode));
        if (!node) return NULL;
        node->value = value;
        node->left = node->right = NULL;
        return node;
    }
    if (value < root->value) root->left = insert(root->left, value);
    else root->right = insert(root->right, value);
    return root;
}

static void inorder(TreeNode *root, int *arr, size_t *idx) {
    if (!root) return;
    inorder(root->left, arr, idx);
    arr[(*idx)++] = root->value;
    inorder(root->right, arr, idx);
}

static void free_tree(TreeNode *root) {
    if (!root) return;
    free_tree(root->left);
    free_tree(root->right);
    free(root);
}

void tree_sort(int *arr, size_t n) {
    TreeNode *root = NULL;
    for (size_t i = 0; i < n; ++i) root = insert(root, arr[i]);
    size_t idx = 0;
    inorder(root, arr, &idx);
    free_tree(root);
}
