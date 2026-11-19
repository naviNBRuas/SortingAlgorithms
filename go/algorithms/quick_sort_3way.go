// GENERATED from kernels/algos/quick_sort_3way.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func quick_sort_3way_x_qs(a []int, lo int64, hi int64) {
	var pivot int64
	_ = pivot
	var lt int64
	_ = lt
	var i int64
	_ = i
	var gt int64
	_ = gt
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	for lo < hi {
		pivot = int64(a[((lo + hi) / 2)])
		lt = lo
		i = lo
		gt = hi
		for i <= gt {
			if int64(a[i]) < pivot {
				_i1 = lt
				_i2 = i
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				lt = (lt + 1)
				i = (i + 1)
			} else {
				if int64(a[i]) > pivot {
					_i1 = i
					_i2 = gt
					_t1 = int64(a[_i1])
					a[_i1] = int(int64(a[_i2]))
					a[_i2] = int(_t1)
					gt = (gt - 1)
				} else {
					i = (i + 1)
				}
			}
		}
		if (lt - lo) < (hi - gt) {
			quick_sort_3way_x_qs(a, lo, (lt - 1))
			lo = (gt + 1)
		} else {
			quick_sort_3way_x_qs(a, (gt + 1), hi)
			hi = (lt - 1)
		}
	}
}

func quick_sort_3way_impl(a []int, n int64) {
	quick_sort_3way_x_qs(a, 0, (n - 1))
}

// QuickSort3way sorts a in place.
func QuickSort3way(a []int) {
	quick_sort_3way_impl(a, int64(len(a)))
}
