package algorithms

// QuickSort sorts in-place using Lomuto partition quicksort.
func QuickSort(arr []int) {
    if len(arr) == 0 {
        return
    }
    quick(arr, 0, len(arr)-1)
}

func quick(arr []int, lo, hi int) {
    if lo < hi {
        p := partition(arr, lo, hi)
        quick(arr, lo, p-1)
        quick(arr, p+1, hi)
    }
}

func partition(arr []int, lo, hi int) int {
    pivot := arr[hi]
    i := lo
    for j := lo; j < hi; j++ {
        if arr[j] <= pivot {
            arr[i], arr[j] = arr[j], arr[i]
            i++
        }
    }
    arr[i], arr[hi] = arr[hi], arr[i]
    return i
}
