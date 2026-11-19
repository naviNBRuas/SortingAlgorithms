// GENERATED from kernels/algos/bucket_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bucket_sort_impl(a []int, n int64) {
	var mn int64
	_ = mn
	var mx int64
	_ = mx
	var i int64
	_ = i
	var rng int64
	_ = rng
	var b int64
	_ = b
	var lo int64
	_ = lo
	var hi int64
	_ = hi
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
	var _e6 int64
	_ = _e6
	var _e7 int64
	_ = _e7
	var _e8 int64
	_ = _e8
	var count []int
	_ = count
	var out []int
	_ = out
	var start []int
	_ = start
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
	rng = (mx - mn)
	if rng == 0 {
		return
	}
	count = make([]int, int(k_max(1, (n+1))))
	out = make([]int, int(k_max(1, n)))
	i = 0
	_e2 = n
	for i < _e2 {
		count[((((int64(a[i]) - mn) * (n - 1)) / rng) + 1)] = int((int64(count[((((int64(a[i])-mn)*(n-1))/rng)+1)]) + 1))
		i = (i + 1)
	}
	b = 1
	_e3 = (n + 1)
	for b < _e3 {
		count[b] = int((int64(count[b]) + int64(count[(b-1)])))
		b = (b + 1)
	}
	start = make([]int, int(k_max(1, (n+1))))
	b = 0
	_e4 = (n + 1)
	for b < _e4 {
		start[b] = int(int64(count[b]))
		b = (b + 1)
	}
	i = 0
	_e5 = n
	for i < _e5 {
		b = (((int64(a[i]) - mn) * (n - 1)) / rng)
		out[int64(count[b])] = int(int64(a[i]))
		count[b] = int((int64(count[b]) + 1))
		i = (i + 1)
	}
	b = 0
	_e6 = n
	for b < _e6 {
		lo = int64(start[b])
		hi = int64(start[(b + 1)])
		i = (lo + 1)
		_e7 = hi
		for i < _e7 {
			key = int64(out[i])
			j = (i - 1)
			for (j >= lo) && (int64(out[j]) > key) {
				out[(j + 1)] = int(int64(out[j]))
				j = (j - 1)
			}
			out[(j + 1)] = int(key)
			i = (i + 1)
		}
		b = (b + 1)
	}
	i = 0
	_e8 = n
	for i < _e8 {
		a[i] = int(int64(out[i]))
		i = (i + 1)
	}
}

// BucketSort sorts a in place.
func BucketSort(a []int) {
	bucket_sort_impl(a, int64(len(a)))
}
