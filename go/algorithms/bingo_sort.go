// GENERATED from kernels/algos/bingo_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func bingo_sort_impl(a []int, n int64) {
	var mx int64
	_ = mx
	var nxt int64
	_ = nxt
	var i int64
	_ = i
	var bingo int64
	_ = bingo
	var _i1 int64
	_ = _i1
	var _i2 int64
	_ = _i2
	var _t1 int64
	_ = _t1
	if n < 2 {
		return
	}
	mx = (n - 1)
	nxt = int64(a[mx])
	i = (mx - 1)
	for i >= 0 {
		if int64(a[i]) > nxt {
			nxt = int64(a[i])
		}
		i = (i - 1)
	}
	for (mx > 0) && (int64(a[mx]) == nxt) {
		mx = (mx - 1)
	}
	for mx > 0 {
		bingo = nxt
		nxt = int64(a[mx])
		i = (mx - 1)
		for i >= 0 {
			if int64(a[i]) == bingo {
				_i1 = i
				_i2 = mx
				_t1 = int64(a[_i1])
				a[_i1] = int(int64(a[_i2]))
				a[_i2] = int(_t1)
				mx = (mx - 1)
			} else {
				if int64(a[i]) > nxt {
					nxt = int64(a[i])
				}
			}
			i = (i - 1)
		}
		for (mx > 0) && (int64(a[mx]) == nxt) {
			mx = (mx - 1)
		}
	}
}

// BingoSort sorts a in place.
func BingoSort(a []int) {
	bingo_sort_impl(a, int64(len(a)))
}
