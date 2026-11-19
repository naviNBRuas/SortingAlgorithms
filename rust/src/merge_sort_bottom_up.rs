// GENERATED from kernels/algos/merge_sort_bottom_up.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn merge_sort_bottom_up_impl(a: &mut [i32], mut n: i64) {
    let mut width: i64 = 0;
    let mut lo: i64 = 0;
    let mut mid: i64 = 0;
    let mut hi: i64 = 0;
    let mut x: i64 = 0;
    let mut i: i64 = 0;
    let mut j: i64 = 0;
    let mut k: i64 = 0;
    let mut _e1: i64 = 0;
    let mut tmp_store: Vec<i32> = vec![0; std::cmp::max(1, n) as usize]; let tmp: &mut [i32] = &mut tmp_store[..];
    width = 1;
    while (width < n) {
        lo = 0;
        while (lo < n) {
            mid = std::cmp::min((lo + width), n);
            hi = std::cmp::min((lo + (2 * width)), n);
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
            lo = (lo + (2 * width));
        }
        width = (width * 2);
    }
}

pub fn merge_sort_bottom_up(a: &mut [i32]) {
    merge_sort_bottom_up_impl(a, a.len() as i64);
}
