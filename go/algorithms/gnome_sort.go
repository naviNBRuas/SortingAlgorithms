// GENERATED from kernels/algos/gnome_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func gnome_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	i = 0
	for i < n {
		if (i == 0) || (int64(a[(i-1)]) <= int64(a[i])) {
			i = (i + 1)
		} else {
			_i1 = (i - 1)
			_i2 = i
			_t1 = int64(a[_i1])
			a[_i1] = int(int64(a[_i2]))
			a[_i2] = int(_t1)
			i = (i - 1)
		}
	}
}

// GnomeSort sorts a in place.
func GnomeSort(a []int) {
	gnome_sort_impl(a, int64(len(a)))
}
