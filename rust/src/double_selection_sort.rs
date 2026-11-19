// GENERATED from kernels/algos/double_selection_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn double_selection_sort_impl(a: &mut [i32], mut n: i64) {
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut mn: i64 = 0;
    let mut mx: i64 = 0;
    let mut j: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    lo = 0;
    hi = (n - 1);
    while (lo < hi) {
        mn = lo;
        mx = lo;
        j = (lo + 1);
        while (j <= hi) {
            if ((a[(j) as usize] as i64) < (a[(mn) as usize] as i64)) {
                mn = j;
            } else {
                if ((a[(j) as usize] as i64) > (a[(mx) as usize] as i64)) {
                    mx = j;
                }
            }
            j = (j + 1);
        }
        _i1 = lo;
        _i2 = mn;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        if (mx == lo) {
            mx = mn;
        }
        _i1 = hi;
        _i2 = mx;
        _t1 = (a[(_i1) as usize] as i64);
        a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
        a[(_i2) as usize] = (_t1) as i32;
        lo = (lo + 1);
        hi = (hi - 1);
    }
}

pub fn double_selection_sort(a: &mut [i32]) {
    double_selection_sort_impl(a, a.len() as i64);
}
