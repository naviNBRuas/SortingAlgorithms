// GENERATED from kernels/algos/quick_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn quick_sort_x_qs(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut pivot: i64 = 0;
    let mut i: i64 = 0;
    let mut j: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    while (lo < hi) {
        pivot = (a[(hi) as usize] as i64);
        i = lo;
        j = lo;
        while (j < hi) {
            if ((a[(j) as usize] as i64) <= pivot) {
                _i1 = i;
                _i2 = j;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                i = (i + 1);
            }
            j = (j + 1);
        }
        _i1 = i;
        _i2 = hi;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        if ((i - lo) < (hi - i)) {
            quick_sort_x_qs(a, lo, (i - 1));
            lo = (i + 1);
        } else {
            quick_sort_x_qs(a, (i + 1), hi);
            hi = (i - 1);
        }
    }
}

fn quick_sort_impl(a: &mut [i32], mut n: i64) {
    quick_sort_x_qs(a, 0, (n - 1));
}

pub fn quick_sort(a: &mut [i32]) {
    quick_sort_impl(a, a.len() as i64);
}
