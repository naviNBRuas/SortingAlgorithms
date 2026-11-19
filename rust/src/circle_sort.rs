// GENERATED from kernels/algos/circle_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn circle_sort_x_circle_pass(a: &mut [i32], mut lo: i64, mut hi: i64) -> i64 {
    let mut m: i64 = 0;
    let mut swaps: i64 = 0;
    let mut half: i64 = 0;
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    m = (hi - lo);
    if (m < 2) {
        return 0;
    }
    swaps = 0;
    half = (m / 2);
    i = 0;
    while (i < half) {
        if ((a[(((hi - 1) - i)) as usize] as i64) < (a[((lo + i)) as usize] as i64)) {
            _i1 = ((hi - 1) - i);
            _i2 = (lo + i);
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
            swaps = (swaps + 1);
        }
        i = (i + 1);
    }
    if ((m % 2) == 1) {
        if ((a[((lo + half)) as usize] as i64) < (a[(((lo + half) - 1)) as usize] as i64)) {
            _i1 = ((lo + half) - 1);
            _i2 = (lo + half);
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
            swaps = (swaps + 1);
        }
    }
    swaps = (swaps + circle_sort_x_circle_pass(a, lo, (lo + half)));
    swaps = (swaps + circle_sort_x_circle_pass(a, (lo + half), hi));
    return swaps;
}

fn circle_sort_impl(a: &mut [i32], mut n: i64) {
    let mut s: i64 = 0;
    s = 1;
    while (s > 0) {
        s = circle_sort_x_circle_pass(a, 0, n);
    }
}

pub fn circle_sort(a: &mut [i32]) {
    circle_sort_impl(a, a.len() as i64);
}
