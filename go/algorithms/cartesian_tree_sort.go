// GENERATED from kernels/algos/cartesian_tree_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func cartesian_tree_sort_x_sift_up(vals []int, heap []int, i int64) {
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	for (i > 0) && (int64(vals[int64(heap[i])]) < int64(vals[int64(heap[((i-1)/2)])])) {
		_i1 = i
		_i2 = ((i - 1) / 2)
		_t1 = int64(heap[_i1])
		heap[_i1] = int(int64(heap[_i2]))
		heap[_i2] = int(_t1)
		i = ((i - 1) / 2)
	}
}

func cartesian_tree_sort_x_sift_down(vals []int, heap []int, size int64, i int64) {
	var going int64
	_ = going
	var c int64
	_ = c
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	going = 1
	for going == 1 {
		c = ((2 * i) + 1)
		if c >= size {
			going = 0
		} else {
			if ((c + 1) < size) && (int64(vals[int64(heap[(c+1)])]) < int64(vals[int64(heap[c])])) {
				c = (c + 1)
			}
			if int64(vals[int64(heap[c])]) < int64(vals[int64(heap[i])]) {
				_i1 = i
				_i2 = c
				_t1 = int64(heap[_i1])
				heap[_i1] = int(int64(heap[_i2]))
				heap[_i2] = int(_t1)
				i = c
			} else {
				going = 0
			}
		}
	}
}

func cartesian_tree_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var sp int64
	_ = sp
	var last int64
	_ = last
	var size int64
	_ = size
	var out int64
	_ = out
	var node int64
	_ = node
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var vals []int
	_ = vals
	var left []int
	_ = left
	var right []int
	_ = right
	var stack []int
	_ = stack
	var heap []int
	_ = heap
	if n < 2 {
		return
	}
	vals = make([]int, int(k_max(1, n)))
	left = make([]int, int(k_max(1, n)))
	right = make([]int, int(k_max(1, n)))
	stack = make([]int, int(k_max(1, n)))
	heap = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		vals[i] = int(int64(a[i]))
		left[i] = int((-1))
		right[i] = int((-1))
		i = (i + 1)
	}
	sp = 0
	i = 0
	_e2 = n
	for i < _e2 {
		last = (-1)
		for (sp > 0) && (int64(vals[i]) < int64(vals[int64(stack[(sp-1)])])) {
			sp = (sp - 1)
			last = int64(stack[sp])
		}
		left[i] = int(last)
		if sp > 0 {
			right[int64(stack[(sp-1)])] = int(i)
		}
		stack[sp] = int(i)
		sp = (sp + 1)
		i = (i + 1)
	}
	heap[0] = int(int64(stack[0]))
	size = 1
	out = 0
	_e3 = n
	for out < _e3 {
		node = int64(heap[0])
		size = (size - 1)
		heap[0] = int(int64(heap[size]))
		cartesian_tree_sort_x_sift_down(vals, heap, size, 0)
		a[out] = int(int64(vals[node]))
		if int64(left[node]) >= 0 {
			heap[size] = int(int64(left[node]))
			size = (size + 1)
			cartesian_tree_sort_x_sift_up(vals, heap, (size - 1))
		}
		if int64(right[node]) >= 0 {
			heap[size] = int(int64(right[node]))
			size = (size + 1)
			cartesian_tree_sort_x_sift_up(vals, heap, (size - 1))
		}
		out = (out + 1)
	}
}

// CartesianTreeSort sorts a in place.
func CartesianTreeSort(a []int) {
	cartesian_tree_sort_impl(a, int64(len(a)))
}
