// GENERATED from kernels/algos/merge_sort_bottom_up.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func merge_sort_bottom_up_impl(a []int, n int64) {
	var width int64
	_ = width
	var lo int64
	_ = lo
	var mid int64
	_ = mid
	var hi int64
	_ = hi
	var x int64
	_ = x
	var i int64
	_ = i
	var j int64
	_ = j
	var k int64
	_ = k
	var _e1 int64
	_ = _e1
	var tmp []int
	_ = tmp
	tmp = make([]int, int(k_max(1, n)))
	width = 1
	for width < n {
		lo = 0
		for lo < n {
			mid = k_min((lo + width), n)
			hi = k_min((lo + (2 * width)), n)
			x = lo
			_e1 = mid
			for x < _e1 {
				tmp[x] = int(int64(a[x]))
				x = (x + 1)
			}
			i = lo
			j = mid
			k = lo
			for (i < mid) && (j < hi) {
				if int64(a[j]) < int64(tmp[i]) {
					a[k] = int(int64(a[j]))
					j = (j + 1)
				} else {
					a[k] = int(int64(tmp[i]))
					i = (i + 1)
				}
				k = (k + 1)
			}
			for i < mid {
				a[k] = int(int64(tmp[i]))
				i = (i + 1)
				k = (k + 1)
			}
			lo = (lo + (2 * width))
		}
		width = (width * 2)
	}
}

// MergeSortBottomUp sorts a in place.
func MergeSortBottomUp(a []int) {
	merge_sort_bottom_up_impl(a, int64(len(a)))
}
