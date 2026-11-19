// GENERATED from kernels/algos/smooth_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

package algorithms

func smooth_sort_x_tz(x int64) int64 {
	var c int64
	_ = c
	c = 0
	for (x % 2) == 0 {
		x = (x / 2)
		c = (c + 1)
	}
	return c
}

func smooth_sort_x_pow2(k int64) int64 {
	var r int64
	_ = r
	var i int64
	_ = i
	var _e1 int64
	_ = _e1
	r = 1
	i = 0
	_e1 = k
	for i < _e1 {
		r = (r * 2)
		i = (i + 1)
	}
	return r
}

func smooth_sort_x_sift(a []int, lp []int, head int64, pshift int64) {
	var val int64
	_ = val
	var going int64
	_ = going
	var rt int64
	_ = rt
	var lf int64
	_ = lf
	val = int64(a[head])
	going = 1
	for (pshift > 1) && (going == 1) {
		rt = (head - 1)
		lf = ((head - 1) - int64(lp[(pshift-2)]))
		if (val >= int64(a[lf])) && (val >= int64(a[rt])) {
			going = 0
		} else {
			if int64(a[lf]) >= int64(a[rt]) {
				a[head] = int(int64(a[lf]))
				head = lf
				pshift = (pshift - 1)
			} else {
				a[head] = int(int64(a[rt]))
				head = rt
				pshift = (pshift - 2)
			}
		}
	}
	a[head] = int(val)
}

func smooth_sort_x_trinkle(a []int, lp []int, head int64, p int64, pshift int64, trusty int64) {
	var val int64
	_ = val
	var going int64
	_ = going
	var stepson int64
	_ = stepson
	var stop int64
	_ = stop
	var rt int64
	_ = rt
	var lf int64
	_ = lf
	var trail int64
	_ = trail
	val = int64(a[head])
	going = 1
	for (p != 1) && (going == 1) {
		stepson = (head - int64(lp[pshift]))
		if int64(a[stepson]) <= val {
			going = 0
		} else {
			stop = 0
			if (trusty == 0) && (pshift > 1) {
				rt = (head - 1)
				lf = ((head - 1) - int64(lp[(pshift-2)]))
				if (int64(a[rt]) >= int64(a[stepson])) || (int64(a[lf]) >= int64(a[stepson])) {
					stop = 1
				}
			}
			if stop == 1 {
				going = 0
			} else {
				a[head] = int(int64(a[stepson]))
				head = stepson
				trail = smooth_sort_x_tz((p - (p % 2)))
				p = (p / smooth_sort_x_pow2(trail))
				pshift = (pshift + trail)
				trusty = 0
			}
		}
	}
	if trusty == 0 {
		a[head] = int(val)
		smooth_sort_x_sift(a, lp, head, pshift)
	}
}

func smooth_sort_impl(a []int, n int64) {
	var i int64
	_ = i
	var hi int64
	_ = hi
	var head int64
	_ = head
	var p int64
	_ = p
	var pshift int64
	_ = pshift
	var trail int64
	_ = trail
	var _e1 int64
	_ = _e1
	var lp []int
	_ = lp
	if n < 2 {
		return
	}
	lp = make([]int, int(k_max(1, 64)))
	lp[0] = int(1)
	lp[1] = int(1)
	i = 2
	_e1 = 64
	for i < _e1 {
		lp[i] = int(((int64(lp[(i-1)]) + int64(lp[(i-2)])) + 1))
		i = (i + 1)
	}
	hi = (n - 1)
	head = 0
	p = 1
	pshift = 1
	for head < hi {
		if (p % 4) == 3 {
			smooth_sort_x_sift(a, lp, head, pshift)
			p = (p / 4)
			pshift = (pshift + 2)
		} else {
			if int64(lp[(pshift-1)]) >= (hi - head) {
				smooth_sort_x_trinkle(a, lp, head, p, pshift, 0)
			} else {
				smooth_sort_x_sift(a, lp, head, pshift)
			}
			if pshift == 1 {
				p = (p * 2)
				pshift = 0
			} else {
				p = (p * smooth_sort_x_pow2((pshift - 1)))
				pshift = 1
			}
		}
		p = ((p + 1) - (p % 2))
		head = (head + 1)
	}
	smooth_sort_x_trinkle(a, lp, head, p, pshift, 0)
	for (pshift != 1) || (p != 1) {
		if pshift <= 1 {
			trail = smooth_sort_x_tz((p - (p % 2)))
			p = (p / smooth_sort_x_pow2(trail))
			pshift = (pshift + trail)
		} else {
			p = (p * 4)
			if ((p / 4) % 2) == 0 {
				p = (p + 7)
			} else {
				p = (p - 1)
			}
			pshift = (pshift - 2)
			smooth_sort_x_trinkle(a, lp, ((head - int64(lp[pshift])) - 1), (p / 2), (pshift + 1), 1)
			smooth_sort_x_trinkle(a, lp, (head - 1), p, pshift, 1)
		}
		head = (head - 1)
	}
}

// SmoothSort sorts a in place.
func SmoothSort(a []int) {
	smooth_sort_impl(a, int64(len(a)))
}
