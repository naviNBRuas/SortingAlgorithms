package algorithms

// BitonicSort sorts in-place; works best when length is a power of two.
func BitonicSort(arr []int) {
    if len(arr) == 0 {
        return
    }
    bitonicSortRec(arr, 0, len(arr), true)
}

func bitonicSortRec(arr []int, low, cnt int, dir bool) {
    if cnt <= 1 {
        return
    }
    k := cnt / 2
    bitonicSortRec(arr, low, k, true)
    bitonicSortRec(arr, low+k, cnt-k, false)
    bitonicMerge(arr, low, cnt, dir)
}

func bitonicMerge(arr []int, low, cnt int, dir bool) {
    if cnt <= 1 {
        return
    }
    k := cnt / 2
    for i := low; i < low+k && i+k < low+cnt; i++ {
        if (dir && arr[i] > arr[i+k]) || (!dir && arr[i] < arr[i+k]) {
            arr[i], arr[i+k] = arr[i+k], arr[i]
        }
    }
    bitonicMerge(arr, low, k, dir)
    bitonicMerge(arr, low+k, cnt-k, dir)
}
