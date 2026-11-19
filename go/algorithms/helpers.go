package algorithms

func k_min(a, b int64) int64 {
	if a < b {
		return a
	}
	return b
}

func k_max(a, b int64) int64 {
	if a > b {
		return a
	}
	return b
}
