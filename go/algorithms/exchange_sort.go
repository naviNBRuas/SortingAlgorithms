// GENERATED from kernels/algos/exchange_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func exchange_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var j int64
	_ = j
	var _e1 int64
	_ = _e1
	var _e2 int64
	_ = _e2
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	i = 0
	_e1 = (n - 1)
	for i < _e1 {
		j = (i + 1)
		_e2 = n
		for j < _e2 {
			if int64(a[j]) < int64(a[i]) {
				_i1 = i
				_i2 = j
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
			}
			j = (j + 1)
		}
		i = (i + 1)
	}
}

// ExchangeSort sorts a in place.
func ExchangeSort(a []int) {
	exchange_sort_impl(a, int64(len(a)))
}
