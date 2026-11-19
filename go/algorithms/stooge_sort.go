// GENERATED from kernels/algos/stooge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func stooge_sort_x_st(a []int, i int64, j int64) {
	var t int64
	_ = t
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	if int64(a[i]) > int64(a[j]) {
		_i1 = i
		_i2 = j
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
	}
	if ((j - i) + 1) > 2 {
		t = (((j - i) + 1) / 3)
		stooge_sort_x_st(a, i, (j - t))
		stooge_sort_x_st(a, (i + t), j)
		stooge_sort_x_st(a, i, (j - t))
	}
}

func stooge_sort_impl(a []int, n int64) {
	if n > 1 {
		stooge_sort_x_st(a, 0, (n - 1))
	}
}

// StoogeSort sorts a in place.
func StoogeSort(a []int) {
	stooge_sort_impl(a, int64(len(a)))
}
