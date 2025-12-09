package algorithms

// PatienceSort returns a new sorted slice using pile-based patience sorting.
func PatienceSort(arr []int) []int {
    n := len(arr)
    if n == 0 {
        return []int{}
    }
    piles := make([][]int, 0, n)
    for _, x := range arr {
        l, r := 0, len(piles)
        for l < r {
            m := (l + r) / 2
            top := piles[m][len(piles[m])-1]
            if top >= x {
                r = m
            } else {
                l = m + 1
            }
        }
        if l == len(piles) {
            piles = append(piles, []int{x})
        } else {
            piles[l] = append(piles[l], x)
        }
    }
    out := make([]int, 0, n)
    for len(piles) > 0 {
        minIdx := 0
        minVal := piles[0][len(piles[0])-1]
        for i := 1; i < len(piles); i++ {
            top := piles[i][len(piles[i])-1]
            if top < minVal {
                minVal = top
                minIdx = i
            }
        }
        out = append(out, minVal)
        pile := piles[minIdx]
        pile = pile[:len(pile)-1]
        if len(pile) == 0 {
            piles = append(piles[:minIdx], piles[minIdx+1:]...)
        } else {
            piles[minIdx] = pile
        }
    }
    return out
}
