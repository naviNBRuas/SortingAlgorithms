// GENERATED from kernels/algos/pairwise_sorting_network.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func pairwise_sorting_network_x_cmp_swap(a []int, i int64, j int64, n int64) {
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	if j < n {
		if int64(a[i]) > int64(a[j]) {
			_i1 = i
			_i2 = j
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
		}
	}
}

func pairwise_sorting_network_impl(a []int, n int64) {
	var size int64
	_ = size
	var step int64
	_ = step
	var b int64
	_ = b
	var c int64
	_ = c
	var e int64
	_ = e
	var d int64
	_ = d
	size = 1
	for size < n {
		size = (size * 2)
	}
	step = 1
	for step < size {
		b = step
		c = 0
		for b < size {
			pairwise_sorting_network_x_cmp_swap(a, (b - step), b, n)
			b = (b + 1)
			c = (c + 1)
			if c >= step {
				c = 0
				b = (b + step)
			}
		}
		step = (step * 2)
	}
	step = (step / 4)
	e = 1
	for step > 0 {
		d = e
		for d > 0 {
			b = ((d + 1) * step)
			c = 0
			for b < size {
				pairwise_sorting_network_x_cmp_swap(a, (b - (d * step)), b, n)
				b = (b + 1)
				c = (c + 1)
				if c >= step {
					c = 0
					b = (b + step)
				}
			}
			d = (d / 2)
		}
		step = (step / 2)
		e = ((e * 2) + 1)
	}
}

// PairwiseSortingNetwork sorts a in place.
func PairwiseSortingNetwork(a []int) {
	pairwise_sorting_network_impl(a, int64(len(a)))
}
