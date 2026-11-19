// GENERATED from kernels/algos/tim_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func tim_sort_x_insertion(a []int, lo int64, hi int64) {
	var i int64
	_ = i
	var key int64
	_ = key
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	i = (lo + 1)
	_e1 = hi
	for i < _e1 {
		key = int64(a[i])
		j = (i - 1)
		for (j >= lo) && (int64(a[j]) > key) {
			a[(j + 1)] = int(int64(a[j]))
			j = (j - 1)
		}
		a[(j + 1)] = int(key)
		i = (i + 1)
	}
}

func tim_sort_x_merge_at(a []int, tmp []int, rs []int, rl []int, cnt int64, i int64) int64 {
	var s1 int64
	_ = s1
	var l1 int64
	_ = l1
	var l2 int64
	_ = l2
	var x int64
	_ = x
	var j int64
	_ = j
	var k int64
	_ = k
	var end int64
	_ = end
	var t int64
	_ = t
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	s1 = int64(rs[i])
	l1 = int64(rl[i])
	l2 = int64(rl[(i + 1)])
	x = 0
	_e1 = l1
	for x < _e1 {
		tmp[x] = int(int64(a[(s1 + x)]))
		x = (x + 1)
	}
	x = 0
	j = (s1 + l1)
	k = s1
	end = (j + l2)
	for (x < l1) && (j < end) {
		if int64(a[j]) < int64(tmp[x]) {
			a[k] = int(int64(a[j]))
			j = (j + 1)
		} else {
			a[k] = int(int64(tmp[x]))
			x = (x + 1)
		}
		k = (k + 1)
	}
	for x < l1 {
		a[k] = int(int64(tmp[x]))
		x = (x + 1)
		k = (k + 1)
	}
	rl[i] = int((l1 + l2))
	t = (i + 1)
	_e2 = (cnt - 1)
	for t < _e2 {
		rs[t] = int(int64(rs[(t + 1)]))
		rl[t] = int(int64(rl[(t + 1)]))
		t = (t + 1)
	}
	return (cnt - 1)
}

func tim_sort_x_collapse(a []int, tmp []int, rs []int, rl []int, cnt int64) int64 {
	var going int64
	_ = going
	var m int64
	_ = m
	var need int64
	_ = need
	going = 1
	for (going == 1) && (cnt > 1) {
		m = (cnt - 2)
		need = 0
		if (m > 0) && (int64(rl[(m-1)]) <= (int64(rl[m]) + int64(rl[(m+1)]))) {
			need = 1
		}
		if (m > 1) && (int64(rl[(m-2)]) <= (int64(rl[(m-1)]) + int64(rl[m]))) {
			need = 1
		}
		if need == 1 {
			if (m > 0) && (int64(rl[(m-1)]) < int64(rl[(m+1)])) {
				m = (m - 1)
			}
			cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m)
		} else {
			if int64(rl[m]) <= int64(rl[(m+1)]) {
				cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m)
			} else {
				going = 0
			}
		}
	}
	return cnt
}

func tim_sort_impl(a []int, n int64) {
	var r int64
	_ = r
	var t int64
	_ = t
	var minrun int64
	_ = minrun
	var cnt int64
	_ = cnt
	var lo int64
	_ = lo
	var e int64
	_ = e
	var x int64
	_ = x
	var y int64
	_ = y
	var force int64
	_ = force
	var m int64
	_ = m
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	var tmp []int
	_ = tmp
	var rs []int
	_ = rs
	var rl []int
	_ = rl
	if n < 2 {
		return
	}
	tmp = make([]int, int(k_max(1, n)))
	rs = make([]int, int(k_max(1, 128)))
	rl = make([]int, int(k_max(1, 128)))
	r = 0
	t = n
	for t >= 64 {
		r = (r + (t % 2))
		if r > 1 {
			r = 1
		}
		t = (t / 2)
	}
	minrun = (t + r)
	cnt = 0
	lo = 0
	for lo < n {
		e = (lo + 1)
		if e < n {
			if int64(a[e]) < int64(a[(e-1)]) {
				for (e < n) && (int64(a[e]) < int64(a[(e-1)])) {
					e = (e + 1)
				}
				x = lo
				y = (e - 1)
				for x < y {
					_i1 = x
					_i2 = y
					_t1 = int64(a[_i1])
					a[_i1] = int(int64(a[_i2]))
					a[_i2] = int(_t1)
					x = (x + 1)
					y = (y - 1)
				}
			} else {
				for (e < n) && (int64(a[e]) >= int64(a[(e-1)])) {
					e = (e + 1)
				}
			}
		}
		force = k_min(minrun, (n - lo))
		if (e - lo) < force {
			tim_sort_x_insertion(a, lo, (lo + force))
			e = (lo + force)
		}
		rs[cnt] = int(lo)
		rl[cnt] = int((e - lo))
		cnt = (cnt + 1)
		cnt = tim_sort_x_collapse(a, tmp, rs, rl, cnt)
		lo = e
	}
	for cnt > 1 {
		m = (cnt - 2)
		if (m > 0) && (int64(rl[(m-1)]) < int64(rl[(m+1)])) {
			m = (m - 1)
		}
		cnt = tim_sort_x_merge_at(a, tmp, rs, rl, cnt, m)
	}
}

// TimSort sorts a in place.
func TimSort(a []int) {
	tim_sort_impl(a, int64(len(a)))
}
