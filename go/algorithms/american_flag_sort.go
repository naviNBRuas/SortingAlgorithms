// GENERATED from kernels/algos/american_flag_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func american_flag_sort_x_rec(a []int, mn int64, lo int64, hi int64, exp int64) {
	var i int64
	_ = i
	var s int64
	_ = s
	var d int64
	_ = d
	var b int64
	_ = b
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var _e4 int64
	_ = _e4
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	var count []int
	_ = count
	var starts []int
	_ = starts
	var nxt []int
	_ = nxt
	if ((hi - lo) < 2) || (exp == 0) {
		return
	}
	count = make([]int, int(k_max(1, 10)))
	starts = make([]int, int(k_max(1, 11)))
	nxt = make([]int, int(k_max(1, 10)))
	i = lo
	_e1 = hi
	for i < _e1 {
		count[(((int64(a[i]) - mn) / exp) % 10)] = int((int64(count[(((int64(a[i])-mn)/exp)%10)]) + 1))
		i = (i + 1)
	}
	s = lo
	d = 0
	_e2 = 10
	for d < _e2 {
		starts[d] = int(s)
		nxt[d] = int(s)
		s = (s + int64(count[d]))
		d = (d + 1)
	}
	starts[10] = int(s)
	b = 0
	_e3 = 10
	for b < _e3 {
		for int64(nxt[b]) < int64(starts[(b+1)]) {
			d = (((int64(a[int64(nxt[b])]) - mn) / exp) % 10)
			if d == b {
				nxt[b] = int((int64(nxt[b]) + 1))
			} else {
				_i1 = int64(nxt[b])
				_i2 = int64(nxt[d])
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				nxt[d] = int((int64(nxt[d]) + 1))
			}
		}
		b = (b + 1)
	}
	b = 0
	_e4 = 10
	for b < _e4 {
		american_flag_sort_x_rec(a, mn, int64(starts[b]), int64(starts[(b+1)]), (exp / 10))
		b = (b + 1)
	}
}

func american_flag_sort_impl(a []int, n int64) {
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
	top = 1
	for ((mx - mn) / top) >= 10 {
		top = (top * 10)
	}
	american_flag_sort_x_rec(a, mn, 0, n, top)
}

// AmericanFlagSort sorts a in place.
func AmericanFlagSort(a []int) {
	american_flag_sort_impl(a, int64(len(a)))
}
