package algorithms

import (
    "errors"
    "math/rand"
    "time"
)

// BogoSort shuffles until sorted or maxShuffles reached; returns error if not sorted.
func BogoSort(arr []int, maxShuffles int) error {
    if len(arr) <= 1 {
        return nil
    }
    rand.Seed(time.Now().UnixNano())
    for s := 0; s < maxShuffles; s++ {
        if isSorted(arr) {
            return nil
        }
        rand.Shuffle(len(arr), func(i, j int) { arr[i], arr[j] = arr[j], arr[i] })
    }
    if !isSorted(arr) {
        return errors.New("bogo sort exceeded maxShuffles")
    }
    return nil
}

func isSorted(arr []int) bool {
    for i := 1; i < len(arr); i++ {
        if arr[i] < arr[i-1] {
            return false
        }
    }
    return true
}
