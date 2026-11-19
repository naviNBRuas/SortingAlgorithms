// GENERATED from kernels/algos/pigeonhole_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func pigeonhole_sort_x_fallback(a []int, n int64) {
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

func pigeonhole_sort_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var rng int64
	_ = rng
	var k int64
	_ = k
	var h int64
	_ = h
	var c int64
	_ = c
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var holes []int
	_ = holes
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
		pigeonhole_sort_x_fallback(a, n)
		return
	}
	holes = make([]int, int(k_max(1, rng)))
	i = 0
	_e2 = n
	for i < _e2 {
		holes[(int64(a[i]) - mn)] = int((int64(holes[(int64(a[i])-mn)]) + 1))
		i = (i + 1)
	}
	k = 0
	h = 0
	_e3 = rng
	for h < _e3 {
		c = int64(holes[h])
		for c > 0 {
			a[k] = int((mn + h))
			k = (k + 1)
			c = (c - 1)
		}
		h = (h + 1)
	}
}

// PigeonholeSort sorts a in place.
func PigeonholeSort(a []int) {
	pigeonhole_sort_impl(a, int64(len(a)))
}
