// GENERATED from kernels/algos/merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func merge_sort_x_rec(a []int, tmp []int, lo int64, hi int64) {
	var mid int64
	_ = mid
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
	if (hi - lo) < 2 {
		return
	}
	mid = ((lo + hi) / 2)
	merge_sort_x_rec(a, tmp, lo, mid)
	merge_sort_x_rec(a, tmp, mid, hi)
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
}

func merge_sort_impl(a []int, n int64) {
	var tmp []int
	_ = tmp
	tmp = make([]int, int(k_max(1, n)))
	merge_sort_x_rec(a, tmp, 0, n)
}

// MergeSort sorts a in place.
func MergeSort(a []int) {
	merge_sort_impl(a, int64(len(a)))
}
