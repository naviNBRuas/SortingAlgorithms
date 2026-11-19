// GENERATED from kernels/algos/ternary_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func ternary_heap_sort_x_sift(a []int, root int64, size int64) {
	var going int64
	_ = going
	var first int64
	_ = first
	var best int64
	_ = best
	var c int64
	_ = c
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	going = 1
	for going == 1 {
		first = ((3 * root) + 1)
		if first >= size {
			going = 0
		} else {
			best = first
			c = (first + 1)
			for (c < (first + 3)) && (c < size) {
				if int64(a[best]) < int64(a[c]) {
					best = c
				}
				c = (c + 1)
			}
			if int64(a[root]) < int64(a[best]) {
				_i1 = root
				_i2 = best
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				root = best
			} else {
				going = 0
			}
		}
	}
}

func ternary_heap_sort_impl(a []int, n int64) {
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
	if n < 2 {
		return
	}
	s = (((n - 2) / 3) + 1)
	for s > 0 {
		s = (s - 1)
		ternary_heap_sort_x_sift(a, s, n)
	}
	end = (n - 1)
	for end > 0 {
		_i1 = 0
		_i2 = end
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		ternary_heap_sort_x_sift(a, 0, end)
		end = (end - 1)
	}
}

// TernaryHeapSort sorts a in place.
func TernaryHeapSort(a []int) {
	ternary_heap_sort_impl(a, int64(len(a)))
}
