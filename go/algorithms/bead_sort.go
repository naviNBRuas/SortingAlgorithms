// GENERATED from kernels/algos/bead_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bead_sort_x_fallback(a []int, n int64) {
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

func bead_sort_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var maxv int64
	_ = maxv
	var r int64
	_ = r
	var level int64
	_ = level
	var k int64
	_ = k
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
	var ge []int
	_ = ge
	var rods []int
	_ = rods
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
	maxv = (mx - mn)
	if maxv > 20000 {
		bead_sort_x_fallback(a, n)
		return
	}
	ge = make([]int, int(k_max(1, (maxv+2))))
	rods = make([]int, int(k_max(1, n)))
	i = 0
	_e2 = n
	for i < _e2 {
		ge[(int64(a[i]) - mn)] = int((int64(ge[(int64(a[i])-mn)]) + 1))
		i = (i + 1)
	}
	r = maxv
	for r > 0 {
		r = (r - 1)
		ge[r] = int((int64(ge[r]) + int64(ge[(r+1)])))
	}
	level = 1
	_e3 = (maxv + 1)
	for level < _e3 {
		k = 0
		_e4 = int64(ge[level])
		for k < _e4 {
			rods[((n - 1) - k)] = int((int64(rods[((n-1)-k)]) + 1))
			k = (k + 1)
		}
		level = (level + 1)
	}
	i = 0
	_e5 = n
	for i < _e5 {
		a[i] = int((int64(rods[i]) + mn))
		i = (i + 1)
	}
}

// BeadSort sorts a in place.
func BeadSort(a []int) {
	bead_sort_impl(a, int64(len(a)))
}
