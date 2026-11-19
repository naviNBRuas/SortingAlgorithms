// GENERATED from kernels/algos/radix_sort_msd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func radix_sort_msd_x_rec(a []int, tmp []int, mn int64, lo int64, hi int64, exp int64) {
	var i int64
	_ = i
	var d int64
	_ = d
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var _e4 int64
	_ = _e4
	var _e5 int64
	_ = _e5
	var _e6 int64
	_ = _e6
	var count []int
	_ = count
	var start []int
	_ = start
	if ((hi - lo) < 2) || (exp == 0) {
		return
	}
	count = make([]int, int(k_max(1, 11)))
	i = lo
	_e1 = hi
	for i < _e1 {
		count[((((int64(a[i]) - mn) / exp) % 10) + 1)] = int((int64(count[((((int64(a[i])-mn)/exp)%10)+1)]) + 1))
		i = (i + 1)
	}
	d = 1
	_e2 = 11
	for d < _e2 {
		count[d] = int((int64(count[d]) + int64(count[(d-1)])))
		d = (d + 1)
	}
	start = make([]int, int(k_max(1, 11)))
	d = 0
	_e3 = 11
	for d < _e3 {
		start[d] = int(int64(count[d]))
		d = (d + 1)
	}
	i = lo
	_e4 = hi
	for i < _e4 {
		d = (((int64(a[i]) - mn) / exp) % 10)
		tmp[(lo + int64(count[d]))] = int(int64(a[i]))
		count[d] = int((int64(count[d]) + 1))
		i = (i + 1)
	}
	i = lo
	_e5 = hi
	for i < _e5 {
		a[i] = int(int64(tmp[i]))
		i = (i + 1)
	}
	d = 0
	_e6 = 10
	for d < _e6 {
		radix_sort_msd_x_rec(a, tmp, mn, (lo + int64(start[d])), (lo + int64(start[(d+1)])), (exp / 10))
		d = (d + 1)
	}
}

func radix_sort_msd_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var top int64
	_ = top
	var _e1 int64
	_ = _e1
	var tmp []int
	_ = tmp
	if n < 2 {
		return
	}
	mn = int64(a[0])
	mx = int64(a[0])
	i = 1
	_e1 = n
	for i < _e1 {
		if int64(a[i]) < mn {
			mn = int64(a[i])
		}
		if int64(a[i]) > mx {
			mx = int64(a[i])
		}
		i = (i + 1)
	}
	tmp = make([]int, int(k_max(1, n)))
	top = 1
	for ((mx - mn) / top) >= 10 {
		top = (top * 10)
	}
	radix_sort_msd_x_rec(a, tmp, mn, 0, n, top)
}

// RadixSortMsd sorts a in place.
func RadixSortMsd(a []int) {
	radix_sort_msd_impl(a, int64(len(a)))
}
