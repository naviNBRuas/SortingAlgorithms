package algorithms

// RadixSortLSD sorts in-place using least-significant-digit radix sort; supports negatives via offset.
func RadixSortLSD(arr []int) {
    if len(arr) == 0 {
        return
    }
    min := arr[0]
    max := arr[0]
    for _, v := range arr {
        if v < min {
            min = v
        }
        if v > max {
            max = v
        }
    }
    if min < 0 {
        for i := range arr {
            arr[i] -= min
        }
        max -= min
    }
    for exp := 1; max/exp > 0; exp *= 10 {
        countingSortExp(arr, exp)
    }
    if min < 0 {
        for i := range arr {
            arr[i] += min
        }
    }
}

func countingSortExp(arr []int, exp int) {
    n := len(arr)
    output := make([]int, n)
    count := make([]int, 10)
    for i := 0; i < n; i++ {
        digit := (arr[i] / exp) % 10
        count[digit]++
    }
    for i := 1; i < 10; i++ {
        count[i] += count[i-1]
    }
    for i := n - 1; i >= 0; i-- {
        digit := (arr[i] / exp) % 10
        count[digit]--
        output[count[digit]] = arr[i]
    }
    copy(arr, output)
}
