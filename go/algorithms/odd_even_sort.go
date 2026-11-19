// GENERATED from kernels/algos/odd_even_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func odd_even_sort_impl(a []int, n int64) {
	var done int64
	_ = done
	var start int64
	_ = start
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	done = 0
	for done == 0 {
		done = 1
		start = 1
		for start >= 0 {
			i = start
			for (i + 1) < n {
				if int64(a[i]) > int64(a[(i+1)]) {
					_i1 = i
					_i2 = (i + 1)
					_t1 = int64(a[_i1])
					a[_i1] = int(int64(a[_i2]))
					a[_i2] = int(_t1)
					done = 0
				}
				i = (i + 2)
			}
			start = (start - 1)
		}
	}
}

// OddEvenSort sorts a in place.
func OddEvenSort(a []int) {
	odd_even_sort_impl(a, int64(len(a)))
}
