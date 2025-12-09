package algorithms

// BeadSort sorts non-negative integers via the gravity model; falls back to CountingSort for negatives.
func BeadSort(arr []int) []int {
    hasNegative := false
    max := 0
    for _, v := range arr {
        if v < 0 {
            hasNegative = true
        }
        if v > max {
            max = v
        }
    }
    if hasNegative {
        return CountingSort(arr)
    }
    if len(arr) == 0 || max == 0 {
        out := make([]int, len(arr))
        copy(out, arr)
        return out
    }
    grid := make([][]bool, len(arr))
    for i, v := range arr {
        grid[i] = make([]bool, max)
        for j := 0; j < v; j++ {
            grid[i][j] = true
        }
    }
    for j := 0; j < max; j++ {
        sum := 0
        for i := 0; i < len(arr); i++ {
            if grid[i][j] {
                sum++
            }
        }
        for i := len(arr) - 1; i >= 0; i-- {
            grid[i][j] = sum > 0
            if sum > 0 {
                sum--
            }
        }
    }
    out := make([]int, len(arr))
    for i := 0; i < len(arr); i++ {
        h := 0
        for j := 0; j < max && grid[i][j]; j++ {
            h++
        }
        out[i] = h
    }
    return out
}
