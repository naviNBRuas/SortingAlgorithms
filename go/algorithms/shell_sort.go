// GENERATED from kernels/algos/shell_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func shell_sort_impl(a []int, n int64) {
	var gap int64
	_ = gap
	var i int64
	_ = i
	var key int64
	_ = key
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	gap = (n / 2)
	for gap > 0 {
		i = gap
		_e1 = n
		for i < _e1 {
			key = int64(a[i])
			j = i
			for (j >= gap) && (int64(a[(j-gap)]) > key) {
				a[j] = int(int64(a[(j - gap)]))
				j = (j - gap)
			}
			a[j] = int(key)
			i = (i + 1)
		}
		gap = (gap / 2)
	}
}

// ShellSort sorts a in place.
func ShellSort(a []int) {
	shell_sort_impl(a, int64(len(a)))
}
