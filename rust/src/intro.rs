use std::f64;

pub fn intro_sort(arr: &mut [i32]) {
    if arr.len() <= 1 {
        return;
    }
    let depth_limit = (2.0 * (arr.len() as f64).ln()) as usize;
    intro_rec(arr, 0, arr.len() - 1, depth_limit);
}

fn intro_rec(arr: &mut [i32], low: usize, high: usize, depth: usize) {
    if high <= low {
        return;
    }
    if high - low <= 16 {
        insertion_range(arr, low, high + 1);
        return;
    }
    if depth == 0 {
        heap_sort_range(arr, low, high);
        return;
    }
    let p = partition(arr, low, high);
    if p > 0 {
        intro_rec(arr, low, p - 1, depth - 1);
    }
    intro_rec(arr, p + 1, high, depth - 1);
}

fn partition(arr: &mut [i32], low: usize, high: usize) -> usize {
    let pivot = arr[high];
    let mut i = low;
    for j in low..high {
        if arr[j] < pivot {
            arr.swap(i, j);
            i += 1;
        }
    }
    arr.swap(i, high);
    i
}

fn heap_sort_range(arr: &mut [i32], low: usize, high: usize) {
    let n = high - low + 1;
    for i in (0..=n / 2).rev() {
        heapify(arr, n, i, low);
    }
    for i in (1..n).rev() {
        arr.swap(low, low + i);
        heapify(arr, i, 0, low);
    }
}

fn heapify(arr: &mut [i32], n: usize, i: usize, offset: usize) {
    let mut largest = i;
    let l = 2 * i + 1;
    let r = 2 * i + 2;
    if l < n && arr[offset + l] > arr[offset + largest] {
        largest = l;
    }
    if r < n && arr[offset + r] > arr[offset + largest] {
        largest = r;
    }
    if largest != i {
        arr.swap(offset + i, offset + largest);
        heapify(arr, n, largest, offset);
    }
}

fn insertion_range(arr: &mut [i32], l: usize, r: usize) {
    for i in l + 1..r {
        let key = arr[i];
        let mut j = i;
        while j > l && arr[j - 1] > key {
            arr[j] = arr[j - 1];
            j -= 1;
        }
        arr[j] = key;
    }
}
