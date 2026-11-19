// GENERATED from kernels/algos/shell_sort_ciura.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func shell_sort_ciura_impl(a []int, n int64) {
	var k int64
	_ = k
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
	var g []int
	_ = g
	g = make([]int, int(k_max(1, 10)))
	g[0] = int(1)
	g[1] = int(4)
	g[2] = int(10)
	g[3] = int(23)
	g[4] = int(57)
	g[5] = int(132)
	g[6] = int(301)
	g[7] = int(701)
	g[8] = int(1750)
	g[9] = int(4377)
	k = 9
	for k >= 0 {
		gap = int64(g[k])
		if gap < n {
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
		}
		k = (k - 1)
	}
}

// ShellSortCiura sorts a in place.
func ShellSortCiura(a []int) {
	shell_sort_ciura_impl(a, int64(len(a)))
}
