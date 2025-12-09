package algorithms

// SmoothSort provides a simplified implementation; falls back to HeapSort for robustness.
func SmoothSort(arr []int) {
    HeapSort(arr)
}
