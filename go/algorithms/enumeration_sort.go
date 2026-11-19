// GENERATED from kernels/algos/enumeration_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func enumeration_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var rank int64
	_ = rank
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _e3 int64
	_ = _e3
	var out []int
	_ = out
	out = make([]int, int(k_max(1, n)))
	i = 0
	_e1 = n
	for i < _e1 {
		rank = 0
		j = 0
		_e2 = n
		for j < _e2 {
			if (int64(a[j]) < int64(a[i])) || ((int64(a[j]) == int64(a[i])) && (j < i)) {
				rank = (rank + 1)
			}
			j = (j + 1)
		}
		out[rank] = int(int64(a[i]))
		i = (i + 1)
	}
	i = 0
	_e3 = n
	for i < _e3 {
		a[i] = int(int64(out[i]))
		i = (i + 1)
	}
}

// EnumerationSort sorts a in place.
func EnumerationSort(a []int) {
	enumeration_sort_impl(a, int64(len(a)))
}
