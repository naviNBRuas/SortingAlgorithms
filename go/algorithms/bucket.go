package algorithms

// BucketSort returns a new sorted slice using bucket sort with insertion ordering inside buckets.
func BucketSort(arr []int) []int {
    n := len(arr)
    if n == 0 {
        return []int{}
    }
    min, max := arr[0], arr[0]
    for _, v := range arr {
        if v < min {
            min = v
        }
        if v > max {
            max = v
        }
    }
    bucketCount := n
    buckets := make([][]int, bucketCount)
    rng := float64(max - min + 1)
    for _, v := range arr {
        idx := int(float64(v-min) / rng * float64(bucketCount))
        if idx >= bucketCount {
            idx = bucketCount - 1
        }
        buckets[idx] = insertSorted(buckets[idx], v)
    }
    out := make([]int, 0, n)
    for _, b := range buckets {
        out = append(out, b...)
    }
    return out
}

func insertSorted(bucket []int, v int) []int {
    bucket = append(bucket, v)
    i := len(bucket) - 2
    for i >= 0 && bucket[i] > v {
        bucket[i+1] = bucket[i]
        i--
    }
    bucket[i+1] = v
    return bucket
}
