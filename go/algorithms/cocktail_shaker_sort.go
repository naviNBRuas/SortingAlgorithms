// GENERATED from kernels/algos/cocktail_shaker_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func cocktail_shaker_sort_impl(a []int, n int64) {
	var lo int64
	_ = lo
	var hi int64
	_ = hi
	var swapped int64
	_ = swapped
	var i int64
	_ = i
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	lo = 0
	hi = (n - 1)
	swapped = 1
	for (lo < hi) && (swapped == 1) {
		swapped = 0
		i = lo
		for i < hi {
			if int64(a[i]) > int64(a[(i+1)]) {
				_i1 = i
				_i2 = (i + 1)
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				swapped = 1
			}
			i = (i + 1)
		}
		hi = (hi - 1)
		i = hi
		for i > lo {
			if int64(a[(i-1)]) > int64(a[i]) {
				_i1 = (i - 1)
				_i2 = i
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				swapped = 1
			}
			i = (i - 1)
		}
		lo = (lo + 1)
	}
}

// CocktailShakerSort sorts a in place.
func CocktailShakerSort(a []int) {
	cocktail_shaker_sort_impl(a, int64(len(a)))
}
