package algorithms

// OddEvenSort sorts in-place by alternating odd and even phases.
func OddEvenSort(arr []int) {
    n := len(arr)
    sorted := false
    for !sorted {
        sorted = true
        for i := 1; i <= n-2; i += 2 {
            if arr[i] > arr[i+1] {
                arr[i], arr[i+1] = arr[i+1], arr[i]
                sorted = false
            }
        }
        for i := 0; i <= n-2; i += 2 {
            if arr[i] > arr[i+1] {
                arr[i], arr[i+1] = arr[i+1], arr[i]
                sorted = false
            }
        }
    }
}
