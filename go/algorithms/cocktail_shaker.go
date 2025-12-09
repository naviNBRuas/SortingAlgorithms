package algorithms

// CocktailShakerSort sorts in-place scanning both directions.
func CocktailShakerSort(arr []int) {
    start, end := 0, len(arr)-1
    swapped := true
    for swapped {
        swapped = false
        for i := start; i < end; i++ {
            if arr[i] > arr[i+1] {
                arr[i], arr[i+1] = arr[i+1], arr[i]
                swapped = true
            }
        }
        if !swapped {
            break
        }
        swapped = false
        end--
        for i := end; i > start; i-- {
            if arr[i] < arr[i-1] {
                arr[i], arr[i-1] = arr[i-1], arr[i]
                swapped = true
            }
        }
        start++
    }
}
