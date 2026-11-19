// GENERATED from kernels/algos/quick_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func quick_sort_x_qs(a []int, lo int64, hi int64) {
	var pivot int64
	_ = pivot
	var i int64
	_ = i
	var j int64
	_ = j
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	for lo < hi {
		pivot = int64(a[hi])
		i = lo
		j = lo
		for j < hi {
			if int64(a[j]) <= pivot {
				_i1 = i
				_i2 = j
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				i = (i + 1)
			}
			j = (j + 1)
		}
		_i1 = i
		_i2 = hi
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		if (i - lo) < (hi - i) {
			quick_sort_x_qs(a, lo, (i - 1))
			lo = (i + 1)
		} else {
			quick_sort_x_qs(a, (i + 1), hi)
			hi = (i - 1)
		}
	}
}

func quick_sort_impl(a []int, n int64) {
	quick_sort_x_qs(a, 0, (n - 1))
}

// QuickSort sorts a in place.
func QuickSort(a []int) {
	quick_sort_impl(a, int64(len(a)))
}
