// GENERATED from kernels/algos/comb_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func comb_sort_impl(a []int, n int64) {
	var gap int64
	_ = gap
	var swapped int64
	_ = swapped
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	gap = n
	swapped = 1
	for (gap > 1) || (swapped == 1) {
		gap = ((gap * 10) / 13)
		if gap < 1 {
			gap = 1
		}
		swapped = 0
		i = 0
		for (i + gap) < n {
			if int64(a[i]) > int64(a[(i+gap)]) {
				_i1 = i
				_i2 = (i + gap)
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				swapped = 1
			}
			i = (i + 1)
		}
	}
}

// CombSort sorts a in place.
func CombSort(a []int) {
	comb_sort_impl(a, int64(len(a)))
}
