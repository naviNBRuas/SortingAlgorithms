// GENERATED from kernels/algos/odd_even_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func odd_even_merge_sort_x_cmp_swap(a []int, i int64, j int64) {
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

func odd_even_merge_sort_impl(a []int, n int64) {
	var p int64
	_ = p
	var k int64
	_ = k
	var j int64
	_ = j
	var lim int64
	_ = lim
	var i int64
	_ = i
	var _e1 int64
	_ = _e1
	p = 1
	for p < n {
		k = p
		for k >= 1 {
			j = (k % p)
			for j < (n - k) {
				lim = k_min(k, ((n - j) - k))
				i = 0
				_e1 = lim
				for i < _e1 {
					if ((i + j) / (2 * p)) == (((i + j) + k) / (2 * p)) {
						odd_even_merge_sort_x_cmp_swap(a, (i + j), ((i + j) + k))
					}
					i = (i + 1)
				}
				j = (j + (2 * k))
			}
			k = (k / 2)
		}
		p = (p * 2)
	}
}

// OddEvenMergeSort sorts a in place.
func OddEvenMergeSort(a []int) {
	odd_even_merge_sort_impl(a, int64(len(a)))
}
