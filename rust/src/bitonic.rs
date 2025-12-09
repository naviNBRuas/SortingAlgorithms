pub fn bitonic_sort(arr: &mut [i32]) {
    let n = arr.len();
    if n == 0 {
        return;
    }
    bitonic_sort_rec(arr, 0, n, true);
}

fn bitonic_sort_rec(arr: &mut [i32], low: usize, cnt: usize, dir: bool) {
    if cnt <= 1 {
        return;
    }
    let k = cnt / 2;
    bitonic_sort_rec(arr, low, k, true);
    bitonic_sort_rec(arr, low + k, cnt - k, false);
    bitonic_merge(arr, low, cnt, dir);
}

fn bitonic_merge(arr: &mut [i32], low: usize, cnt: usize, dir: bool) {
    if cnt <= 1 {
        return;
    }
    let k = cnt / 2;
    for i in low..(low + k) {
        if i + k < low + cnt {
            let should_swap = (dir && arr[i] > arr[i + k]) || (!dir && arr[i] < arr[i + k]);
            if should_swap {
                arr.swap(i, i + k);
            }
        }
    }
    bitonic_merge(arr, low, k, dir);
    bitonic_merge(arr, low + k, cnt - k, dir);
}
