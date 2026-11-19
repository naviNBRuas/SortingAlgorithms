// GENERATED from kernels/algos/permutation_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func permutation_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var found int64
	_ = found
	var ok int64
	_ = ok
	var j int64
	_ = j
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	var vals []int
	_ = vals
	var idx []int
	_ = idx
	vals = make([]int, int(k_max(1, n)))
	idx = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		vals[i] = int(int64(a[i]))
		idx[i] = int(i)
		i = (i + 1)
	}
	found = 0
	for found == 0 {
		ok = 1
		i = 0
		_e2 = (n - 1)
		for i < _e2 {
			if int64(vals[int64(idx[(i+1)])]) < int64(vals[int64(idx[i])]) {
				ok = 0
			}
			i = (i + 1)
		}
		if ok == 1 {
			found = 1
		} else {
			i = (n - 2)
			for (i >= 0) && (int64(idx[i]) > int64(idx[(i+1)])) {
				i = (i - 1)
			}
			if i < 0 {
				found = 1
			} else {
				j = (n - 1)
				for int64(idx[j]) < int64(idx[i]) {
					j = (j - 1)
				}
				_i1 = i
				_i2 = j
				_t1 = int64(idx[_i1])
				idx[_i1] = int(int64(idx[_i2]))
				idx[_i2] = int(_t1)
				lo = (i + 1)
				hi = (n - 1)
				for lo < hi {
					_i1 = lo
					_i2 = hi
					_t1 = int64(idx[_i1])
					idx[_i1] = int(int64(idx[_i2]))
					idx[_i2] = int(_t1)
					lo = (lo + 1)
					hi = (hi - 1)
				}
			}
		}
	}
	i = 0
	_e3 = n
	for i < _e3 {
		a[i] = int(int64(vals[int64(idx[i])]))
		i = (i + 1)
	}
}

// PermutationSort sorts a in place.
func PermutationSort(a []int) {
	permutation_sort_impl(a, int64(len(a)))
}
