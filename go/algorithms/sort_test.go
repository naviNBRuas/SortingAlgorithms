package algorithms

import (
	"math/rand"
	"sort"
	"testing"
)

var inPlace = map[string]func([]int){
	"bubble": BubbleSort, "selection": SelectionSort, "insertion": InsertionSort,
	"binary_insertion": BinaryInsertionSort, "shell": ShellSort, "comb": CombSort,
	"cocktail": CocktailShakerSort, "odd_even": OddEvenSort, "pancake": PancakeSort,
	"stooge": StoogeSort, "gnome": GnomeSort, "cycle": CycleSort, "bitonic": BitonicSort,
	"quick": QuickSort, "heap": HeapSort, "radix_lsd": RadixSortLSD, "tim": TimSort,
	"intro": IntroSort, "smooth": SmoothSort,
}

var pure = map[string]func([]int) []int{
	"counting": CountingSort, "bucket": BucketSort, "pigeonhole": PigeonholeSort,
	"bead": BeadSort, "tree": TreeSort, "patience": PatienceSort,
	"strand": StrandSort, "merge": MergeSort,
}

func inputs(rng *rand.Rand, limit int) [][]int {
	out := [][]int{{}, {1}, {2, 1}}
	for n := 3; n <= limit; n += 7 {
		a := make([]int, n)
		for i := range a {
			a[i] = rng.Intn(21) - 10
		}
		out = append(out, a)
	}
	asc := make([]int, limit)
	for i := range asc {
		asc[i] = i
	}
	desc := make([]int, limit)
	for i := range desc {
		desc[i] = limit - i
	}
	return append(out, asc, desc)
}

func check(t *testing.T, name string, in, got []int) {
	want := append([]int(nil), in...)
	sort.Ints(want)
	for i := range want {
		if got[i] != want[i] {
			t.Fatalf("%s failed on %v: got %v", name, in, got)
		}
	}
}

func TestAllAlgorithms(t *testing.T) {
	rng := rand.New(rand.NewSource(1))
	for name, f := range inPlace {
		limit := 120
		if name == "stooge" {
			limit = 30
		}
		for _, in := range inputs(rng, limit) {
			a := append([]int(nil), in...)
			f(a)
			check(t, name, in, a)
		}
	}
	for name, f := range pure {
		for _, in := range inputs(rng, 120) {
			check(t, name, in, f(append([]int(nil), in...)))
		}
	}
}

func TestSmoothSortLarge(t *testing.T) {
	rng := rand.New(rand.NewSource(2))
	for k := 0; k < 200; k++ {
		a := make([]int, rng.Intn(3000))
		for i := range a {
			a[i] = rng.Intn(500) - 250
		}
		b := append([]int(nil), a...)
		SmoothSort(a)
		check(t, "smooth", b, a)
	}
}
