package algorithms

import "math"

// IntroSort sorts in-place combining quicksort and heapsort fallback.
func IntroSort(arr []int) {
    if len(arr) <= 1 {
        return
    }
    depthLimit := int(2 * math.Log(float64(len(arr))))
    introRec(arr, 0, len(arr)-1, depthLimit)
}

func introRec(arr []int, low, high, depth int) {
    if high-low <= 16 {
        insertionRange(arr, low, high+1)
        return
    }
    if depth == 0 {
        heapSortRange(arr, low, high)
        return
    }
    p := partition(arr, low, high)
    if p > low {
        introRec(arr, low, p-1, depth-1)
    }
    if p+1 < high {
        introRec(arr, p+1, high, depth-1)
    }
}

func partition(arr []int, low, high int) int {
    pivot := arr[high]
    i := low
    for j := low; j < high; j++ {
        if arr[j] < pivot {
            arr[i], arr[j] = arr[j], arr[i]
            i++
        }
    }
    arr[i], arr[high] = arr[high], arr[i]
    return i
}

func heapSortRange(arr []int, low, high int) {
    n := high - low + 1
    for i := n/2 - 1; i >= 0; i-- {
        heapifyRange(arr, n, i, low)
    }
    for i := n - 1; i > 0; i-- {
        arr[low], arr[low+i] = arr[low+i], arr[low]
        heapifyRange(arr, i, 0, low)
    }
}

func heapifyRange(arr []int, n, i, offset int) {
    largest := i
    l := 2*i + 1
    r := 2*i + 2
    if l < n && arr[offset+l] > arr[offset+largest] {
        largest = l
    }
    if r < n && arr[offset+r] > arr[offset+largest] {
        largest = r
    }
    if largest != i {
        arr[offset+i], arr[offset+largest] = arr[offset+largest], arr[offset+i]
        heapifyRange(arr, n, largest, offset)
    }
}
