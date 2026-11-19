// GENERATED from kernels/algos/counting_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func counting_sort_x_fallback(a []int, n int64) {
	var gap int64
	_ = gap
	var i int64
	_ = i
	var key int64
	_ = key
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	gap = (n / 2)
	for gap > 0 {
		i = gap
		_e1 = n
		for i < _e1 {
			key = int64(a[i])
			j = i
			for (j >= gap) && (int64(a[(j-gap)]) > key) {
				a[j] = int(int64(a[(j - gap)]))
				j = (j - gap)
			}
			a[j] = int(key)
			i = (i + 1)
		}
		gap = (gap / 2)
	}
}

func counting_sort_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var rng int64
	_ = rng
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
	var count []int
	_ = count
	var out []int
	_ = out
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
	rng = ((mx - mn) + 1)
	if rng > 4000000 {
		counting_sort_x_fallback(a, n)
		return
	}
	count = make([]int, int(k_max(1, (rng+1))))
	out = make([]int, int(k_max(1, n)))
	i = 0
	_e2 = n
	for i < _e2 {
		count[((int64(a[i]) - mn) + 1)] = int((int64(count[((int64(a[i])-mn)+1)]) + 1))
		i = (i + 1)
	}
	i = 1
	_e3 = (rng + 1)
	for i < _e3 {
		count[i] = int((int64(count[i]) + int64(count[(i-1)])))
		i = (i + 1)
	}
	i = 0
	_e4 = n
	for i < _e4 {
		out[int64(count[(int64(a[i])-mn)])] = int(int64(a[i]))
		count[(int64(a[i]) - mn)] = int((int64(count[(int64(a[i])-mn)]) + 1))
		i = (i + 1)
	}
	i = 0
	_e5 = n
	for i < _e5 {
		a[i] = int(int64(out[i]))
		i = (i + 1)
	}
}

// CountingSort sorts a in place.
func CountingSort(a []int) {
	counting_sort_impl(a, int64(len(a)))
}
