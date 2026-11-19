// GENERATED from kernels/algos/tournament_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func tournament_sort_x_better(vals []int, x int64, y int64) int64 {
	if x < 0 {
		return y
	}
	if y < 0 {
		return x
	}
	if int64(vals[x]) <= int64(vals[y]) {
		return x
	}
	return y
}

func tournament_sort_impl(a []int, n int64) {
	var size int64
	_ = size
	var i int64
	_ = i
	var k int64
	_ = k
	var w int64
	_ = w
	var node int64
	_ = node
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var _e4 int64
	_ = _e4
	var vals []int
	_ = vals
	var out []int
	_ = out
	var tree []int
	_ = tree
	if n < 2 {
		return
	}
	size = 1
	for size < n {
		size = (size * 2)
	}
	vals = make([]int, int(k_max(1, n)))
	out = make([]int, int(k_max(1, n)))
	tree = make([]int, int(k_max(1, (2*size))))
	i = 0
	_e1 = (2 * size)
	for i < _e1 {
		tree[i] = int((-1))
		i = (i + 1)
	}
	i = 0
	_e2 = n
	for i < _e2 {
		vals[i] = int(int64(a[i]))
		tree[(size + i)] = int(i)
		i = (i + 1)
	}
	i = (size - 1)
	for i >= 1 {
		tree[i] = int(tournament_sort_x_better(vals, int64(tree[(2*i)]), int64(tree[((2*i)+1)])))
		i = (i - 1)
	}
	k = 0
	_e3 = n
	for k < _e3 {
		w = int64(tree[1])
		out[k] = int(int64(vals[w]))
		node = (size + w)
		tree[node] = int((-1))
		node = (node / 2)
		for node >= 1 {
			tree[node] = int(tournament_sort_x_better(vals, int64(tree[(2*node)]), int64(tree[((2*node)+1)])))
			node = (node / 2)
		}
		k = (k + 1)
	}
	i = 0
	_e4 = n
	for i < _e4 {
		a[i] = int(int64(out[i]))
		i = (i + 1)
	}
}

// TournamentSort sorts a in place.
func TournamentSort(a []int) {
	tournament_sort_impl(a, int64(len(a)))
}
