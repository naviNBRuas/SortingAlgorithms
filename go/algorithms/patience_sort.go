// GENERATED from kernels/algos/patience_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func patience_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var piles int64
	_ = piles
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var mid int64
	_ = mid
	var out int64
	_ = out
	var best int64
	_ = best
	var p int64
	_ = p
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var _e4 int64
	_ = _e4
	var vals []int
	_ = vals
	var prev []int
	_ = prev
	var top []int
	_ = top
	if n < 2 {
		return
	}
	vals = make([]int, int(k_max(1, n)))
	prev = make([]int, int(k_max(1, n)))
	top = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		vals[i] = int(int64(a[i]))
		i = (i + 1)
	}
	piles = 0
	i = 0
	_e2 = n
	for i < _e2 {
		lo = 0
		hi = piles
		for lo < hi {
			mid = ((lo + hi) / 2)
			if int64(vals[(int64(top[mid])-1)]) < int64(vals[i]) {
				lo = (mid + 1)
			} else {
				hi = mid
			}
		}
		prev[i] = int(int64(top[lo]))
		top[lo] = int((i + 1))
		if lo == piles {
			piles = (piles + 1)
		}
		i = (i + 1)
	}
	out = 0
	_e3 = n
	for out < _e3 {
		best = (-1)
		p = 0
		_e4 = piles
		for p < _e4 {
			if int64(top[p]) != 0 {
				if (best < 0) || (int64(vals[(int64(top[p])-1)]) < int64(vals[(int64(top[best])-1)])) {
					best = p
				}
			}
			p = (p + 1)
		}
		a[out] = int(int64(vals[(int64(top[best]) - 1)]))
		top[best] = int(int64(prev[(int64(top[best]) - 1)]))
		out = (out + 1)
	}
}

// PatienceSort sorts a in place.
func PatienceSort(a []int) {
	patience_sort_impl(a, int64(len(a)))
}
