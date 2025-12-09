package algorithms

// StoogeSort sorts in-place recursively.
func StoogeSort(arr []int) {
    stoogeSortRec(arr, 0, len(arr)-1)
}

func stoogeSortRec(arr []int, l, h int) {
    if l >= h {
        return
    }
    if arr[l] > arr[h] {
        arr[l], arr[h] = arr[h], arr[l]
    }
    if h-l+1 > 2 {
        t := (h - l + 1) / 3
        stoogeSortRec(arr, l, h-t)
        stoogeSortRec(arr, l+t, h)
        stoogeSortRec(arr, l, h-t)
    }
}
