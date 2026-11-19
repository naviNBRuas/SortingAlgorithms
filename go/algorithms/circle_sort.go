// GENERATED from kernels/algos/circle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func circle_sort_x_circle_pass(a []int, lo int64, hi int64) int64 {
	var m int64
	_ = m
	var swaps int64
	_ = swaps
	var half int64
	_ = half
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	m = (hi - lo)
	if m < 2 {
		return 0
	}
	swaps = 0
	half = (m / 2)
	i = 0
	for i < half {
		if int64(a[((hi-1)-i)]) < int64(a[(lo+i)]) {
			_i1 = ((hi - 1) - i)
			_i2 = (lo + i)
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
			swaps = (swaps + 1)
		}
		i = (i + 1)
	}
	if (m % 2) == 1 {
		if int64(a[(lo+half)]) < int64(a[((lo+half)-1)]) {
			_i1 = ((lo + half) - 1)
			_i2 = (lo + half)
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
			swaps = (swaps + 1)
		}
	}
	swaps = (swaps + circle_sort_x_circle_pass(a, lo, (lo+half)))
	swaps = (swaps + circle_sort_x_circle_pass(a, (lo+half), hi))
	return swaps
}

func circle_sort_impl(a []int, n int64) {
	var s int64
	_ = s
	s = 1
	for s > 0 {
		s = circle_sort_x_circle_pass(a, 0, n)
	}
}

// CircleSort sorts a in place.
func CircleSort(a []int) {
	circle_sort_impl(a, int64(len(a)))
}
