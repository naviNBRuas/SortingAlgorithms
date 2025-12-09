package main

import (
    "fmt"
    "math/rand"
    "time"

    "github.com/naviNBRuas/SortingAlgorithms/go/algorithms"
)

func main() {
    seed := time.Now().UnixNano()
    rand.Seed(seed)
    data := rand.Perm(12)

    algos := []struct {
        name string
        fn   func([]int)
        pure func([]int) []int
    }{
        {"bubble", algorithms.BubbleSort, nil},
        {"selection", algorithms.SelectionSort, nil},
        {"insertion", algorithms.InsertionSort, nil},
        {"binary_insertion", algorithms.BinaryInsertionSort, nil},
        {"shell", algorithms.ShellSort, nil},
        {"comb", algorithms.CombSort, nil},
        {"cocktail", algorithms.CocktailShakerSort, nil},
        {"odd_even", algorithms.OddEvenSort, nil},
        {"pancake", algorithms.PancakeSort, nil},
        {"stooge", algorithms.StoogeSort, nil},
        {"gnome", algorithms.GnomeSort, nil},
        {"cycle", algorithms.CycleSort, nil},
        {"bitonic", algorithms.BitonicSort, nil},
        {"quick", algorithms.QuickSort, nil},
        {"heap", algorithms.HeapSort, nil},
        {"radix_lsd", algorithms.RadixSortLSD, nil},
        {"tim", algorithms.TimSort, nil},
        {"intro", algorithms.IntroSort, nil},
        {"smooth", algorithms.SmoothSort, nil},
        {"counting", nil, algorithms.CountingSort},
        {"bucket", nil, algorithms.BucketSort},
        {"pigeonhole", nil, algorithms.PigeonholeSort},
        {"bead", nil, algorithms.BeadSort},
        {"tree", nil, algorithms.TreeSort},
        {"patience", nil, algorithms.PatienceSort},
        {"strand", nil, algorithms.StrandSort},
        {"merge", nil, algorithms.MergeSort},
    }

    fmt.Printf("Seed: %d\n", seed)
    for _, a := range algos {
        copyData := append([]int(nil), data...)
        if a.fn != nil {
            a.fn(copyData)
        } else if a.pure != nil {
            copyData = a.pure(copyData)
        }
        fmt.Printf("%12s -> %v\n", a.name, copyData)
    }
}
