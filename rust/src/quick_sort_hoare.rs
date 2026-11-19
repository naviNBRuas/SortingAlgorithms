// GENERATED from kernels/algos/quick_sort_hoare.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn quick_sort_hoare_x_qs(a: &mut [i32], mut lo: i64, mut hi: i64) {
    let mut pivot: i64 = 0;
    let mut i: i64 = 0;
    let mut j: i64 = 0;
    let mut going: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    while (lo < hi) {
        pivot = (a[(((lo + hi) / 2)) as usize] as i64);
        i = (lo - 1);
        j = (hi + 1);
        going = 1;
        while (going == 1) {
            i = (i + 1);
            while ((a[(i) as usize] as i64) < pivot) {
                i = (i + 1);
            }
            j = (j - 1);
            while ((a[(j) as usize] as i64) > pivot) {
                j = (j - 1);
            }
            if (i >= j) {
                going = 0;
            } else {
                _i1 = i;
                _i2 = j;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
            }
        }
        if ((j - lo) < ((hi - j) - 1)) {
            quick_sort_hoare_x_qs(a, lo, j);
            lo = (j + 1);
        } else {
            quick_sort_hoare_x_qs(a, (j + 1), hi);
            hi = j;
        }
    }
}

fn quick_sort_hoare_impl(a: &mut [i32], mut n: i64) {
    quick_sort_hoare_x_qs(a, 0, (n - 1));
}

pub fn quick_sort_hoare(a: &mut [i32]) {
    quick_sort_hoare_impl(a, a.len() as i64);
}
