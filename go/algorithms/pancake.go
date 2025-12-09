package algorithms

// PancakeSort sorts in-place using prefix flips.
func PancakeSort(arr []int) {
    for curr := len(arr); curr > 1; curr-- {
        maxIdx := 0
        for i := 1; i < curr; i++ {
            if arr[i] > arr[maxIdx] {
                maxIdx = i
            }
        }
        if maxIdx == curr-1 {
            continue
        }
        flip(arr, maxIdx)
        flip(arr, curr-1)
    }
}

func flip(arr []int, k int) {
    for i, j := 0, k; i < j; i, j = i+1, j-1 {
        arr[i], arr[j] = arr[j], arr[i]
    }
}
