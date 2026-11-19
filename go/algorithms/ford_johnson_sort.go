// GENERATED from kernels/algos/ford_johnson_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func ford_johnson_sort_x_fj(key []int, ids []int, m int64) {
	var h int64
	_ = h
	var k int64
	_ = k
	var x int64
	_ = x
	var y int64
	_ = y
	var total int64
	_ = total
	var size int64
	_ = size
	var prev int64
	_ = prev
	var kk int64
	_ = kk
	var t int64
	_ = t
	var pw int64
	_ = pw
	var c int64
	_ = c
	var top int64
	_ = top
	var i int64
	_ = i
	var bound int64
	_ = bound
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var mid int64
	_ = mid
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
	var small []int
	_ = small
	var big []int
	_ = big
	var bk []int
	_ = bk
	var order []int
	_ = order
	var chain []int
	_ = chain
	var bs []int
	_ = bs
	if m < 2 {
		return
	}
	h = (m / 2)
	small = make([]int, int(k_max(1, h)))
	big = make([]int, int(k_max(1, h)))
	k = 0
	_e1 = h
	for k < _e1 {
		x = int64(ids[(2 * k)])
		y = int64(ids[((2 * k) + 1)])
		if int64(key[y]) < int64(key[x]) {
			small[k] = int(y)
			big[k] = int(x)
		} else {
			small[k] = int(x)
			big[k] = int(y)
		}
		k = (k + 1)
	}
	bk = make([]int, int(k_max(1, h)))
	order = make([]int, int(k_max(1, h)))
	k = 0
	_e2 = h
	for k < _e2 {
		bk[k] = int(int64(key[int64(big[k])]))
		order[k] = int(k)
		k = (k + 1)
	}
	ford_johnson_sort_x_fj(bk, order, h)
	total = h
	if (m % 2) == 1 {
		total = (h + 1)
	}
	chain = make([]int, int(k_max(1, m)))
	bs = make([]int, int(k_max(1, (total+1))))
	chain[0] = int(int64(small[int64(order[0])]))
	k = 0
	_e3 = h
	for k < _e3 {
		chain[(k + 1)] = int(int64(big[int64(order[k])]))
		bs[(k + 1)] = int(int64(small[int64(order[k])]))
		k = (k + 1)
	}
	size = (h + 1)
	if (m % 2) == 1 {
		bs[(h + 1)] = int(int64(ids[(m - 1)]))
	}
	prev = 1
	kk = 2
	for prev < total {
		t = 1
		pw = 1
		c = 0
		for c < (kk + 1) {
			pw = (pw * 2)
			c = (c + 1)
		}
		if (kk % 2) == 0 {
			t = ((pw + 1) / 3)
		} else {
			t = ((pw - 1) / 3)
		}
		top = k_min(t, total)
		i = top
		for i > prev {
			bound = size
			if i <= h {
				bound = 0
				for int64(chain[bound]) != int64(big[int64(order[(i-1)])]) {
					bound = (bound + 1)
				}
			}
			lo = 0
			hi = bound
			for lo < hi {
				mid = ((lo + hi) / 2)
				if int64(key[int64(bs[i])]) < int64(key[int64(chain[mid])]) {
					hi = mid
				} else {
					lo = (mid + 1)
				}
			}
			j = size
			for j > lo {
				chain[j] = int(int64(chain[(j - 1)]))
				j = (j - 1)
			}
			chain[lo] = int(int64(bs[i]))
			size = (size + 1)
			i = (i - 1)
		}
		prev = top
		kk = (kk + 1)
	}
	k = 0
	_e4 = m
	for k < _e4 {
		ids[k] = int(int64(chain[k]))
		k = (k + 1)
	}
}

func ford_johnson_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var key []int
	_ = key
	var ids []int
	_ = ids
	if n < 2 {
		return
	}
	key = make([]int, int(k_max(1, n)))
	ids = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		key[i] = int(int64(a[i]))
		ids[i] = int(i)
		i = (i + 1)
	}
	ford_johnson_sort_x_fj(key, ids, n)
	i = 0
	_e2 = n
	for i < _e2 {
		a[i] = int(int64(key[int64(ids[i])]))
		i = (i + 1)
	}
}

// FordJohnsonSort sorts a in place.
func FordJohnsonSort(a []int) {
	ford_johnson_sort_impl(a, int64(len(a)))
}
