// GENERATED from kernels/algos/strand_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func strand_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var left int64
	_ = left
	var o int64
	_ = o
	var s int64
	_ = s
	var keep int64
	_ = keep
	var j int64
	_ = j
	var k int64
	_ = k
	var x int64
	_ = x
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var _e4 int64
	_ = _e4
	var rem []int
	_ = rem
	var strand []int
	_ = strand
	var out []int
	_ = out
	var tmp []int
	_ = tmp
	if n < 2 {
		return
	}
	rem = make([]int, int(k_max(1, n)))
	strand = make([]int, int(k_max(1, n)))
	out = make([]int, int(k_max(1, n)))
	tmp = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		rem[i] = int(int64(a[i]))
		i = (i + 1)
	}
	left = n
	o = 0
	for left > 0 {
		strand[0] = int(int64(rem[0]))
		s = 1
		keep = 0
		i = 1
		_e2 = left
		for i < _e2 {
			if int64(rem[i]) >= int64(strand[(s-1)]) {
				strand[s] = int(int64(rem[i]))
				s = (s + 1)
			} else {
				rem[keep] = int(int64(rem[i]))
				keep = (keep + 1)
			}
			i = (i + 1)
		}
		left = keep
		i = 0
		j = 0
		k = 0
		for (i < o) && (j < s) {
			if int64(strand[j]) < int64(out[i]) {
				tmp[k] = int(int64(strand[j]))
				j = (j + 1)
			} else {
				tmp[k] = int(int64(out[i]))
				i = (i + 1)
			}
			k = (k + 1)
		}
		for i < o {
			tmp[k] = int(int64(out[i]))
			i = (i + 1)
			k = (k + 1)
		}
		for j < s {
			tmp[k] = int(int64(strand[j]))
			j = (j + 1)
			k = (k + 1)
		}
		o = k
		x = 0
		_e3 = o
		for x < _e3 {
			out[x] = int(int64(tmp[x]))
			x = (x + 1)
		}
	}
	i = 0
	_e4 = n
	for i < _e4 {
		a[i] = int(int64(out[i]))
		i = (i + 1)
	}
}

// StrandSort sorts a in place.
func StrandSort(a []int) {
	strand_sort_impl(a, int64(len(a)))
}
