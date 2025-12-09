package algorithms

// GnomeSort sorts in-place using a simple swap-based walk.
func GnomeSort(arr []int) {
    for i := 1; i < len(arr); {
        if arr[i] >= arr[i-1] {
            i++
        } else {
            arr[i], arr[i-1] = arr[i-1], arr[i]
            if i > 1 {
                i--
            } else {
                i++
            }
        }
    }
}
