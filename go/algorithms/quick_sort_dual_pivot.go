// GENERATED from kernels/algos/quick_sort_dual_pivot.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func quick_sort_dual_pivot_x_qs(a []int, lo int64, hi int64) {
	var p int64
	_ = p
	var q int64
	_ = q
	var lt int64
	_ = lt
	var gt int64
	_ = gt
	var k int64
	_ = k
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	for lo < hi {
		if int64(a[lo]) > int64(a[hi]) {
			_i1 = lo
			_i2 = hi
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
		}
		p = int64(a[lo])
		q = int64(a[hi])
		lt = (lo + 1)
		gt = (hi - 1)
		k = (lo + 1)
		for k <= gt {
			if int64(a[k]) < p {
				_i1 = k
				_i2 = lt
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				lt = (lt + 1)
			} else {
				if int64(a[k]) > q {
					for (k < gt) && (int64(a[gt]) > q) {
						gt = (gt - 1)
					}
					_i1 = k
					_i2 = gt
					_t1 = int64(a[_i1])
					a[_i1] = int(int64(a[_i2]))
					a[_i2] = int(_t1)
					gt = (gt - 1)
					if int64(a[k]) < p {
						_i1 = k
						_i2 = lt
						_t1 = int64(a[_i1])
						a[_i1] = int(int64(a[_i2]))
						a[_i2] = int(_t1)
						lt = (lt + 1)
					}
				}
			}
			k = (k + 1)
		}
		lt = (lt - 1)
		gt = (gt + 1)
		_i1 = lo
		_i2 = lt
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		_i1 = hi
		_i2 = gt
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		quick_sort_dual_pivot_x_qs(a, lo, (lt - 1))
		quick_sort_dual_pivot_x_qs(a, (gt + 1), hi)
		lo = (lt + 1)
		hi = (gt - 1)
	}
}

func quick_sort_dual_pivot_impl(a []int, n int64) {
	quick_sort_dual_pivot_x_qs(a, 0, (n - 1))
}

// QuickSortDualPivot sorts a in place.
func QuickSortDualPivot(a []int) {
	quick_sort_dual_pivot_impl(a, int64(len(a)))
}
