pub fn tim_sort(arr: &mut [i32]) {
    const MIN_RUN: usize = 32;
    let n = arr.len();
    let mut i = 0;
    while i < n {
        let right = usize::min(i + MIN_RUN, n);
        insertion_range(arr, i, right);
        i += MIN_RUN;
    }
    let mut size = MIN_RUN;
    while size < n {
        let mut left = 0;
        while left < n {
            let mid = usize::min(left + size, n);
            let right = usize::min(left + 2 * size, n);
            if mid < right {
                merge_in_place(arr, left, mid, right);
            }
            left += 2 * size;
        }
        size *= 2;
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

fn merge_in_place(arr: &mut [i32], l: usize, m: usize, r: usize) {
    let left = arr[l..m].to_vec();
    let right = arr[m..r].to_vec();
    let mut i = 0;
    let mut j = 0;
    let mut k = l;
    while i < left.len() && j < right.len() {
        if left[i] <= right[j] {
            arr[k] = left[i];
            i += 1;
        } else {
            arr[k] = right[j];
            j += 1;
        }
        k += 1;
    }
    while i < left.len() {
        arr[k] = left[i];
        i += 1;
        k += 1;
    }
    while j < right.len() {
        arr[k] = right[j];
        j += 1;
        k += 1;
    }
}
