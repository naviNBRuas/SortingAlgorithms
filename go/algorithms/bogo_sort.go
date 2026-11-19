// GENERATED from kernels/algos/bogo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bogo_sort_x_is_sorted(a []int, n int64) int64 {
	var i int64
	_ = i
	i = 0
	for (i + 1) < n {
		if int64(a[i]) > int64(a[(i+1)]) {
			return 0
		}
		i = (i + 1)
	}
	return 1
}

func bogo_sort_impl(a []int, n int64, max_shuffles int64) {
	var state int64
	_ = state
	var count int64
	_ = count
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	state = 123456789
	count = 0
	for (bogo_sort_x_is_sorted(a, n) == 0) && (count < max_shuffles) {
		i = (n - 1)
		for i > 0 {
			state = (((state * 1103515245) + 12345) % 2147483648)
			_i1 = i
			_i2 = ((state / 16) % (i + 1))
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
			i = (i - 1)
		}
		count = (count + 1)
	}
}

// BogoSort sorts a in place.
func BogoSort(a []int, max_shuffles int64) {
	bogo_sort_impl(a, int64(len(a)), max_shuffles)
}
