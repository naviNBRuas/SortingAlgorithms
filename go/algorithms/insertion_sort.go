// GENERATED from kernels/algos/insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func insertion_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var key int64
	_ = key
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	i = 1
	_e1 = n
	for i < _e1 {
		key = int64(a[i])
		j = (i - 1)
		for (j >= 0) && (int64(a[j]) > key) {
			a[(j + 1)] = int(int64(a[j]))
			j = (j - 1)
		}
		a[(j + 1)] = int(key)
		i = (i + 1)
	}
}

// InsertionSort sorts a in place.
func InsertionSort(a []int) {
	insertion_sort_impl(a, int64(len(a)))
}
