// GENERATED from kernels/algos/weak_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func weak_heap_sort_x_gparent(r []int, j int64) int64 {
	for (j % 2) == int64(r[(j/2)]) {
		j = (j / 2)
	}
	return (j / 2)
}

func weak_heap_sort_x_join(a []int, r []int, i int64, j int64) {
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	if int64(a[i]) < int64(a[j]) {
		_i1 = i
		_i2 = j
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		r[j] = int((1 - int64(r[j])))
	}
}

func weak_heap_sort_impl(a []int, n int64) {
	var j int64
	_ = j
	var g int64
	_ = g
	var m int64
	_ = m
	var x int64
	_ = x
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	var r []int
	_ = r
	if n < 2 {
		return
	}
	r = make([]int, int(k_max(1, n)))
	j = (n - 1)
	for j > 0 {
		g = weak_heap_sort_x_gparent(r, j)
		weak_heap_sort_x_join(a, r, g, j)
		j = (j - 1)
	}
	m = (n - 1)
	for m > 1 {
		_i1 = 0
		_i2 = m
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		x = 1
		for ((2 * x) + int64(r[x])) < m {
			x = ((2 * x) + int64(r[x]))
		}
		for x > 0 {
			weak_heap_sort_x_join(a, r, 0, x)
			x = (x / 2)
		}
		m = (m - 1)
	}
	_i1 = 0
	_i2 = 1
	_t1 = int64(a[_i1])
	a[_i1] = int(int64(a[_i2]))
	a[_i2] = int(_t1)
}

// WeakHeapSort sorts a in place.
func WeakHeapSort(a []int) {
	weak_heap_sort_impl(a, int64(len(a)))
}
