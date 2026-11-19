// GENERATED from kernels/algos/sleep_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func sleep_sort_x_fallback(a []int, n int64) {
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

func sleep_sort_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var rng int64
	_ = rng
	var t int64
	_ = t
	var out int64
	_ = out
	var node int64
	_ = node
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var head []int
	_ = head
	var nxt []int
	_ = nxt
	var vals []int
	_ = vals
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
		sleep_sort_x_fallback(a, n)
		return
	}
	head = make([]int, int(k_max(1, rng)))
	nxt = make([]int, int(k_max(1, n)))
	i = (n - 1)
	for i >= 0 {
		t = (int64(a[i]) - mn)
		nxt[i] = int(int64(head[t]))
		head[t] = int((i + 1))
		i = (i - 1)
	}
	vals = make([]int, int(k_max(1, n)))
	i = 0
	_e2 = n
	for i < _e2 {
		vals[i] = int(int64(a[i]))
		i = (i + 1)
	}
	out = 0
	t = 0
	_e3 = rng
	for t < _e3 {
		node = int64(head[t])
		for node != 0 {
			a[out] = int(int64(vals[(node - 1)]))
			out = (out + 1)
			node = int64(nxt[(node - 1)])
		}
		t = (t + 1)
	}
}

// SleepSort sorts a in place.
func SleepSort(a []int) {
	sleep_sort_impl(a, int64(len(a)))
}
