// GENERATED from kernels/algos/binary_insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func binary_insertion_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var key int64
	_ = key
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var mid int64
	_ = mid
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	i = 1
	_e1 = n
	for i < _e1 {
		key = int64(a[i])
		lo = 0
		hi = i
		for lo < hi {
			mid = ((lo + hi) / 2)
			if key < int64(a[mid]) {
				hi = mid
			} else {
				lo = (mid + 1)
			}
		}
		j = i
		for j > lo {
			a[j] = int(int64(a[(j - 1)]))
			j = (j - 1)
		}
		a[lo] = int(key)
		i = (i + 1)
	}
}

// BinaryInsertionSort sorts a in place.
func BinaryInsertionSort(a []int) {
	binary_insertion_sort_impl(a, int64(len(a)))
}
