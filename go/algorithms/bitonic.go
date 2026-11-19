package algorithms

// BitonicSort is an ascending-only bitonic network (flip-first formulation).
// Comparators outside the slice are skipped, equivalent to padding with +infinity,
// so any length works.
func BitonicSort(arr []int) {
	n := len(arr)
	size := 1
	for size < n {
		size <<= 1
	}
	cmpSwap := func(i, j int) {
		if arr[i] > arr[j] {
			arr[i], arr[j] = arr[j], arr[i]
		}
	}
	for k := 2; k <= size; k <<= 1 {
		for blk := 0; blk < size; blk += k {
			for t := 0; t < k/2; t++ {
				if j := blk + k - 1 - t; j < n {
					cmpSwap(blk+t, j)
				}
			}
		}
		for j := k / 4; j >= 1; j >>= 1 {
			for i := 0; i < size; i++ {
				if i&j == 0 && i+j < n {
					cmpSwap(i, i+j)
				}
			}
		}
	}
}
