// GENERATED from kernels/algos/pancake_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func pancake_sort_x_flip(a []int, k int64) {
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	i = 0
	for i < k {
		_i1 = i
		_i2 = k
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		i = (i + 1)
		k = (k - 1)
	}
}

func pancake_sort_impl(a []int, n int64) {
	var size int64
	_ = size
	var mx int64
	_ = mx
	var i int64
	_ = i
	size = n
	for size > 1 {
		mx = 0
		i = 1
		for i < size {
			if int64(a[i]) > int64(a[mx]) {
				mx = i
			}
			i = (i + 1)
		}
		if mx != (size - 1) {
			if mx > 0 {
				pancake_sort_x_flip(a, mx)
			}
			pancake_sort_x_flip(a, (size - 1))
		}
		size = (size - 1)
	}
}

// PancakeSort sorts a in place.
func PancakeSort(a []int) {
	pancake_sort_impl(a, int64(len(a)))
}
