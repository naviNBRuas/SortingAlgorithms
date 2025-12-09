pub fn quick_sort(arr: &mut [i32]) {
    if !arr.is_empty() {
        let len = arr.len();
        quick(arr, 0, (len - 1) as isize);
    }
}

fn quick(arr: &mut [i32], lo: isize, hi: isize) {
    if lo < hi {
        let p = partition(arr, lo, hi);
        quick(arr, lo, p - 1);
        quick(arr, p + 1, hi);
    }
}

fn partition(arr: &mut [i32], lo: isize, hi: isize) -> isize {
    let pivot = arr[hi as usize];
    let mut i = lo;
    for j in lo..hi {
        if arr[j as usize] <= pivot {
            arr.swap(i as usize, j as usize);
            i += 1;
        }
    }
    arr.swap(i as usize, hi as usize);
    i
}
