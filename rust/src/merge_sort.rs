// GENERATED from kernels/algos/merge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn merge_sort_x_rec(a: &mut [i32], tmp: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut mid: i64 = 0;
    let mut x: i64 = 0;
    let mut i: i64 = 0;
    let mut j: i64 = 0;
    let mut k: i64 = 0;
    let mut _e1: i64 = 0;
    if ((hi - lo) < 2) {
        return;
    }
    mid = ((lo + hi) / 2);
    merge_sort_x_rec(a, tmp, lo, mid);
    merge_sort_x_rec(a, tmp, mid, hi);
    x = lo;
    _e1 = mid;
    while (x < _e1) {
        tmp[(x) as usize] = ((a[(x) as usize] as i64)) as i32;
        x = (x + 1);
    }
    i = lo;
    j = mid;
    k = lo;
    while ((i < mid) && (j < hi)) {
        if ((a[(j) as usize] as i64) < (tmp[(i) as usize] as i64)) {
            a[(k) as usize] = ((a[(j) as usize] as i64)) as i32;
            j = (j + 1);
        } else {
            a[(k) as usize] = ((tmp[(i) as usize] as i64)) as i32;
            i = (i + 1);
        }
        k = (k + 1);
    }
    while (i < mid) {
        a[(k) as usize] = ((tmp[(i) as usize] as i64)) as i32;
        i = (i + 1);
        k = (k + 1);
    }
}

fn merge_sort_impl(a: &mut [i32], mut n: i64) {
    let mut tmp_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let tmp: &mut [i32] = &mut tmp_store[..];
    merge_sort_x_rec(a, tmp, 0, n);
}

pub fn merge_sort(a: &mut [i32]) {
    merge_sort_impl(a, a.len() as i64);
}
