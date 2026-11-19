package algorithms

import "math/bits"

var leonardo = func() []int {
	lp := []int{1, 1}
	for len(lp) < 90 && lp[len(lp)-1] < 1<<40 {
		lp = append(lp, lp[len(lp)-1]+lp[len(lp)-2]+1)
	}
	return lp
}()

func ctzNoLow(p uint64) int { return bits.TrailingZeros64(p &^ 1) }

func smoothSift(a []int, head, pshift int) {
	val := a[head]
	for pshift > 1 {
		rt := head - 1
		lf := head - 1 - leonardo[pshift-2]
		if val >= a[lf] && val >= a[rt] {
			break
		}
		if a[lf] >= a[rt] {
			a[head] = a[lf]
			head = lf
			pshift--
		} else {
			a[head] = a[rt]
			head = rt
			pshift -= 2
		}
	}
	a[head] = val
}

func smoothTrinkle(a []int, head int, p uint64, pshift int, trusty bool) {
	val := a[head]
	for p != 1 {
		stepson := head - leonardo[pshift]
		if a[stepson] <= val {
			break
		}
		if !trusty && pshift > 1 {
			rt := head - 1
			lf := head - 1 - leonardo[pshift-2]
			if a[rt] >= a[stepson] || a[lf] >= a[stepson] {
				break
			}
		}
		a[head] = a[stepson]
		head = stepson
		trail := ctzNoLow(p)
		p >>= uint(trail)
		pshift += trail
		trusty = false
	}
	if !trusty {
		a[head] = val
		smoothSift(a, head, pshift)
	}
}

// SmoothSort is Dijkstra's smoothsort over Leonardo heaps (Orson Peters' formulation):
// O(n) on sorted input, O(n log n) worst case, O(1) extra space.
func SmoothSort(a []int) {
	n := len(a)
	if n < 2 {
		return
	}
	hi := n - 1
	head, p, pshift := 0, uint64(1), 1
	for head < hi {
		if p&3 == 3 {
			smoothSift(a, head, pshift)
			p >>= 2
			pshift += 2
		} else {
			if leonardo[pshift-1] >= hi-head {
				smoothTrinkle(a, head, p, pshift, false)
			} else {
				smoothSift(a, head, pshift)
			}
			if pshift == 1 {
				p <<= 1
				pshift = 0
			} else {
				p <<= uint(pshift - 1)
				pshift = 1
			}
		}
		p |= 1
		head++
	}
	smoothTrinkle(a, head, p, pshift, false)
	for pshift != 1 || p != 1 {
		if pshift <= 1 {
			trail := ctzNoLow(p)
			p >>= uint(trail)
			pshift += trail
		} else {
			p <<= 2
			p ^= 7
			pshift -= 2
			smoothTrinkle(a, head-leonardo[pshift]-1, p>>1, pshift+1, true)
			smoothTrinkle(a, head-1, p, pshift, true)
		}
		head--
	}
}
