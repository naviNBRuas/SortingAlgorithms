// GENERATED from kernels/algos/intro_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func intro_sort_x_insertion(a []int, lo int64, hi int64) {
	var i int64
	_ = i
	var key int64
	_ = key
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	i = (lo + 1)
	_e1 = (hi + 1)
	for i < _e1 {
		key = int64(a[i])
		j = (i - 1)
		for (j >= lo) && (int64(a[j]) > key) {
			a[(j + 1)] = int(int64(a[j]))
			j = (j - 1)
		}
		a[(j + 1)] = int(key)
		i = (i + 1)
	}
}

func intro_sort_x_sift(a []int, base int64, root int64, size int64) {
	var going int64
	_ = going
	var child int64
	_ = child
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	going = 1
	for going == 1 {
		child = ((2 * root) + 1)
		if child >= size {
			going = 0
		} else {
			if ((child + 1) < size) && (int64(a[(base+child)]) < int64(a[((base+child)+1)])) {
				child = (child + 1)
			}
			if int64(a[(base+root)]) < int64(a[(base+child)]) {
				_i1 = (base + root)
				_i2 = (base + child)
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				root = child
			} else {
				going = 0
			}
		}
	}
}

func intro_sort_x_heap(a []int, lo int64, hi int64) {
	var size int64
	_ = size
	var s int64
	_ = s
	var end int64
	_ = end
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	size = ((hi - lo) + 1)
	s = (size / 2)
	for s > 0 {
		s = (s - 1)
		intro_sort_x_sift(a, lo, s, size)
	}
	end = (size - 1)
	for end > 0 {
		_i1 = lo
		_i2 = (lo + end)
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		intro_sort_x_sift(a, lo, 0, end)
		end = (end - 1)
	}
}

func intro_sort_x_sort(a []int, lo int64, hi int64, depth int64) {
	var mid int64
	_ = mid
	var pivot int64
	_ = pivot
	var i int64
	_ = i
	var j int64
	_ = j
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	for ((hi - lo) + 1) > 16 {
		if depth == 0 {
			intro_sort_x_heap(a, lo, hi)
			return
		}
		depth = (depth - 1)
		mid = ((lo + hi) / 2)
		if int64(a[mid]) < int64(a[lo]) {
			_i1 = mid
			_i2 = lo
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
		}
		if int64(a[hi]) < int64(a[lo]) {
			_i1 = hi
			_i2 = lo
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
		}
		if int64(a[hi]) < int64(a[mid]) {
			_i1 = hi
			_i2 = mid
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
		}
		pivot = int64(a[mid])
		i = lo
		j = hi
		for i <= j {
			for int64(a[i]) < pivot {
				i = (i + 1)
			}
			for int64(a[j]) > pivot {
				j = (j - 1)
			}
			if i <= j {
				_i1 = i
				_i2 = j
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				i = (i + 1)
				j = (j - 1)
			}
		}
		intro_sort_x_sort(a, lo, j, depth)
		lo = i
	}
	intro_sort_x_insertion(a, lo, hi)
}

func intro_sort_impl(a []int, n int64) {
	var depth int64
	_ = depth
	var t int64
	_ = t
	depth = 0
	t = n
	for t > 1 {
		t = (t / 2)
		depth = (depth + 2)
	}
	intro_sort_x_sort(a, 0, (n - 1), depth)
}

// IntroSort sorts a in place.
func IntroSort(a []int) {
	intro_sort_impl(a, int64(len(a)))
}
