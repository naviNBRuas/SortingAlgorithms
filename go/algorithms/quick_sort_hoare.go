// GENERATED from kernels/algos/quick_sort_hoare.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func quick_sort_hoare_x_qs(a []int, lo int64, hi int64) {
	var pivot int64
	_ = pivot
	var i int64
	_ = i
	var j int64
	_ = j
	var going int64
	_ = going
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	for lo < hi {
		pivot = int64(a[((lo + hi) / 2)])
		i = (lo - 1)
		j = (hi + 1)
		going = 1
		for going == 1 {
			i = (i + 1)
			for int64(a[i]) < pivot {
				i = (i + 1)
			}
			j = (j - 1)
			for int64(a[j]) > pivot {
				j = (j - 1)
			}
			if i >= j {
				going = 0
			} else {
				_i1 = i
				_i2 = j
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
			}
		}
		if (j - lo) < ((hi - j) - 1) {
			quick_sort_hoare_x_qs(a, lo, j)
			lo = (j + 1)
		} else {
			quick_sort_hoare_x_qs(a, (j + 1), hi)
			hi = j
		}
	}
}

func quick_sort_hoare_impl(a []int, n int64) {
	quick_sort_hoare_x_qs(a, 0, (n - 1))
}

// QuickSortHoare sorts a in place.
func QuickSortHoare(a []int) {
	quick_sort_hoare_impl(a, int64(len(a)))
}
