// GENERATED from kernels/algos/heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func heap_sort_x_sift(a []int, root int64, size int64) {
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
			if ((child + 1) < size) && (int64(a[child]) < int64(a[(child+1)])) {
				child = (child + 1)
			}
			if int64(a[root]) < int64(a[child]) {
				_i1 = root
				_i2 = child
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

func heap_sort_impl(a []int, n int64) {
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
	s = (n / 2)
	for s > 0 {
		s = (s - 1)
		heap_sort_x_sift(a, s, n)
	}
	end = (n - 1)
	for end > 0 {
		_i1 = 0
		_i2 = end
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		heap_sort_x_sift(a, 0, end)
		end = (end - 1)
	}
}

// HeapSort sorts a in place.
func HeapSort(a []int) {
	heap_sort_impl(a, int64(len(a)))
}
