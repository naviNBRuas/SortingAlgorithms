package algorithms

// MergeSort returns a new sorted slice using merge sort.
func MergeSort(arr []int) []int {
    if len(arr) <= 1 {
        out := make([]int, len(arr))
        copy(out, arr)
        return out
    }
    mid := len(arr) / 2
    left := MergeSort(arr[:mid])
    right := MergeSort(arr[mid:])
    return merge(left, right)
}

func merge(a, b []int) []int {
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
