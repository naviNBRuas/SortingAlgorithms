package algorithms

// BinaryInsertionSort sorts in-place using binary search to locate insertion positions.
func BinaryInsertionSort(arr []int) {
    for i := 1; i < len(arr); i++ {
        key := arr[i]
        l, r := 0, i
        for l < r {
            m := (l + r) / 2
            if arr[m] <= key {
                l = m + 1
            } else {
                r = m
            }
        }
        for j := i; j > l; j-- {
            arr[j] = arr[j-1]
        }
        arr[l] = key
    }
}
