// GENERATED from kernels/algos/flash_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func flash_sort_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var m int64
	_ = m
	var rng int64
	_ = rng
	var s int64
	_ = s
	var c int64
	_ = c
	var b int64
	_ = b
	var d int64
	_ = d
	var key int64
	_ = key
	var j int64
	_ = j
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
	if mn == mx {
		return
	}
	m = k_max(2, ((43 * n) / 100))
	rng = (mx - mn)
	count = make([]int, int(k_max(1, m)))
	starts = make([]int, int(k_max(1, (m+1))))
	nxt = make([]int, int(k_max(1, m)))
	i = 0
	_e2 = n
	for i < _e2 {
		count[(((int64(a[i]) - mn) * (m - 1)) / rng)] = int((int64(count[(((int64(a[i])-mn)*(m-1))/rng)]) + 1))
		i = (i + 1)
	}
	s = 0
	c = 0
	_e3 = m
	for c < _e3 {
		starts[c] = int(s)
		nxt[c] = int(s)
		s = (s + int64(count[c]))
		c = (c + 1)
	}
	starts[m] = int(s)
	b = 0
	_e4 = m
	for b < _e4 {
		for int64(nxt[b]) < int64(starts[(b+1)]) {
			d = (((int64(a[int64(nxt[b])]) - mn) * (m - 1)) / rng)
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
	i = 1
	_e5 = n
	for i < _e5 {
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

// FlashSort sorts a in place.
func FlashSort(a []int) {
	flash_sort_impl(a, int64(len(a)))
}
