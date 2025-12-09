pub fn stooge_sort(arr: &mut [i32]) {
    if arr.is_empty() {
        return;
    }
    let len = arr.len();
    stooge_sort_rec(arr, 0, len - 1);
}

fn stooge_sort_rec(arr: &mut [i32], l: usize, h: usize) {
    if l >= h {
        return;
    }
    if arr[l] > arr[h] {
        arr.swap(l, h);
    }
    let len = h - l + 1;
    if len > 2 {
        let t = len / 3;
        stooge_sort_rec(arr, l, h - t);
        stooge_sort_rec(arr, l + t, h);
        stooge_sort_rec(arr, l, h - t);
    }
}
