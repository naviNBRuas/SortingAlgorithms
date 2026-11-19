// GENERATED from kernels/algos/bitonic_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bitonic_sort_x_cmp_swap(a []int, i int64, j int64) {
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
}

func bitonic_sort_impl(a []int, n int64) {
	var size int64
	_ = size
	var k int64
	_ = k
	var blk int64
	_ = blk
	var t int64
	_ = t
	var j int64
	_ = j
	var i int64
	_ = i
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	size = 1
	for size < n {
		size = (size * 2)
	}
	k = 2
	for k <= size {
		blk = 0
		for blk < size {
			t = 0
			_e1 = (k / 2)
			for t < _e1 {
				j = (((blk + k) - 1) - t)
				if j < n {
					bitonic_sort_x_cmp_swap(a, (blk + t), j)
				}
				t = (t + 1)
			}
			blk = (blk + k)
		}
		j = (k / 4)
		for j >= 1 {
			i = 0
			_e2 = size
			for i < _e2 {
				if (((i / j) % 2) == 0) && ((i + j) < n) {
					bitonic_sort_x_cmp_swap(a, i, (i + j))
				}
				i = (i + 1)
			}
			j = (j / 2)
		}
		k = (k * 2)
	}
}

// BitonicSort sorts a in place.
func BitonicSort(a []int) {
	bitonic_sort_impl(a, int64(len(a)))
}
