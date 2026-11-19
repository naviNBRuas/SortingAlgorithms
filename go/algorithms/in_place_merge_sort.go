// GENERATED from kernels/algos/in_place_merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func in_place_merge_sort_x_reverse(a []int, i int64, j int64) {
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	j = (j - 1)
	for i < j {
		_i1 = i
		_i2 = j
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		i = (i + 1)
		j = (j - 1)
	}
}

func in_place_merge_sort_x_rotate(a []int, i int64, m int64, j int64) {
	in_place_merge_sort_x_reverse(a, i, m)
	in_place_merge_sort_x_reverse(a, m, j)
	in_place_merge_sort_x_reverse(a, i, j)
}

func in_place_merge_sort_x_merge(a []int, lo int64, mid int64, hi int64) {
	var i int64
	_ = i
	var pivot int64
	_ = pivot
	var l int64
	_ = l
	var h int64
	_ = h
	var m int64
	_ = m
	var j int64
	_ = j
	var nm int64
	_ = nm
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	if (lo >= mid) || (mid >= hi) {
		return
	}
	if (hi - lo) == 2 {
		if int64(a[mid]) < int64(a[lo]) {
			_i1 = lo
			_i2 = mid
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
		}
		return
	}
	if (mid - lo) >= (hi - mid) {
		i = ((lo + mid) / 2)
		pivot = int64(a[i])
		l = mid
		h = hi
		for l < h {
			m = ((l + h) / 2)
			if int64(a[m]) < pivot {
				l = (m + 1)
			} else {
				h = m
			}
		}
		j = l
		in_place_merge_sort_x_rotate(a, i, mid, j)
		nm = (i + (j - mid))
		in_place_merge_sort_x_merge(a, lo, i, nm)
		in_place_merge_sort_x_merge(a, (nm + 1), j, hi)
	} else {
		j = ((mid + hi) / 2)
		pivot = int64(a[j])
		l = lo
		h = mid
		for l < h {
			m = ((l + h) / 2)
			if pivot < int64(a[m]) {
				h = m
			} else {
				l = (m + 1)
			}
		}
		i = l
		in_place_merge_sort_x_rotate(a, i, mid, (j + 1))
		nm = (i + ((j + 1) - mid))
		in_place_merge_sort_x_merge(a, lo, i, (nm - 1))
		in_place_merge_sort_x_merge(a, nm, (j + 1), hi)
	}
}

func in_place_merge_sort_x_rec(a []int, lo int64, hi int64) {
	var mid int64
	_ = mid
	if (hi - lo) < 2 {
		return
	}
	mid = ((lo + hi) / 2)
	in_place_merge_sort_x_rec(a, lo, mid)
	in_place_merge_sort_x_rec(a, mid, hi)
	in_place_merge_sort_x_merge(a, lo, mid, hi)
}

func in_place_merge_sort_impl(a []int, n int64) {
	in_place_merge_sort_x_rec(a, 0, n)
}

// InPlaceMergeSort sorts a in place.
func InPlaceMergeSort(a []int) {
	in_place_merge_sort_impl(a, int64(len(a)))
}
