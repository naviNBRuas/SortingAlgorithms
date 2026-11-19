// GENERATED from kernels/algos/tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func tree_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var cur int64
	_ = cur
	var placed int64
	_ = placed
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
	var left []int
	_ = left
	var right []int
	_ = right
	var stack []int
	_ = stack
	if n < 2 {
		return
	}
	vals = make([]int, int(k_max(1, n)))
	left = make([]int, int(k_max(1, n)))
	right = make([]int, int(k_max(1, n)))
	stack = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		vals[i] = int(int64(a[i]))
		i = (i + 1)
	}
	i = 1
	_e2 = n
	for i < _e2 {
		cur = 0
		placed = 0
		for placed == 0 {
			if int64(vals[i]) < int64(vals[cur]) {
				if int64(left[cur]) == 0 {
					left[cur] = int((i + 1))
					placed = 1
				} else {
					cur = (int64(left[cur]) - 1)
				}
			} else {
				if int64(right[cur]) == 0 {
					right[cur] = int((i + 1))
					placed = 1
				} else {
					cur = (int64(right[cur]) - 1)
				}
			}
		}
		i = (i + 1)
	}
	node = 1
	sp = 0
	out = 0
	for (node != 0) || (sp > 0) {
		if node != 0 {
			stack[sp] = int(node)
			sp = (sp + 1)
			node = int64(left[(node - 1)])
		} else {
			sp = (sp - 1)
			node = int64(stack[sp])
			a[out] = int(int64(vals[(node - 1)]))
			out = (out + 1)
			node = int64(right[(node - 1)])
		}
	}
}

// TreeSort sorts a in place.
func TreeSort(a []int) {
	tree_sort_impl(a, int64(len(a)))
}
