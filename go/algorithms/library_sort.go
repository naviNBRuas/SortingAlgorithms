// GENERATED from kernels/algos/library_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func library_sort_x_locate(vals []int, s []int, size int64, x int64) int64 {
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var mid int64
	_ = mid
	var m int64
	_ = m
	lo = 0
	hi = (size - 1)
	for lo <= hi {
		mid = ((lo + hi) / 2)
		m = mid
		for (m <= hi) && (int64(s[m]) == 0) {
			m = (m + 1)
		}
		if m > hi {
			hi = (mid - 1)
		} else {
			if x < int64(vals[(int64(s[m])-1)]) {
				hi = (mid - 1)
			} else {
				lo = (m + 1)
			}
		}
	}
	return lo
}

func library_sort_impl(a []int, n int64) {
	var size int64
	_ = size
	var i int64
	_ = i
	var nextpow int64
	_ = nextpow
	var k int64
	_ = k
	var cnt int64
	_ = cnt
	var j int64
	_ = j
	var lo int64
	_ = lo
	var p int64
	_ = p
	var q int64
	_ = q
	var g int64
	_ = g
	var out int64
	_ = out
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
	var vals []int
	_ = vals
	var s []int
	_ = s
	var tmp []int
	_ = tmp
	if n < 2 {
		return
	}
	size = ((2 * n) + 2)
	vals = make([]int, int(k_max(1, n)))
	s = make([]int, int(k_max(1, size)))
	tmp = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		vals[i] = int(int64(a[i]))
		i = (i + 1)
	}
	nextpow = 1
	k = 0
	_e2 = n
	for k < _e2 {
		if k == nextpow {
			nextpow = (nextpow * 2)
			cnt = 0
			i = 0
			_e3 = size
			for i < _e3 {
				if int64(s[i]) != 0 {
					tmp[cnt] = int(int64(s[i]))
					cnt = (cnt + 1)
					s[i] = int(0)
				}
				i = (i + 1)
			}
			j = 0
			_e4 = cnt
			for j < _e4 {
				s[((j * size) / cnt)] = int(int64(tmp[j]))
				j = (j + 1)
			}
		}
		lo = library_sort_x_locate(vals, s, size, int64(vals[k]))
		p = (lo - 1)
		for (p >= 0) && (int64(s[p]) == 0) {
			p = (p - 1)
		}
		q = lo
		for (q < size) && (int64(s[q]) == 0) {
			q = (q + 1)
		}
		if (q - p) > 1 {
			s[((p + q) / 2)] = int((k + 1))
		} else {
			g = q
			for (g < size) && (int64(s[g]) != 0) {
				g = (g + 1)
			}
			if g < size {
				j = g
				for j > q {
					s[j] = int(int64(s[(j - 1)]))
					j = (j - 1)
				}
				s[q] = int((k + 1))
			} else {
				g = p
				for int64(s[g]) != 0 {
					g = (g - 1)
				}
				j = g
				for j < p {
					s[j] = int(int64(s[(j + 1)]))
					j = (j + 1)
				}
				s[p] = int((k + 1))
			}
		}
		k = (k + 1)
	}
	out = 0
	i = 0
	_e5 = size
	for i < _e5 {
		if int64(s[i]) != 0 {
			tmp[out] = int(int64(vals[(int64(s[i]) - 1)]))
			out = (out + 1)
		}
		i = (i + 1)
	}
	i = 0
	_e6 = n
	for i < _e6 {
		a[i] = int(int64(tmp[i]))
		i = (i + 1)
	}
}

// LibrarySort sorts a in place.
func LibrarySort(a []int) {
	library_sort_impl(a, int64(len(a)))
}
