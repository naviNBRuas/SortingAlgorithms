// GENERATED from kernels/algos/avl_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func avl_tree_sort_x_height(ht []int, t int64) int64 {
	if t == 0 {
		return 0
	}
	return int64(ht[(t - 1)])
}

func avl_tree_sort_x_fix(lc []int, rc []int, ht []int, t int64) {
	ht[(t - 1)] = int((1 + k_max(avl_tree_sort_x_height(ht, int64(lc[(t-1)])), avl_tree_sort_x_height(ht, int64(rc[(t-1)])))))
}

func avl_tree_sort_x_rot_right(lc []int, rc []int, ht []int, y int64) int64 {
	var x int64
	_ = x
	x = int64(lc[(y - 1)])
	lc[(y - 1)] = int(int64(rc[(x - 1)]))
	rc[(x - 1)] = int(y)
	avl_tree_sort_x_fix(lc, rc, ht, y)
	avl_tree_sort_x_fix(lc, rc, ht, x)
	return x
}

func avl_tree_sort_x_rot_left(lc []int, rc []int, ht []int, x int64) int64 {
	var y int64
	_ = y
	y = int64(rc[(x - 1)])
	rc[(x - 1)] = int(int64(lc[(y - 1)]))
	lc[(y - 1)] = int(x)
	avl_tree_sort_x_fix(lc, rc, ht, x)
	avl_tree_sort_x_fix(lc, rc, ht, y)
	return y
}

func avl_tree_sort_x_insert(vals []int, lc []int, rc []int, ht []int, t int64, v int64) int64 {
	var bal int64
	_ = bal
	var l int64
	_ = l
	var r int64
	_ = r
	if t == 0 {
		ht[v] = int(1)
		return (v + 1)
	}
	if int64(vals[v]) < int64(vals[(t-1)]) {
		lc[(t - 1)] = int(avl_tree_sort_x_insert(vals, lc, rc, ht, int64(lc[(t-1)]), v))
	} else {
		rc[(t - 1)] = int(avl_tree_sort_x_insert(vals, lc, rc, ht, int64(rc[(t-1)]), v))
	}
	avl_tree_sort_x_fix(lc, rc, ht, t)
	bal = (avl_tree_sort_x_height(ht, int64(lc[(t-1)])) - avl_tree_sort_x_height(ht, int64(rc[(t-1)])))
	if bal > 1 {
		l = int64(lc[(t - 1)])
		if avl_tree_sort_x_height(ht, int64(lc[(l-1)])) < avl_tree_sort_x_height(ht, int64(rc[(l-1)])) {
			lc[(t - 1)] = int(avl_tree_sort_x_rot_left(lc, rc, ht, l))
		}
		return avl_tree_sort_x_rot_right(lc, rc, ht, t)
	}
	if bal < (-1) {
		r = int64(rc[(t - 1)])
		if avl_tree_sort_x_height(ht, int64(rc[(r-1)])) < avl_tree_sort_x_height(ht, int64(lc[(r-1)])) {
			rc[(t - 1)] = int(avl_tree_sort_x_rot_right(lc, rc, ht, r))
		}
		return avl_tree_sort_x_rot_left(lc, rc, ht, t)
	}
	return t
}

func avl_tree_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var root int64
	_ = root
	var node int64
	_ = node
	var sp int64
	_ = sp
	var out int64
	_ = out
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var vals []int
	_ = vals
	var lc []int
	_ = lc
	var rc []int
	_ = rc
	var ht []int
	_ = ht
	var stack []int
	_ = stack
	if n < 2 {
		return
	}
	vals = make([]int, int(k_max(1, n)))
	lc = make([]int, int(k_max(1, n)))
	rc = make([]int, int(k_max(1, n)))
	ht = make([]int, int(k_max(1, n)))
	stack = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		vals[i] = int(int64(a[i]))
		i = (i + 1)
	}
	root = 0
	i = 0
	_e2 = n
	for i < _e2 {
		root = avl_tree_sort_x_insert(vals, lc, rc, ht, root, i)
		i = (i + 1)
	}
	node = root
	sp = 0
	out = 0
	for (node != 0) || (sp > 0) {
		if node != 0 {
			stack[sp] = int(node)
			sp = (sp + 1)
			node = int64(lc[(node - 1)])
		} else {
			sp = (sp - 1)
			node = int64(stack[sp])
			a[out] = int(int64(vals[(node - 1)]))
			out = (out + 1)
			node = int64(rc[(node - 1)])
		}
	}
}

// AvlTreeSort sorts a in place.
func AvlTreeSort(a []int) {
	avl_tree_sort_impl(a, int64(len(a)))
}
