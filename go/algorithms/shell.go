package algorithms

// ShellSort sorts in-place using Shell's method with gap sequence halving.
func ShellSort(arr []int) {
    for gap := len(arr) / 2; gap > 0; gap /= 2 {
        for i := gap; i < len(arr); i++ {
            temp := arr[i]
            j := i
            for j >= gap && arr[j-gap] > temp {
                arr[j] = arr[j-gap]
                j -= gap
            }
            arr[j] = temp
        }
    }
}
