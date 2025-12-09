package algorithms

// PigeonholeSort returns a new sorted slice using pigeonhole counting.
func PigeonholeSort(arr []int) []int {
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
    holes := make([]int, max-min+1)
    for _, v := range arr {
        holes[v-min]++
    }
    out := make([]int, 0, len(arr))
    for i, c := range holes {
        for c > 0 {
            out = append(out, i+min)
            c--
        }
    }
    return out
}
