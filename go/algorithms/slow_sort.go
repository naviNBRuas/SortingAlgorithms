// GENERATED from kernels/algos/slow_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func slow_sort_x_slow(a []int, i int64, j int64) {
	var m int64
	_ = m
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	if i >= j {
		return
	}
	m = ((i + j) / 2)
	slow_sort_x_slow(a, i, m)
	slow_sort_x_slow(a, (m + 1), j)
	if int64(a[m]) > int64(a[j]) {
		_i1 = m
		_i2 = j
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
	}
	slow_sort_x_slow(a, i, (j - 1))
}

func slow_sort_impl(a []int, n int64) {
	slow_sort_x_slow(a, 0, (n - 1))
}

// SlowSort sorts a in place.
func SlowSort(a []int) {
	slow_sort_impl(a, int64(len(a)))
}
