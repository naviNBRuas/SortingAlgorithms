package algorithms

// CombSort sorts in-place using shrinking gap.
func CombSort(arr []int) {
    n := len(arr)
    gap := n
    swapped := true
    for gap > 1 || swapped {
        gap = int(float64(gap) / 1.3)
        if gap < 1 {
            gap = 1
        }
        swapped = false
        for i := 0; i+gap < n; i++ {
            if arr[i] > arr[i+gap] {
                arr[i], arr[i+gap] = arr[i+gap], arr[i]
                swapped = true
            }
        }
    }
}
