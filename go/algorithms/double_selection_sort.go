// GENERATED from kernels/algos/double_selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func double_selection_sort_impl(a []int, n int64) {
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var j int64
	_ = j
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	lo = 0
	hi = (n - 1)
	for lo < hi {
		mn = lo
		mx = lo
		j = (lo + 1)
		for j <= hi {
			if int64(a[j]) < int64(a[mn]) {
				mn = j
			} else {
				if int64(a[j]) > int64(a[mx]) {
					mx = j
				}
			}
			j = (j + 1)
		}
		_i1 = lo
		_i2 = mn
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		if mx == lo {
			mx = mn
		}
		_i1 = hi
		_i2 = mx
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		lo = (lo + 1)
		hi = (hi - 1)
	}
}

// DoubleSelectionSort sorts a in place.
func DoubleSelectionSort(a []int) {
	double_selection_sort_impl(a, int64(len(a)))
}
