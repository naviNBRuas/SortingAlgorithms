// GENERATED from kernels/algos/bubble_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bubble_sort_impl(a []int, n int64) {
	var end int64
	_ = end
	var swapped int64
	_ = swapped
	var j int64
	_ = j
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	end = (n - 1)
	swapped = 1
	for (end > 0) && (swapped == 1) {
		swapped = 0
		j = 0
		for j < end {
			if int64(a[j]) > int64(a[(j+1)]) {
				_i1 = j
				_i2 = (j + 1)
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				swapped = 1
			}
			j = (j + 1)
		}
		end = (end - 1)
	}
}

// BubbleSort sorts a in place.
func BubbleSort(a []int) {
	bubble_sort_impl(a, int64(len(a)))
}
