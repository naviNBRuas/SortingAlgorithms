use sorting_algorithms::*;
use rand::seq::SliceRandom;
use rand::thread_rng;

fn main() {
    let mut rng = thread_rng();
    let mut data: Vec<i32> = (0..12).collect();
    data.shuffle(&mut rng);
    println!("original: {:?}", data);

    let mut copy = data.clone();
    bubble_sort(&mut copy);
    println!("bubble     {:?}", copy);

    let mut copy = data.clone();
    selection_sort(&mut copy);
    println!("selection  {:?}", copy);

    let mut copy = data.clone();
    insertion_sort(&mut copy);
    println!("insertion  {:?}", copy);

    let mut copy = data.clone();
    quick_sort(&mut copy);
    println!("quick        {:?}", copy);

    let mut copy = data.clone();
    heap_sort(&mut copy);
    println!("heap         {:?}", copy);

    let mut copy = data.clone();
    shell_sort(&mut copy);
    println!("shell        {:?}", copy);

    let mut copy = data.clone();
    comb_sort(&mut copy);
    println!("comb         {:?}", copy);

    let mut copy = data.clone();
    cocktail_shaker_sort(&mut copy);
    println!("cocktail     {:?}", copy);

    let mut copy = data.clone();
    odd_even_sort(&mut copy);
    println!("odd-even     {:?}", copy);

    let mut copy = data.clone();
    pancake_sort(&mut copy);
    println!("pancake      {:?}", copy);

    let mut copy = data.clone();
    stooge_sort(&mut copy);
    println!("stooge       {:?}", copy);

    let mut copy = data.clone();
    gnome_sort(&mut copy);
    println!("gnome        {:?}", copy);

    let mut copy = data.clone();
    cycle_sort(&mut copy);
    println!("cycle        {:?}", copy);

    let mut copy = data.clone();
    bitonic_sort(&mut copy);
    println!("bitonic      {:?}", copy);

    let mut copy = data.clone();
    radix_sort_lsd(&mut copy);
    println!("radix lsd    {:?}", copy);

    let mut copy = data.clone();
    tim_sort(&mut copy);
    println!("tim          {:?}", copy);

    let mut copy = data.clone();
    intro_sort(&mut copy);
    println!("intro        {:?}", copy);

    let mut copy = data.clone();
    smooth_sort(&mut copy);
    println!("smooth       {:?}", copy);

    let sorted = merge_sort(&data);
    println!("merge (pure) {:?}", sorted);

    let counting = counting_sort(&data);
    println!("counting     {:?}", counting);

    let bucketed = bucket_sort(&data);
    println!("bucket       {:?}", bucketed);

    let pigeons = pigeonhole_sort(&data);
    println!("pigeonhole   {:?}", pigeons);

    let beaded = bead_sort(&data);
    println!("bead         {:?}", beaded);

    let treed = tree_sort(&data);
    println!("tree         {:?}", treed);

    let patienced = patience_sort(&data);
    println!("patience     {:?}", patienced);

    let stranded = strand_sort(&data);
    println!("strand       {:?}", stranded);

    let mut bogo_vec = data.clone();
    let bogo_res = bogo_sort(&mut bogo_vec, 5000);
    println!("bogo result: {:?}, {:?}", bogo_res, bogo_vec);
}
