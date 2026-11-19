// GENERATED from kernels/algos/comb_sort.py by kernels/generate.py - do not edit; edit the kernel and regenerate.

fn comb_sort_impl(a: &mut [i32], mut n: i64) {
    let mut gap: i64 = 0;
    let mut swapped: i64 = 0;
    let mut i: i64 = 0;
    let mut _i1: i64 = 0;
    let mut _i2: i64 = 0;
    let mut _t1: i64 = 0;
    gap = n;
    swapped = 1;
    while ((gap > 1) || (swapped == 1)) {
        gap = ((gap * 10) / 13);
        if (gap < 1) {
            gap = 1;
        }
        swapped = 0;
        i = 0;
        while ((i + gap) < n) {
            if ((a[(i) as usize] as i64) > (a[((i + gap)) as usize] as i64)) {
                _i1 = i;
                _i2 = (i + gap);
                _t1 = (a[(_i1) as usize] as i64);
                a[(_i1) as usize] = ((a[(_i2) as usize] as i64)) as i32;
                a[(_i2) as usize] = (_t1) as i32;
                swapped = 1;
            }
            i = (i + 1);
        }
    }
}

pub fn comb_sort(a: &mut [i32]) {
    comb_sort_impl(a, a.len() as i64);
}
