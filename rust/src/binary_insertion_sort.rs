// GENERATED from kernels/algos/binary_insertion_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn binary_insertion_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut key: i64 = 0;
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut mid: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    i = 1;
    _e1 = n;
    while (i < _e1) {
        key = (a[(i) as usize] as i64);
        lo = 0;
        hi = i;
        while (lo < hi) {
            mid = ((lo + hi) / 2);
            if (key < (a[(mid) as usize] as i64)) {
                hi = mid;
            } else {
                lo = (mid + 1);
            }
        }
        j = i;
        while (j > lo) {
            a[(j) as usize] = ((a[((j - 1)) as usize] as i64)) as i32;
            j = (j - 1);
        }
        a[(lo) as usize] = (key) as i32;
        i = (i + 1);
    }
}

pub fn binary_insertion_sort(a: &mut [i32]) {
    binary_insertion_sort_impl(a, a.len() as i64);
}
