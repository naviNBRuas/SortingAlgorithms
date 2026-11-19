// GENERATED from kernels/algos/stooge_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn stooge_sort_x_st(a: &mut [i32], mut i: i64, mut j: i64) {
    let mut t: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    if ((a[(i) as usize] as i64) > (a[(j) as usize] as i64)) {
        _i1 = i;
        _i2 = j;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
    }
    if (((j - i) + 1) > 2) {
        t = (((j - i) + 1) / 3);
        stooge_sort_x_st(a, i, (j - t));
        stooge_sort_x_st(a, (i + t), j);
        stooge_sort_x_st(a, i, (j - t));
    }
}

fn stooge_sort_impl(a: &mut [i32], mut n: i64) {
    if (n > 1) {
        stooge_sort_x_st(a, 0, (n - 1));
    }
}

pub fn stooge_sort(a: &mut [i32]) {
    stooge_sort_impl(a, a.len() as i64);
}
