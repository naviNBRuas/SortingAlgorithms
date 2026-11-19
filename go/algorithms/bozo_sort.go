// GENERATED from kernels/algos/bozo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bozo_sort_x_is_sorted(a []int, n int64) int64 {
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

func bozo_sort_impl(a []int, n int64, max_swaps int64) {
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
	state = 987654321
	count = 0
	for (bozo_sort_x_is_sorted(a, n) == 0) && (count < max_swaps) {
		state = (((state * 1103515245) + 12345) % 2147483648)
		i = ((state / 16) % n)
		state = (((state * 1103515245) + 12345) % 2147483648)
		_i1 = i
		_i2 = ((state / 16) % n)
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		count = (count + 1)
	}
}

// BozoSort sorts a in place.
func BozoSort(a []int, max_swaps int64) {
	bozo_sort_impl(a, int64(len(a)), max_swaps)
}
