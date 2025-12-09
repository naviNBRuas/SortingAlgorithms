package algorithms

// CountingSort returns a new sorted slice using counting; handles negative values.
func CountingSort(arr []int) []int {
    if len(arr) == 0 {
        return []int{}
    }
    min, max := arr[0], arr[0]
    for _, v := range arr {
        if v < min {
            min = v
        }
        if v > max {
            max = v
        }
    }
    rng := max - min + 1
    count := make([]int, rng)
    for _, v := range arr {
        count[v-min]++
    }
    for i := 1; i < len(count); i++ {
        count[i] += count[i-1]
    }
    out := make([]int, len(arr))
    for i := len(arr) - 1; i >= 0; i-- {
        v := arr[i]
        count[v-min]--
        out[count[v-min]] = v
    }
    return out
}
