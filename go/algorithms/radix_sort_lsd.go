// GENERATED from kernels/algos/radix_sort_lsd.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func radix_sort_lsd_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var exp int64
	_ = exp
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
	var out []int
	_ = out
	var count []int
	_ = count
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
	out = make([]int, int(k_max(1, n)))
	count = make([]int, int(k_max(1, 11)))
	exp = 1
	for ((mx - mn) / exp) > 0 {
		d = 0
		_e2 = 11
		for d < _e2 {
			count[d] = int(0)
			d = (d + 1)
		}
		i = 0
		_e3 = n
		for i < _e3 {
			count[((((int64(a[i]) - mn) / exp) % 10) + 1)] = int((int64(count[((((int64(a[i])-mn)/exp)%10)+1)]) + 1))
			i = (i + 1)
		}
		d = 1
		_e4 = 11
		for d < _e4 {
			count[d] = int((int64(count[d]) + int64(count[(d-1)])))
			d = (d + 1)
		}
		i = 0
		_e5 = n
		for i < _e5 {
			d = (((int64(a[i]) - mn) / exp) % 10)
			out[int64(count[d])] = int(int64(a[i]))
			count[d] = int((int64(count[d]) + 1))
			i = (i + 1)
		}
		i = 0
		_e6 = n
		for i < _e6 {
			a[i] = int(int64(out[i]))
			i = (i + 1)
		}
		exp = (exp * 10)
	}
}

// RadixSortLsd sorts a in place.
func RadixSortLsd(a []int) {
	radix_sort_lsd_impl(a, int64(len(a)))
}
