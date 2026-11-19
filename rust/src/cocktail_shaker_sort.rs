// GENERATED from kernels/algos/cocktail_shaker_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn cocktail_shaker_sort_impl(a: &mut [i32], mut n: i64) {
    let mut lo: i64 = 0;
    let mut hi: i64 = 0;
    let mut swapped: i64 = 0;
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    lo = 0;
    hi = (n - 1);
    swapped = 1;
    while ((lo < hi) && (swapped == 1)) {
        swapped = 0;
        i = lo;
        while (i < hi) {
            if ((a[(i) as usize] as i64) > (a[((i + 1)) as usize] as i64)) {
                _i1 = i;
                _i2 = (i + 1);
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                swapped = 1;
            }
            i = (i + 1);
        }
        hi = (hi - 1);
        i = hi;
        while (i > lo) {
            if ((a[((i - 1)) as usize] as i64) > (a[(i) as usize] as i64)) {
                _i1 = (i - 1);
                _i2 = i;
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                swapped = 1;
            }
            i = (i - 1);
        }
        lo = (lo + 1);
    }
}

pub fn cocktail_shaker_sort(a: &mut [i32]) {
    cocktail_shaker_sort_impl(a, a.len() as i64);
}
