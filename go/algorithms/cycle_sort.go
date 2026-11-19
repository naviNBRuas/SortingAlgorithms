// GENERATED from kernels/algos/cycle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func cycle_sort_x_rank_of(a []int, n int64, start int64, item int64) int64 {
	var pos int64
	_ = pos
	var i int64
	_ = i
	var _e1 int64
	_ = _e1
	pos = start
	i = (start + 1)
	_e1 = n
	for i < _e1 {
		if int64(a[i]) < item {
			pos = (pos + 1)
		}
		i = (i + 1)
	}
	return pos
}

func cycle_sort_impl(a []int, n int64) {
	var start int64
	_ = start
	var item int64
	_ = item
	var pos int64
	_ = pos
	var tmp int64
	_ = tmp
	var _e1 int64
	_ = _e1
	start = 0
	_e1 = (n - 1)
	for start < _e1 {
		item = int64(a[start])
		pos = cycle_sort_x_rank_of(a, n, start, item)
		if pos != start {
			for item == int64(a[pos]) {
				pos = (pos + 1)
			}
			tmp = int64(a[pos])
			a[pos] = int(item)
			item = tmp
			for pos != start {
				pos = cycle_sort_x_rank_of(a, n, start, item)
				for item == int64(a[pos]) {
					pos = (pos + 1)
				}
				tmp = int64(a[pos])
				a[pos] = int(item)
				item = tmp
			}
		}
		start = (start + 1)
	}
}

// CycleSort sorts a in place.
func CycleSort(a []int) {
	cycle_sort_impl(a, int64(len(a)))
}
