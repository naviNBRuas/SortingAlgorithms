// GENERATED from kernels/algos/bottom_up_heap_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bottom_up_heap_sort_x_sift(a []int, root int64, size int64) {
	var j int64
	_ = j
	var x int64
	_ = x
	var cur int64
	_ = cur
	var c int64
	_ = c
	j = root
	for ((2 * j) + 2) < size {
		if int64(a[((2*j)+1)]) < int64(a[((2*j)+2)]) {
			j = ((2 * j) + 2)
		} else {
			j = ((2 * j) + 1)
		}
	}
	if ((2 * j) + 1) < size {
		j = ((2 * j) + 1)
	}
	x = int64(a[root])
	for int64(a[j]) < x {
		j = ((j - 1) / 2)
	}
	cur = root
	for cur != j {
		c = j
		for ((c - 1) / 2) != cur {
			c = ((c - 1) / 2)
		}
		a[cur] = int(int64(a[c]))
		cur = c
	}
	a[j] = int(x)
}

func bottom_up_heap_sort_impl(a []int, n int64) {
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
		bottom_up_heap_sort_x_sift(a, s, n)
	}
	end = (n - 1)
	for end > 0 {
		_i1 = 0
		_i2 = end
		_t1 = int64(a[_i1])
		a[_i1] = int(int64(a[_i2]))
		a[_i2] = int(_t1)
		bottom_up_heap_sort_x_sift(a, 0, end)
		end = (end - 1)
	}
}

// BottomUpHeapSort sorts a in place.
func BottomUpHeapSort(a []int) {
	bottom_up_heap_sort_impl(a, int64(len(a)))
}
