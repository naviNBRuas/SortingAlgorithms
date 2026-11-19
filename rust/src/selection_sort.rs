// GENERATED from kernels/algos/selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn selection_sort_impl(a: &mut [i32], mut n: i64) {
    let mut i: i64 = 0;
    let mut m: i64 = 0;
    let mut j: i64 = 0;
    let mut _e1: i64 = 0;
    let mut _e2: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    i = 0;
    _e1 = (n - 1);
    while (i < _e1) {
        m = i;
        j = (i + 1);
        _e2 = n;
        while (j < _e2) {
            if ((a[(j) as usize] as i64) < (a[(m) as usize] as i64)) {
                m = j;
            }
            j = (j + 1);
        }
        if (m != i) {
            _i1 = i;
            _i2 = m;
            _t1 = (a[(_i1) as usize] as i64);
            a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
            a[(_i2) as usize] = (_t1) as i32;
        }
        i = (i + 1);
    }
}

pub fn selection_sort(a: &mut [i32]) {
    selection_sort_impl(a, a.len() as i64);
}
