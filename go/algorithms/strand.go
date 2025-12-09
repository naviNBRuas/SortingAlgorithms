package algorithms

// StrandSort returns a new sorted slice using strand sorting.
func StrandSort(arr []int) []int {
    in := make([]int, len(arr))
    copy(in, arr)
    out := []int{}
    for len(in) > 0 {
        sub := []int{in[0]}
        in = in[1:]
        i := 0
        for i < len(in) {
            if in[i] >= sub[len(sub)-1] {
                sub = append(sub, in[i])
                in = append(in[:i], in[i+1:]...)
            } else {
                i++
            }
        }
        out = mergeSlices(out, sub)
    }
    return out
}

func mergeSlices(a, b []int) []int {
    res := make([]int, 0, len(a)+len(b))
    i, j := 0, 0
    for i < len(a) && j < len(b) {
        if a[i] <= b[j] {
            res = append(res, a[i])
            i++
        } else {
            res = append(res, b[j])
            j++
        }
    }
    res = append(res, a[i:]...)
    res = append(res, b[j:]...)
    return res
}
