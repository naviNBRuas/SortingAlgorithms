use rand::{rngs::StdRng, Rng, SeedableRng};
use sorting_algorithms::*;

fn inputs(rng: &mut StdRng, limit: usize) -> Vec<Vec<i32>> {
    let mut out: Vec<Vec<i32>> = vec![vec![], vec![1], vec![2, 1]];
    let mut n = 3;
    while n <= limit {
        out.push((0..n).map(|_| rng.gen_range(-10..=10)).collect());
        n += 7;
    }
    out.push((0..limit as i32).collect());
    out.push((1..=limit as i32).rev().collect());
    out
}

fn sorted(v: &[i32]) -> Vec<i32> {
    let mut s = v.to_vec();
    s.sort();
    s
}

macro_rules! inplace {
    ($rng:expr, $limit:expr, $($f:ident),*) => {$(
        for input in inputs($rng, $limit) {
            let mut a = input.clone();
            $f(&mut a);
            assert_eq!(a, sorted(&input), "{} failed on {:?}", stringify!($f), input);
        }
    )*};
}

macro_rules! pure {
    ($rng:expr, $($f:ident),*) => {$(
        for input in inputs($rng, 120) {
            assert_eq!($f(&input), sorted(&input), "{} failed on {:?}", stringify!($f), input);
        }
    )*};
}

#[test]
fn all_in_place_algorithms() {
    let mut rng = StdRng::seed_from_u64(1);
    inplace!(&mut rng, 120, bubble_sort, selection_sort, insertion_sort, binary_insertion_sort, shell_sort,
        comb_sort, cocktail_shaker_sort, odd_even_sort, pancake_sort, gnome_sort, cycle_sort,
        bitonic_sort, quick_sort, heap_sort, radix_sort_lsd, tim_sort, intro_sort, smooth_sort);
    inplace!(&mut rng, 30, stooge_sort);
}

#[test]
fn all_pure_algorithms() {
    let mut rng = StdRng::seed_from_u64(2);
    pure!(&mut rng, counting_sort, bucket_sort, pigeonhole_sort, bead_sort, tree_sort, patience_sort, strand_sort, merge_sort);
}

#[test]
fn smooth_sort_large() {
    let mut rng = StdRng::seed_from_u64(3);
    for _ in 0..200 {
        let n = rng.gen_range(0..3000);
        let input: Vec<i32> = (0..n).map(|_| rng.gen_range(-250..250)).collect();
        let mut a = input.clone();
        smooth_sort(&mut a);
        assert_eq!(a, sorted(&input));
    }
}
