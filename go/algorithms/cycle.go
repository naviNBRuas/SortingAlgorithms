package algorithms

// CycleSort minimizes writes by rotating cycles; sorts in-place.
func CycleSort(arr []int) {
    n := len(arr)
    for cycleStart := 0; cycleStart+1 < n; cycleStart++ {
        item := arr[cycleStart]
        pos := cycleStart
        for i := cycleStart + 1; i < n; i++ {
            if arr[i] < item {
                pos++
            }
        }
        if pos == cycleStart {
            continue
        }
        for pos < n && item == arr[pos] {
            pos++
        }
        if pos < n {
            arr[pos], item = item, arr[pos]
        }
        for pos != cycleStart {
            pos = cycleStart
            for i := cycleStart + 1; i < n; i++ {
                if arr[i] < item {
                    pos++
                }
            }
            for pos < n && item == arr[pos] {
                pos++
            }
            if pos < n {
                arr[pos], item = item, arr[pos]
            }
        }
    }
}
