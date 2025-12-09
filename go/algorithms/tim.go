package algorithms

const minRun = 32

// TimSort sorts in-place using a simplified TimSort.
func TimSort(arr []int) {
    n := len(arr)
    for i := 0; i < n; i += minRun {
        right := i + minRun
        if right > n {
            right = n
        }
        insertionRange(arr, i, right)
    }
    for size := minRun; size < n; size *= 2 {
        for left := 0; left < n; left += 2 * size {
            mid := left + size
            right := left + 2*size
            if mid > n {
                mid = n
            }
            if right > n {
                right = n
            }
            if mid < right {
                mergeInPlace(arr, left, mid, right)
            }
        }
    }
}

func insertionRange(arr []int, l, r int) {
    for i := l + 1; i < r; i++ {
        key := arr[i]
        j := i - 1
        for j >= l && arr[j] > key {
            arr[j+1] = arr[j]
            j--
        }
        arr[j+1] = key
    }
}

func mergeInPlace(arr []int, l, m, r int) {
    left := append([]int(nil), arr[l:m]...)
    right := append([]int(nil), arr[m:r]...)
    i, j, k := 0, 0, l
    for i < len(left) && j < len(right) {
        if left[i] <= right[j] {
            arr[k] = left[i]
            i++
        } else {
            arr[k] = right[j]
            j++
        }
        k++
    }
    for i < len(left) {
        arr[k] = left[i]
        i++
        k++
    }
    for j < len(right) {
        arr[k] = right[j]
        j++
        k++
    }
}
