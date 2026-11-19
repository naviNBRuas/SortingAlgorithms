// GENERATED from kernels/algos/slow_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn slow_sort_x_slow(a: &mut [i32], mut i: i64, mut j: i64) {
    let mut m: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if (i >= j) {
        return;
    }
    m = ((i + j) / 2);
    slow_sort_x_slow(a, i, m);
    slow_sort_x_slow(a, (m + 1), j);
    if ((a[(m) as usize] as i64) > (a[(j) as usize] as i64)) {
        _i1 = m;
        _i2 = j;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
    }
    slow_sort_x_slow(a, i, (j - 1));
}

fn slow_sort_impl(a: &mut [i32], mut n: i64) {
    slow_sort_x_slow(a, 0, (n - 1));
}

pub fn slow_sort(a: &mut [i32]) {
    slow_sort_impl(a, a.len() as i64);
}
